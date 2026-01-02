# D&D 3.5 Manager (MVP)

Plataforma Web para gerenciamento de campanhas de Dungeons & Dragons 3.5.

Este projeto visa simplificar a vida de Mestres (DMs) e Jogadores, oferecendo um sistema centralizado para criação de campanhas, gerenciamento de inscrições e definição de regras customizadas.

## 🚀 Funcionalidades

### Gestão de Campanhas
- **Criação de Campanhas**: DMs podem criar campanhas definindo:
  - Título, Descrição e Número Máximo de Jogadores.
  - **Regras de Atributos**: Compra de Pontos (Point Buy), Rolagem de Dados (Dice Roll) ou Matriz Padrão (Standard Array).
  - **Restrições**: Seleção de Raças e Classes permitidas na campanha.
- **Sistema de Inscrição**:
  - Jogadores podem visualizar campanhas abertas e solicitar participação.
  - DMs podem **Aceitar** ou **Rejeitar** solicitações.
- **Status da Campanha**: Controle de fluxo (Aberta -> Fechada -> Ativa -> Finalizada).

### Interface & Experiência
- **Design Moderno**: Interface construída com **Flux UI** e **TailwindCSS**, oferecendo suporte nativo a Dark Mode.
- **Reatividade**: Utilização de **Livewire** para interações dinâmicas sem recarregamento de página.
- **Localização**: Interface 100% traduzida para Português (pt_BR).

### Autenticação
- Sistema robusto de login e registro.
- Integração preparada para autenticação via WhatsApp (Evolution API).

## 🛠️ Stack Tecnológica

- **Backend**: Laravel 11/12, PHP 8.2+
- **Frontend**: Blade, Livewire 3
- **UI Components**: Flux UI (TailwindCSS)
- **Banco de Dados**: SQLite (Desenvolvimento) / MySQL (Produção)
- **Gerenciamento de Pacotes**: Composer, NPM

## 📦 Instalação e Configuração

Siga os passos abaixo para rodar o projeto localmente:

### Pré-requisitos
- PHP 8.2 ou superior
- Composer
- Node.js & NPM

### Passo a Passo

1. **Clone o Repositório**
   ```bash
   git clone git@github.com:JeffersonBSena/ded3_5.git
   cd ded3_5
   ```

2. **Instale as Dependências**
   ```bash
   composer install
   npm install
   ```

3. **Configure o Ambiente**
   Copie o arquivo de exemplo e gere a chave da aplicação:
   ```bash
   cp .env.example .env
   php artisan key:generate
   ```

4. **Banco de Dados**
   Crie o banco de dados e execute as migrações (inclui dados essenciais de D&D 3.5):
   ```bash
   touch database/database.sqlite
   php artisan migrate --seed
   ```

5. **Localização (Opcional)**
   Se necessário, limpe o cache de configuração para aplicar a tradução pt_BR:
   ```bash
   php artisan config:clear
   ```

6. **Inicie o Servidor**
   Em terminais separados, execute:
   ```bash
   npm run dev
   ```
   ```bash
   php artisan serve
   ```

   Acesse: `http://localhost:8000`

## 🤝 Contribuição

Contribuições são bem-vindas! Sinta-se à vontade para abrir Issues ou Pull Requests.

## 📄 Licença

Este projeto é open-source e está licenciado sob a [MIT license](https://opensource.org/licenses/MIT).
