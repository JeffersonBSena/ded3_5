-- Dungeons & Dragons 3.5 Edition Database Schema - V2 (Advanced)
-- Created for 'nativoDeD'

SET FOREIGN_KEY_CHECKS = 0;

-- ==========================================
-- 0. Sources & Meta (Audit)
-- ==========================================

CREATE TABLE sources (
    id INT AUTO_INCREMENT PRIMARY KEY,
    name VARCHAR(100) NOT NULL COMMENT 'e.g. Players Handbook, Dungeon Masters Guide',
    abbreviation VARCHAR(20) NOT NULL COMMENT 'e.g. PHB, DMG, MM',
    publisher VARCHAR(50) DEFAULT 'Wizards of the Coast',
    publication_date DATE
);

-- ==========================================
-- 1. Core Rules - Constants & Enums
-- ==========================================

CREATE TABLE sizes (
    id INT AUTO_INCREMENT PRIMARY KEY,
    name VARCHAR(20) NOT NULL,
    modifier INT NOT NULL COMMENT 'Size modifier to AC/Attack',
    grapple_modifier INT NOT NULL COMMENT 'Size modifier to Grapple',
    hide_modifier INT NOT NULL COMMENT 'Size modifier to Hide skill',
    carrying_capacity_multiplier FLOAT NOT NULL DEFAULT 1.0,
    source_id INT NULL,
    FOREIGN KEY (source_id) REFERENCES sources(id)
);

CREATE TABLE alignments (
    id INT AUTO_INCREMENT PRIMARY KEY,
    name VARCHAR(30) NOT NULL,
    abbreviation VARCHAR(2) NOT NULL,
    description TEXT
);

CREATE TABLE abilities (
    id INT AUTO_INCREMENT PRIMARY KEY,
    name VARCHAR(20) NOT NULL,
    abbreviation VARCHAR(3) NOT NULL,
    description TEXT
);

CREATE TABLE dice_types (
    id INT AUTO_INCREMENT PRIMARY KEY,
    name VARCHAR(4) NOT NULL, -- d4, d6, d8, d10, d12, d20, d100
    sides INT NOT NULL
);

CREATE TABLE damage_types (
    id INT AUTO_INCREMENT PRIMARY KEY,
    name VARCHAR(30) NOT NULL,
    description TEXT
);

CREATE TABLE languages (
    id INT AUTO_INCREMENT PRIMARY KEY,
    name VARCHAR(50) NOT NULL,
    alphabet VARCHAR(30) COMMENT 'Common, Dwarven, Elven, etc.',
    description TEXT
);

CREATE TABLE currencies (
    id INT AUTO_INCREMENT PRIMARY KEY,
    name VARCHAR(20) NOT NULL, -- Platinum, Gold, Silver, Copper
    abbreviation VARCHAR(2) NOT NULL, -- pp, gp, sp, cp
    gold_value DECIMAL(10, 4) NOT NULL COMMENT 'Value relative to 1 GP (e.g. SP=0.1)'
);

-- ==========================================
-- 2. Species / Races
-- ==========================================

CREATE TABLE races (
    id INT AUTO_INCREMENT PRIMARY KEY,
    name VARCHAR(50) NOT NULL,
    size_id INT NOT NULL,
    base_speed INT NOT NULL COMMENT 'Base land speed in feet',
    level_adjustment INT DEFAULT 0 COMMENT 'LA, e.g., Drow +2',
    favored_class_id INT NULL COMMENT 'References classes table (can be specific or null for "Any")',
    description TEXT,
    source_id INT NULL,
    page_number INT NULL,
    FOREIGN KEY (size_id) REFERENCES sizes(id),
    FOREIGN KEY (source_id) REFERENCES sources(id)
);

CREATE TABLE race_ability_adjustments (
    race_id INT NOT NULL,
    ability_id INT NOT NULL,
    adjustment INT NOT NULL COMMENT 'e.g. Elf: Dex +2 (2), Con -2 (-2)',
    PRIMARY KEY (race_id, ability_id),
    FOREIGN KEY (race_id) REFERENCES races(id),
    FOREIGN KEY (ability_id) REFERENCES abilities(id)
);

CREATE TABLE race_languages (
    race_id INT NOT NULL,
    language_id INT NOT NULL,
    is_automatic BOOLEAN DEFAULT TRUE COMMENT 'True=Automatic, False=Bonus',
    PRIMARY KEY (race_id, language_id),
    FOREIGN KEY (race_id) REFERENCES races(id),
    FOREIGN KEY (language_id) REFERENCES languages(id)
);

CREATE TABLE racial_traits (
    id INT AUTO_INCREMENT PRIMARY KEY,
    race_id INT NOT NULL,
    name VARCHAR(100) NOT NULL,
    description TEXT NOT NULL,
    FOREIGN KEY (race_id) REFERENCES races(id)
);

-- ==========================================
-- 3. Classes and Progression
-- ==========================================

CREATE TABLE classes (
    id INT AUTO_INCREMENT PRIMARY KEY,
    name VARCHAR(50) NOT NULL,
    hit_die_id INT NOT NULL,
    skill_points_per_level INT NOT NULL,
    bab_progression_type ENUM('poor', 'medium', 'good') NOT NULL,
    fort_save_progression ENUM('poor', 'good') NOT NULL,
    ref_save_progression ENUM('poor', 'good') NOT NULL,
    will_save_progression ENUM('poor', 'good') NOT NULL,
    spellcasting_ability_id INT NULL,
    description TEXT,
    source_id INT NULL,
    page_number INT NULL,
    FOREIGN KEY (hit_die_id) REFERENCES dice_types(id),
    FOREIGN KEY (spellcasting_ability_id) REFERENCES abilities(id),
    FOREIGN KEY (source_id) REFERENCES sources(id)
);

CREATE TABLE class_levels (
    class_id INT NOT NULL,
    level INT NOT NULL,
    base_attack_bonus INT NOT NULL,
    base_save_fort INT NOT NULL,
    base_save_ref INT NOT NULL,
    base_save_will INT NOT NULL,
    special_abilities TEXT,
    PRIMARY KEY (class_id, level),
    FOREIGN KEY (class_id) REFERENCES classes(id)
);

CREATE TABLE class_features (
    id INT AUTO_INCREMENT PRIMARY KEY,
    class_id INT NOT NULL,
    level_acquired INT NOT NULL,
    name VARCHAR(100) NOT NULL,
    description TEXT,
    FOREIGN KEY (class_id) REFERENCES classes(id)
);

CREATE TABLE class_starting_gold (
    class_id INT NOT NULL,
    dice_roll VARCHAR(20) NOT NULL COMMENT 'e.g. 4d4',
    multiplier INT DEFAULT 10 COMMENT 'Multiply roll by this (usually 10 for GP)',
    FOREIGN KEY (class_id) REFERENCES classes(id)
);

-- ==========================================
-- 4. Skills, Feats & Prerequisites
-- ==========================================

CREATE TABLE skills (
    id INT AUTO_INCREMENT PRIMARY KEY,
    name VARCHAR(50) NOT NULL,
    key_ability_id INT NULL,
    trained_only BOOLEAN DEFAULT FALSE,
    armor_check_penalty BOOLEAN DEFAULT FALSE,
    description TEXT,
    synergy_text TEXT,
    source_id INT NULL,
    FOREIGN KEY (key_ability_id) REFERENCES abilities(id),
    FOREIGN KEY (source_id) REFERENCES sources(id)
);

CREATE TABLE class_skills (
    class_id INT NOT NULL,
    skill_id INT NOT NULL,
    PRIMARY KEY (class_id, skill_id),
    FOREIGN KEY (class_id) REFERENCES classes(id),
    FOREIGN KEY (skill_id) REFERENCES skills(id)
);

CREATE TABLE feat_types (
    id INT AUTO_INCREMENT PRIMARY KEY,
    name VARCHAR(30) NOT NULL
);

CREATE TABLE feats (
    id INT AUTO_INCREMENT PRIMARY KEY,
    name VARCHAR(50) NOT NULL,
    feat_type_id INT NOT NULL,
    prerequisites_text TEXT,
    benefit TEXT NOT NULL,
    normal TEXT,
    special TEXT,
    source_id INT NULL,
    page_number INT NULL,
    FOREIGN KEY (feat_type_id) REFERENCES feat_types(id),
    FOREIGN KEY (source_id) REFERENCES sources(id)
);

-- Structured Prerequisites (Advanced Builder Support)
CREATE TABLE prerequisites (
    id INT AUTO_INCREMENT PRIMARY KEY,
    parent_entity_type ENUM('Feat', 'PrestigeClass', 'Item') NOT NULL,
    parent_entity_id INT NOT NULL,
    req_type ENUM('Ability', 'Feat', 'BAB', 'SkillRank', 'Race', 'CasterLevel', 'Special') NOT NULL,
    req_value VARCHAR(100) NOT NULL COMMENT 'e.g. "13" for Ability, "Power Attack" for Feat (or FeatID)',
    req_details VARCHAR(50) NULL COMMENT 'e.g. "STR" for Ability, "Move Silently" for Skill',
    operator VARCHAR(20) DEFAULT '>=' COMMENT '>=, =, HAS_FEAT',
    INDEX (parent_entity_type, parent_entity_id)
);

-- ==========================================
-- 5. Magic, Religion & Deities
-- ==========================================

CREATE TABLE magic_schools (
    id INT AUTO_INCREMENT PRIMARY KEY,
    name VARCHAR(30) NOT NULL,
    description TEXT
);

CREATE TABLE spell_components (
    id INT AUTO_INCREMENT PRIMARY KEY,
    code VARCHAR(5) NOT NULL,
    name VARCHAR(50) NOT NULL,
    description TEXT
);

CREATE TABLE spells (
    id INT AUTO_INCREMENT PRIMARY KEY,
    name VARCHAR(100) NOT NULL,
    school_id INT NOT NULL,
    subschool VARCHAR(50),
    descriptors VARCHAR(100),
    casting_time VARCHAR(50) NOT NULL,
    range_text VARCHAR(50) NOT NULL,
    area_target_effect_text VARCHAR(100),
    duration VARCHAR(50) NOT NULL,
    saving_throw VARCHAR(50),
    spell_resistance BOOLEAN DEFAULT TRUE,
    description TEXT NOT NULL,
    source_id INT NULL,
    page_number INT NULL,
    FOREIGN KEY (school_id) REFERENCES magic_schools(id),
    FOREIGN KEY (source_id) REFERENCES sources(id)
);

CREATE TABLE class_spell_lists (
    class_id INT NOT NULL,
    spell_id INT NOT NULL,
    spell_level INT NOT NULL,
    PRIMARY KEY (class_id, spell_id),
    FOREIGN KEY (class_id) REFERENCES classes(id),
    FOREIGN KEY (spell_id) REFERENCES spells(id)
);

-- NEW: Spell Slots Progression (Slots per day)
CREATE TABLE class_spell_slots (
    class_id INT NOT NULL,
    level INT NOT NULL,
    spell_level INT NOT NULL COMMENT '0-9',
    base_slots INT NOT NULL,
    PRIMARY KEY (class_id, level, spell_level),
    FOREIGN KEY (class_id) REFERENCES classes(id)
);

-- NEW: Spells Known Progression (For Bards/Sorcerers)
CREATE TABLE class_spells_known_progression (
    class_id INT NOT NULL,
    level INT NOT NULL,
    spell_level INT NOT NULL,
    spells_known INT NOT NULL,
    PRIMARY KEY (class_id, level, spell_level),
    FOREIGN KEY (class_id) REFERENCES classes(id)
);

CREATE TABLE spell_component_requirements (
    spell_id INT NOT NULL,
    component_id INT NOT NULL,
    details VARCHAR(100),
    PRIMARY KEY (spell_id, component_id),
    FOREIGN KEY (spell_id) REFERENCES spells(id),
    FOREIGN KEY (component_id) REFERENCES spell_components(id)
);

CREATE TABLE domains (
    id INT AUTO_INCREMENT PRIMARY KEY,
    name VARCHAR(50) NOT NULL,
    granted_power TEXT,
    source_id INT NULL,
    FOREIGN KEY (source_id) REFERENCES sources(id)
);

CREATE TABLE domain_spells (
    domain_id INT NOT NULL,
    spell_level INT NOT NULL,
    spell_id INT NOT NULL,
    PRIMARY KEY (domain_id, spell_level),
    FOREIGN KEY (domain_id) REFERENCES domains(id),
    FOREIGN KEY (spell_id) REFERENCES spells(id)
);

CREATE TABLE deities (
    id INT AUTO_INCREMENT PRIMARY KEY,
    name VARCHAR(50) NOT NULL,
    alignment_id INT NOT NULL,
    description TEXT,
    favored_weapon_id INT NULL, -- Ideally FK to items(id) or weapons
    source_id INT NULL,
    FOREIGN KEY (alignment_id) REFERENCES alignments(id),
    FOREIGN KEY (source_id) REFERENCES sources(id)
);

CREATE TABLE deity_domains (
    deity_id INT NOT NULL,
    domain_id INT NOT NULL,
    PRIMARY KEY (deity_id, domain_id),
    FOREIGN KEY (deity_id) REFERENCES deities(id),
    FOREIGN KEY (domain_id) REFERENCES domains(id)
);

-- ==========================================
-- 6. Items, Equipment & Economy
-- ==========================================

CREATE TABLE item_types (
    id INT AUTO_INCREMENT PRIMARY KEY,
    name VARCHAR(30) NOT NULL
);

CREATE TABLE items (
    id INT AUTO_INCREMENT PRIMARY KEY,
    name VARCHAR(100) NOT NULL,
    item_type_id INT NOT NULL,
    cost_gp DECIMAL(10, 2) NOT NULL,
    weight_lb DECIMAL(10, 2) NOT NULL,
    description TEXT,
    source_id INT NULL,
    page_number INT NULL,
    FOREIGN KEY (item_type_id) REFERENCES item_types(id),
    FOREIGN KEY (source_id) REFERENCES sources(id)
);

CREATE TABLE weapons (
    item_id INT PRIMARY KEY,
    damage_dice_id INT NOT NULL,
    num_dice INT DEFAULT 1,
    critical_range VARCHAR(20) DEFAULT '20',
    damage_type_id INT NOT NULL,
    range_increment INT NULL,
    category ENUM('Simple', 'Martial', 'Exotic') NOT NULL,
    light_one_two_handed ENUM('Light', 'One-Handed', 'Two-Handed') NOT NULL,
    FOREIGN KEY (item_id) REFERENCES items(id),
    FOREIGN KEY (damage_dice_id) REFERENCES dice_types(id),
    FOREIGN KEY (damage_type_id) REFERENCES damage_types(id)
);

CREATE TABLE armor (
    item_id INT PRIMARY KEY,
    armor_bonus INT NOT NULL,
    max_dex_bonus INT NULL,
    armor_check_penalty INT DEFAULT 0,
    arcane_spell_failure INT DEFAULT 0,
    speed_30 INT NOT NULL,
    speed_20 INT NOT NULL,
    category ENUM('Light', 'Medium', 'Heavy', 'Shield') NOT NULL,
    FOREIGN KEY (item_id) REFERENCES items(id)
);

CREATE TABLE item_properties (
    id INT AUTO_INCREMENT PRIMARY KEY,
    name VARCHAR(50) NOT NULL,
    description TEXT
);

-- ==========================================
-- 7. Advanced Rules (Combat, Physics, Modifiers)
-- ==========================================

CREATE TABLE carrying_capacity (
    strength_score INT PRIMARY KEY,
    light_load INT NOT NULL, -- lbs
    medium_load INT NOT NULL,
    heavy_load INT NOT NULL
);

CREATE TABLE rule_blocks (
    id INT AUTO_INCREMENT PRIMARY KEY,
    slug VARCHAR(50) UNIQUE NOT NULL, -- e.g. 'combat-actions-standard'
    category VARCHAR(50) NOT NULL, -- 'Combat', 'Movement', 'Environment'
    title VARCHAR(100) NOT NULL,
    content TEXT NOT NULL COMMENT 'Markdown content',
    source_id INT NULL,
    FOREIGN KEY (source_id) REFERENCES sources(id)
);

CREATE TABLE conditions (
    id INT AUTO_INCREMENT PRIMARY KEY,
    name VARCHAR(50) NOT NULL, -- Prone, Dazed, Blinded
    description TEXT NOT NULL
);

CREATE TABLE combat_actions (
    id INT AUTO_INCREMENT PRIMARY KEY,
    name VARCHAR(50) NOT NULL, -- Bull Rush, Charge, Disarm
    action_type ENUM('Standard', 'Move', 'Full-Round', 'Free', 'Immediate', 'Swift') NOT NULL,
    provokes_aoo BOOLEAN DEFAULT FALSE,
    description TEXT
);

CREATE TABLE modifiers (
    id INT AUTO_INCREMENT PRIMARY KEY,
    source_type ENUM('Race', 'Feat', 'Item', 'ClassFeature', 'Condition', 'Spell') NOT NULL,
    source_id INT NOT NULL, -- ID relative to source_type tables
    target_stat VARCHAR(50) NOT NULL, -- 'STR', 'AC', 'Skill:Hide', 'Save:Fort'
    modifier_type VARCHAR(30) NOT NULL DEFAULT 'Untyped', -- 'Enhancement', 'Luck', 'Insight'
    value INT NOT NULL,
    condition_text VARCHAR(100) NULL COMMENT 'e.g. "vs Giants" or "while raging"'
);

-- ==========================================
-- 8. Character Data (Advanced)
-- ==========================================

CREATE TABLE characters (
    id INT AUTO_INCREMENT PRIMARY KEY,
    player_name VARCHAR(50),
    character_name VARCHAR(50) NOT NULL,
    race_id INT NOT NULL,
    alignment_id INT NOT NULL,
    gender VARCHAR(20),
    height VARCHAR(20),
    weight VARCHAR(20),
    age INT,
    experience_points INT DEFAULT 0,
    hp_current INT NOT NULL,
    hp_max INT NOT NULL,
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    FOREIGN KEY (race_id) REFERENCES races(id),
    FOREIGN KEY (alignment_id) REFERENCES alignments(id)
);

-- Builders Log: Track history
CREATE TABLE character_level_history (
    id INT AUTO_INCREMENT PRIMARY KEY,
    character_id INT NOT NULL,
    level_number INT NOT NULL, -- 1, 2, 3...
    class_id INT NOT NULL, -- Class taken at this level
    hp_roll INT NOT NULL,
    skill_points_spent INT NOT NULL DEFAULT 0,
    FOREIGN KEY (character_id) REFERENCES characters(id),
    FOREIGN KEY (class_id) REFERENCES classes(id)
);

CREATE TABLE character_classes (
    character_id INT NOT NULL,
    class_id INT NOT NULL,
    level INT NOT NULL,
    PRIMARY KEY (character_id, class_id),
    FOREIGN KEY (character_id) REFERENCES characters(id),
    FOREIGN KEY (class_id) REFERENCES classes(id)
);

CREATE TABLE character_abilities (
    character_id INT NOT NULL,
    ability_id INT NOT NULL,
    base_score INT NOT NULL,
    temp_score INT NULL,
    PRIMARY KEY (character_id, ability_id),
    FOREIGN KEY (character_id) REFERENCES characters(id),
    FOREIGN KEY (ability_id) REFERENCES abilities(id)
);

CREATE TABLE character_skills (
    character_id INT NOT NULL,
    skill_id INT NOT NULL,
    ranks FLOAT NOT NULL DEFAULT 0,
    misc_modifier INT DEFAULT 0,
    PRIMARY KEY (character_id, skill_id),
    FOREIGN KEY (character_id) REFERENCES characters(id),
    FOREIGN KEY (skill_id) REFERENCES skills(id)
);

CREATE TABLE character_feats (
    character_id INT NOT NULL,
    feat_id INT NOT NULL,
    note VARCHAR(100),
    level_acquired INT NULL COMMENT 'Which character level (1-20) this was taken',
    PRIMARY KEY (character_id, feat_id),
    FOREIGN KEY (character_id) REFERENCES characters(id),
    FOREIGN KEY (feat_id) REFERENCES feats(id)
);

CREATE TABLE character_spells_known (
    character_id INT NOT NULL,
    spell_id INT NOT NULL,
    PRIMARY KEY (character_id, spell_id),
    FOREIGN KEY (character_id) REFERENCES characters(id),
    FOREIGN KEY (spell_id) REFERENCES spells(id)
);

CREATE TABLE character_spells_prepared (
    id INT AUTO_INCREMENT PRIMARY KEY,
    character_id INT NOT NULL,
    spell_id INT NOT NULL,
    is_cast BOOLEAN DEFAULT FALSE,
    FOREIGN KEY (character_id) REFERENCES characters(id),
    FOREIGN KEY (spell_id) REFERENCES spells(id)
);

CREATE TABLE character_inventory (
    id INT AUTO_INCREMENT PRIMARY KEY,
    character_id INT NOT NULL,
    item_id INT NOT NULL,
    quantity INT DEFAULT 1,
    is_equipped BOOLEAN DEFAULT FALSE,
    location VARCHAR(50) DEFAULT 'Carried',
    FOREIGN KEY (character_id) REFERENCES characters(id),
    FOREIGN KEY (item_id) REFERENCES items(id)
);

-- Character Languages
CREATE TABLE character_languages (
    character_id INT NOT NULL,
    language_id INT NOT NULL,
    PRIMARY KEY (character_id, language_id),
    FOREIGN KEY (character_id) REFERENCES characters(id),
    FOREIGN KEY (language_id) REFERENCES languages(id)
);

SET FOREIGN_KEY_CHECKS = 1;

-- ==========================================
-- Chapter 1: Abilities (Lookup Tables)
-- ==========================================

-- Tabela 1-1: Modificadores de Habilidade e Magias Adicionais
CREATE TABLE ability_score_lookup (
    score INT PRIMARY KEY,
    modifier INT NOT NULL,
    bonus_spells_1st INT DEFAULT 0,
    bonus_spells_2nd INT DEFAULT 0,
    bonus_spells_3rd INT DEFAULT 0,
    bonus_spells_4th INT DEFAULT 0,
    bonus_spells_5th INT DEFAULT 0,
    bonus_spells_6th INT DEFAULT 0,
    bonus_spells_7th INT DEFAULT 0,
    bonus_spells_8th INT DEFAULT 0,
    bonus_spells_9th INT DEFAULT 0
);
