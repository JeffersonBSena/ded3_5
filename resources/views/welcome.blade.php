<!DOCTYPE html>
<html lang="{{ str_replace('_', '-', app()->getLocale()) }}">
    <head>
        <meta charset="utf-8">
        <meta name="viewport" content="width=device-width, initial-scale=1">
        <title>D&D 3.5 - Entre no Reino</title>

        <link rel="apple-touch-icon" sizes="180x180" href="/favicon_io/apple-touch-icon.png">
        <link rel="icon" type="image/png" sizes="32x32" href="/favicon_io/favicon-32x32.png">
        <link rel="icon" type="image/png" sizes="16x16" href="/favicon_io/favicon-16x16.png">
        <link rel="manifest" href="/favicon_io/site.webmanifest">
        <link rel="shortcut icon" href="/favicon_io/favicon.ico">

        <!-- Fonts -->
        <link rel="preconnect" href="https://fonts.googleapis.com">
        <link rel="preconnect" href="https://fonts.gstatic.com" crossorigin>
        <link href="https://fonts.googleapis.com/css2?family=Cinzel:wght@400;600;700;900&family=Crimson+Text:ital,wght@0,400;0,600;1,400&display=swap" rel="stylesheet">

        <style>
            * {
                margin: 0;
                padding: 0;
                box-sizing: border-box;
            }

            :root {
                --burgundy: #8B0000;
                --dark-gold: #B8860B;
                --mystical-purple: #4B0082;
                --ember-orange: #FF4500;
                --dark-stone: #1a1a1a;
                --aged-parchment: #F4E4C1;
                --shadow-black: rgba(0, 0, 0, 0.8);
            }

            body {
                font-family: 'Crimson Text', serif;
                background: var(--dark-stone);
                color: var(--aged-parchment);
                overflow-x: hidden;
                min-height: 100vh;
            }

            /* Background Layer */
            .background-container {
                position: fixed;
                top: 0;
                left: 0;
                width: 100%;
                height: 100%;
                z-index: 0;
                overflow: hidden;
            }

            .background-video {
                width: 110%;
                height: 110%;
                object-fit: cover;
                filter: brightness(0.4) contrast(1.2);
                position: absolute;
                top: -5%;
                left: -5%;
                transition: transform 0.3s ease-out;
                will-change: transform;
            }

            .background-overlay {
                position: absolute;
                top: 0;
                left: 0;
                width: 100%;
                height: 100%;
                background: linear-gradient(
                    180deg,
                    rgba(26, 26, 26, 0.4) 0%,
                    rgba(75, 0, 130, 0.15) 50%,
                    rgba(139, 0, 0, 0.2) 100%
                );
            }

            /* Particle Effects */
            .particles {
                position: absolute;
                top: 0;
                left: 0;
                width: 100%;
                height: 100%;
                overflow: hidden;
                pointer-events: none;
                transition: transform 0.2s ease-out;
                will-change: transform;
            }

            .particle {
                position: absolute;
                width: 3px;
                height: 3px;
                background: var(--ember-orange);
                border-radius: 50%;
                opacity: 0;
                animation: float-up 8s infinite ease-in-out;
                box-shadow: 0 0 10px var(--ember-orange);
            }

            @keyframes float-up {
                0% {
                    transform: translateY(100vh) translateX(0);
                    opacity: 0;
                }
                10% {
                    opacity: 1;
                }
                90% {
                    opacity: 1;
                }
                100% {
                    transform: translateY(-100px) translateX(50px);
                    opacity: 0;
                }
            }

            /* Generate particles with random delays and positions */
            .particle:nth-child(1) { left: 10%; animation-delay: 0s; }
            .particle:nth-child(2) { left: 20%; animation-delay: 1s; }
            .particle:nth-child(3) { left: 30%; animation-delay: 2s; }
            .particle:nth-child(4) { left: 40%; animation-delay: 3s; }
            .particle:nth-child(5) { left: 50%; animation-delay: 4s; }
            .particle:nth-child(6) { left: 60%; animation-delay: 5s; }
            .particle:nth-child(7) { left: 70%; animation-delay: 6s; }
            .particle:nth-child(8) { left: 80%; animation-delay: 7s; }
            .particle:nth-child(9) { left: 90%; animation-delay: 1.5s; }
            .particle:nth-child(10) { left: 15%; animation-delay: 3.5s; }

            /* Main Content */
            .content-wrapper {
                position: relative;
                z-index: 1;
                min-height: 100vh;
                display: flex;
                flex-direction: column;
                align-items: center;
                justify-content: center;
                padding: 2rem;
            }

            /* Navigation Header */
            .nav-header {
                position: fixed;
                top: 0;
                left: 0;
                right: 0;
                z-index: 100;
                padding: 1.5rem 2rem;
                display: flex;
                justify-content: flex-end;
                background: linear-gradient(180deg, rgba(26, 26, 26, 0.9) 0%, transparent 100%);
            }

            .nav-button {
                font-family: 'Cinzel', serif;
                font-size: 0.9rem;
                font-weight: 600;
                padding: 0.75rem 2rem;
                background: linear-gradient(135deg, 
                    rgba(184, 134, 11, 0.15) 0%, 
                    rgba(255, 215, 0, 0.1) 100%);
                border: 1px solid rgba(184, 134, 11, 0.5);
                color: var(--dark-gold);
                text-decoration: none;
                border-radius: 8px;
                transition: all 0.3s cubic-bezier(0.4, 0, 0.2, 1);
                text-transform: uppercase;
                letter-spacing: 1.5px;
                backdrop-filter: blur(15px) saturate(180%);
                -webkit-backdrop-filter: blur(15px) saturate(180%);
                box-shadow: 
                    0 4px 16px rgba(0, 0, 0, 0.3),
                    inset 0 1px 0 rgba(255, 255, 255, 0.1);
            }

            .nav-button:hover {
                background: linear-gradient(135deg, 
                    rgba(184, 134, 11, 0.9) 0%, 
                    rgba(255, 215, 0, 0.8) 100%);
                color: var(--dark-stone);
                border-color: rgba(255, 215, 0, 0.8);
                box-shadow: 
                    0 6px 24px rgba(0, 0, 0, 0.4),
                    0 0 30px rgba(184, 134, 11, 0.6),
                    inset 0 1px 0 rgba(255, 255, 255, 0.2);
                transform: translateY(-3px);
            }

            /* Hero Section */
            .hero-container {
                max-width: 900px;
                width: 100%;
                text-align: center;
                animation: fadeInUp 1s ease-out;
            }

            @keyframes fadeInUp {
                from {
                    opacity: 0;
                    transform: translateY(30px);
                }
                to {
                    opacity: 1;
                    transform: translateY(0);
                }
            }

            /* Logo SVG */
            .game-logo {
                width: 100%;
                max-width: clamp(300px, 80vw, 700px);
                height: auto;
                margin: 0 auto 1rem;
                display: block;
                filter: drop-shadow(0 0 20px rgba(184, 134, 11, 0.8))
                        drop-shadow(0 0 40px rgba(184, 134, 11, 0.5))
                        drop-shadow(2px 2px 8px rgba(0, 0, 0, 0.8));
                animation: logoGlow 2s ease-in-out infinite alternate;
                position: relative;
            }

            @keyframes logoGlow {
                from {
                    filter: drop-shadow(0 0 20px rgba(184, 134, 11, 0.8))
                            drop-shadow(0 0 40px rgba(184, 134, 11, 0.5))
                            drop-shadow(2px 2px 8px rgba(0, 0, 0, 0.8));
                }
                to {
                    filter: drop-shadow(0 0 30px rgba(184, 134, 11, 1))
                            drop-shadow(0 0 60px rgba(184, 134, 11, 0.7))
                            drop-shadow(3px 3px 10px rgba(0, 0, 0, 0.9));
                }
            }

            .game-subtitle {
                font-family: 'Cinzel', serif;
                font-size: clamp(1.4rem, 3.5vw, 2.2rem);
                font-weight: 600;
                text-transform: uppercase;
                letter-spacing: 8px;
                color: transparent;
                background: linear-gradient(90deg, 
                    #8B6914 0%, 
                    #FFD700 25%, 
                    #FFF8DC 50%, 
                    #FFD700 75%, 
                    #8B6914 100%);
                background-size: 200% auto;
                -webkit-background-clip: text;
                background-clip: text;
                animation: shimmerText 3s linear infinite;
                margin-bottom: 2.5rem;
                position: relative;
                padding-bottom: 1.5rem;
            }

            .game-subtitle::after {
                content: '';
                position: absolute;
                bottom: 0;
                left: 50%;
                transform: translateX(-50%);
                width: 120px;
                height: 2px;
                background: linear-gradient(90deg, 
                    transparent, 
                    rgba(255, 215, 0, 0.8), 
                    transparent);
            }

            @keyframes shimmerText {
                0% { background-position: 200% center; }
                100% { background-position: -200% center; }
            }

            /* Ornate Frame - Premium Glassmorphism */
            .ornate-frame {
                position: relative;
                padding: 3.5rem 3rem;
                background: linear-gradient(165deg, 
                    rgba(20, 15, 10, 0.85) 0%,
                    rgba(35, 25, 15, 0.9) 30%,
                    rgba(25, 18, 10, 0.85) 70%,
                    rgba(20, 15, 10, 0.9) 100%);
                border-radius: 24px;
                backdrop-filter: blur(30px) saturate(200%) brightness(1.1);
                -webkit-backdrop-filter: blur(30px) saturate(200%) brightness(1.1);
                box-shadow: 
                    0 25px 60px rgba(0, 0, 0, 0.7),
                    0 0 0 1px rgba(255, 215, 0, 0.15),
                    0 0 100px rgba(184, 134, 11, 0.15),
                    inset 0 1px 0 rgba(255, 255, 255, 0.08),
                    inset 0 -1px 0 rgba(0, 0, 0, 0.4);
                margin-bottom: 2rem;
                overflow: visible;
                animation: floatContainer 6s ease-in-out infinite;
            }

            @keyframes floatContainer {
                0%, 100% { transform: translateY(0); }
                50% { transform: translateY(-8px); }
            }

            /* Animated border glow */
            .ornate-frame::before {
                content: '';
                position: absolute;
                top: -2px;
                left: -2px;
                right: -2px;
                bottom: -2px;
                border-radius: 26px;
                background: linear-gradient(45deg, 
                    #FFD700 0%, 
                    #B8860B 20%, 
                    transparent 40%,
                    transparent 60%,
                    #B8860B 80%, 
                    #FFD700 100%);
                background-size: 400% 400%;
                animation: borderGlow 8s ease infinite;
                z-index: -1;
                opacity: 0.6;
            }

            @keyframes borderGlow {
                0% { background-position: 0% 50%; }
                50% { background-position: 100% 50%; }
                100% { background-position: 0% 50%; }
            }

            /* Inner glass reflection */
            .ornate-frame::after {
                content: '';
                position: absolute;
                top: 0;
                left: 0;
                right: 0;
                height: 50%;
                border-radius: 24px 24px 100px 100px;
                background: linear-gradient(180deg, 
                    rgba(255, 255, 255, 0.06) 0%, 
                    transparent 100%);
                pointer-events: none;
            }



            /* Corner decorations - Magical Runes */
            .corner-decoration {
                position: absolute;
                width: 80px;
                height: 80px;
                z-index: 10;
                opacity: 0.9;
            }

            .corner-decoration::before {
                content: '';
                position: absolute;
                width: 100%;
                height: 100%;
                background: radial-gradient(circle at center, 
                    rgba(255, 215, 0, 0.4) 0%,
                    rgba(184, 134, 11, 0.2) 30%,
                    transparent 70%);
                animation: runeGlow 2s ease-in-out infinite alternate;
            }

            .corner-decoration::after {
                content: '✧';
                position: absolute;
                top: 50%;
                left: 50%;
                transform: translate(-50%, -50%);
                font-size: 24px;
                color: rgba(255, 215, 0, 0.7);
                text-shadow: 0 0 15px rgba(255, 215, 0, 0.8);
                animation: runeSpin 10s linear infinite;
            }

            @keyframes runeGlow {
                0% { opacity: 0.6; transform: scale(1); }
                100% { opacity: 1; transform: scale(1.1); }
            }

            @keyframes runeSpin {
                0% { transform: translate(-50%, -50%) rotate(0deg); }
                100% { transform: translate(-50%, -50%) rotate(360deg); }
            }

            .corner-decoration.top-right {
                top: 10px;
                right: 10px;
            }

            .corner-decoration.top-right::after {
                content: '☆';
            }

            .corner-decoration.bottom-left {
                bottom: 10px;
                left: 10px;
            }

            .corner-decoration.bottom-left::after {
                content: '✦';
            }

            /* Login Button */
            .login-button-container {
                margin: 2rem 0;
            }

            .login-button {
                position: relative;
                display: inline-flex;
                align-items: center;
                justify-content: center;
                gap: 1rem;
                font-family: 'Cinzel', serif;
                font-size: clamp(1.2rem, 3vw, 1.8rem);
                font-weight: 700;
                padding: 1.5rem 4rem;
                background: linear-gradient(135deg, 
                    rgba(139, 0, 0, 0.9) 0%, 
                    rgba(75, 0, 130, 0.9) 50%,
                    rgba(139, 0, 0, 0.9) 100%);
                border: 2px solid transparent;
                color: var(--aged-parchment);
                text-decoration: none;
                text-transform: uppercase;
                letter-spacing: 3px;
                border-radius: 12px;
                cursor: pointer;
                transition: all 0.4s cubic-bezier(0.4, 0, 0.2, 1);
                backdrop-filter: blur(10px);
                -webkit-backdrop-filter: blur(10px);
                box-shadow: 
                    0 0 0 1px rgba(184, 134, 11, 0.5),
                    0 8px 32px rgba(0, 0, 0, 0.6),
                    0 0 60px rgba(184, 134, 11, 0.3),
                    inset 0 1px 0 rgba(255, 255, 255, 0.2),
                    inset 0 -1px 0 rgba(0, 0, 0, 0.5);
                overflow: hidden;
            }

            .login-button::after {
                content: '';
                position: absolute;
                top: 0;
                left: 0;
                right: 0;
                height: 50%;
                background: linear-gradient(180deg, 
                    rgba(255, 255, 255, 0.15) 0%, 
                    transparent 100%);
                border-radius: 12px 12px 0 0;
                pointer-events: none;
            }

            .login-button::before {
                content: '';
                position: absolute;
                top: 0;
                left: -100%;
                width: 100%;
                height: 100%;
                background: linear-gradient(90deg, 
                    transparent, 
                    rgba(255, 215, 0, 0.3), 
                    transparent);
                transition: left 0.6s cubic-bezier(0.4, 0, 0.2, 1);
                z-index: 1;
            }

            .login-button:hover::before {
                left: 100%;
            }

            .login-button > * {
                position: relative;
                z-index: 2;
            }

            .login-button:hover {
                transform: translateY(-8px) scale(1.05);
                box-shadow: 
                    0 0 0 1px rgba(255, 215, 0, 0.8),
                    0 12px 48px rgba(0, 0, 0, 0.7),
                    0 0 80px rgba(184, 134, 11, 0.6),
                    inset 0 1px 0 rgba(255, 255, 255, 0.3),
                    inset 0 -1px 0 rgba(0, 0, 0, 0.5);
                background: linear-gradient(135deg, 
                    rgba(139, 0, 0, 1) 0%, 
                    rgba(75, 0, 130, 1) 50%,
                    rgba(139, 0, 0, 1) 100%);
            }

            .login-button:active {
                transform: translateY(-2px) scale(1.02);
            }

            .shield-icon {
                width: 32px;
                height: 32px;
                filter: drop-shadow(0 0 10px rgba(184, 134, 11, 0.8));
            }

            /* Description Text */
            .description {
                font-family: 'Crimson Text', serif;
                font-size: clamp(0.85rem, 2vw, 1rem);
                line-height: 1.6;
                color: rgba(244, 228, 193, 0.65);
                max-width: 500px;
                margin: 0 auto 1rem;
                font-style: italic;
            }

            /* Divider */
            .divider {
                width: 200px;
                height: 2px;
                background: linear-gradient(90deg, transparent, var(--dark-gold), transparent);
                margin: 2rem auto;
                position: relative;
            }

            .divider::before {
                content: '⚔';
                position: absolute;
                top: 50%;
                left: 50%;
                transform: translate(-50%, -50%);
                font-size: 1.5rem;
                color: var(--dark-gold);
                background: var(--dark-stone);
                padding: 0 1rem;
            }

            /* Responsive Design */
            @media (max-width: 768px) {
                .nav-header {
                    padding: 1rem;
                }

                .nav-button {
                    padding: 0.6rem 1.5rem;
                    font-size: 0.8rem;
                }

                .ornate-frame {
                    padding: 2rem 1rem;
                }

                .login-button {
                    padding: 1.2rem 2.5rem;
                    font-size: 1.2rem;
                }

                .corner-decoration,
                .ornate-frame::before,
                .ornate-frame::after {
                    width: 30px;
                    height: 30px;
                }
            }

            @media (max-width: 480px) {
                .content-wrapper {
                    padding: 1rem;
                }

                .game-title {
                    letter-spacing: 1px;
                }

                .login-button {
                    padding: 1rem 2rem;
                    width: 100%;
                    max-width: 300px;
                }

                .shield-icon {
                    width: 24px;
                    height: 24px;
                }
            }

            /* Torch Flame Animation */
            @keyframes flicker {
                0%, 100% { opacity: 1; }
                50% { opacity: 0.8; }
            }

            .flame-effect {
                animation: flicker 0.15s infinite;
            }
        </style>
    </head>
    <body>
        <!-- Background Layer -->
        <div class="background-container">
            <video autoplay muted loop playsinline class="background-video">
                <source src="/videos/videobackground.mp4" type="video/mp4">
                Seu navegador não suporta vídeos HTML5.
            </video>
            <div class="background-overlay"></div>
            
            <!-- Particle Effects -->
            <div class="particles">
                <div class="particle"></div>
                <div class="particle"></div>
                <div class="particle"></div>
                <div class="particle"></div>
                <div class="particle"></div>
                <div class="particle"></div>
                <div class="particle"></div>
                <div class="particle"></div>
                <div class="particle"></div>
                <div class="particle"></div>
            </div>
        </div>

        <!-- Navigation Header -->
        @if (Route::has('login'))
            <nav class="nav-header">
                @auth
                    <a href="{{ url('/dashboard') }}" class="nav-button">
                        Dashboard
                    </a>
                @else
                    <a href="{{ route('login') }}" class="nav-button">
                        Login
                    </a>
                @endauth
            </nav>
        @endif

        <!-- Main Content -->
        <div class="content-wrapper">
            <div class="hero-container">
                <img src="/img/logoded.svg" alt="D&D 3.5" class="game-logo">
                <p class="game-subtitle">Uma Aventura Lendária Te Aguarda</p>

                <div class="ornate-frame">
                    <div class="corner-decoration top-right"></div>
                    <div class="corner-decoration bottom-left"></div>

                    <p class="description">
                        Em uma taverna esquecida, viviam aventureiros. Uma jornada inesperada os aguarda.
                    </p>

                    <div class="divider"></div>

                    @guest
                        <div class="login-button-container">
                            <a href="{{ route('login') }}" class="login-button">
                                <svg class="shield-icon" viewBox="0 0 24 24" fill="none" xmlns="http://www.w3.org/2000/svg">
                                    <path d="M12 2L4 6V12C4 16.5 7 20.5 12 22C17 20.5 20 16.5 20 12V6L12 2Z" 
                                          fill="currentColor" 
                                          stroke="var(--dark-gold)" 
                                          stroke-width="2"/>
                                </svg>
                                <span class="flame-effect">Entre no Reino</span>
                            </a>
                        </div>
                    @else
                        <div class="login-button-container">
                            <a href="{{ url('/dashboard') }}" class="login-button">
                                <svg class="shield-icon" viewBox="0 0 24 24" fill="none" xmlns="http://www.w3.org/2000/svg">
                                    <path d="M12 2L4 6V12C4 16.5 7 20.5 12 22C17 20.5 20 16.5 20 12V6L12 2Z" 
                                          fill="currentColor" 
                                          stroke="var(--dark-gold)" 
                                          stroke-width="2"/>
                                </svg>
                                <span class="flame-effect">Continuar Jornada</span>
                            </a>
                        </div>
                    @endguest

                    <div class="divider"></div>

                    <p class="description" style="font-size: 0.8rem; margin-top: 1rem;">
                        tequila_underline • ppgLindinha • GenasyRapa01 • c09n0m • João Eurico • Nelson
                    </p>
                </div>
            </div>
        </div>

        <script>
            // Mouse Parallax Effect
            document.addEventListener('DOMContentLoaded', function() {
                const backgroundVideo = document.querySelector('.background-video');
                const particles = document.querySelector('.particles');
                let mouseX = 0;
                let mouseY = 0;
                let currentX = 0;
                let currentY = 0;

                // Track mouse movement
                document.addEventListener('mousemove', function(e) {
                    mouseX = (e.clientX / window.innerWidth) - 0.5;
                    mouseY = (e.clientY / window.innerHeight) - 0.5;
                });

                // Smooth animation loop
                function animate() {
                    // Smooth interpolation
                    currentX += (mouseX - currentX) * 0.1;
                    currentY += (mouseY - currentY) * 0.1;

                    // Apply parallax to background video (slower movement)
                    const bgMoveX = currentX * 30;
                    const bgMoveY = currentY * 30;
                    backgroundVideo.style.transform = `translate(${bgMoveX}px, ${bgMoveY}px)`;

                    // Apply parallax to particles (faster movement for depth)
                    const particleMoveX = currentX * 50;
                    const particleMoveY = currentY * 50;
                    particles.style.transform = `translate(${particleMoveX}px, ${particleMoveY}px)`;

                    requestAnimationFrame(animate);
                }

                animate();
            });
        </script>
    </body>
</html>
