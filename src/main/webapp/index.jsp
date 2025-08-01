<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Ball Shooter Game</title>
    <style>
        * {
            margin: 0;
            padding: 0;
            box-sizing: border-box;
        }

        body {
            font-family: -apple-system, BlinkMacSystemFont, 'Segoe UI', Roboto, Oxygen, Ubuntu, Cantarell, sans-serif;
            background: #f8f9fa;
            min-height: 100vh;
            display: flex;
            justify-content: center;
            align-items: center;
            color: #495057;
            line-height: 1.5;
        }

        .game-container {
            background: #ffffff;
            border-radius: 12px;
            border: 1px solid #e9ecef;
            padding: 32px;
            text-align: center;
            max-width: 640px;
            width: 100%;
            margin: 20px;
        }

        .game-header h1 {
            font-size: 2.5rem;
            margin-bottom: 24px;
            color: #343a40;
            font-weight: 600;
            letter-spacing: -0.025em;
        }

        .game-info {
            display: flex;
            justify-content: space-between;
            margin-bottom: 24px;
            gap: 16px;
        }

        .score, .high-score {
            background: #6c757d;
            color: white;
            padding: 12px 20px;
            border-radius: 8px;
            font-weight: 500;
            font-size: 1rem;
            flex: 1;
        }

        .game-area {
            margin: 24px 0;
            display: flex;
            justify-content: center;
        }

        #gameCanvas {
            border: 3px solid #495057;
            border-radius: 8px;
            background: #e9ecef;
            max-width: 100%;
            height: auto;
            box-shadow: 0 4px 12px rgba(0, 0, 0, 0.1);
        }

        .game-controls {
            margin-top: 24px;
        }

        .instructions {
            background: #f8f9fa;
            padding: 20px;
            border-radius: 8px;
            margin-bottom: 24px;
            border: 1px solid #e9ecef;
        }

        .instructions h3 {
            color: #495057;
            margin-bottom: 12px;
            font-size: 1.125rem;
            font-weight: 600;
        }

        .instructions p {
            margin: 8px 0;
            color: #6c757d;
            font-size: 0.95rem;
        }

        .game-status {
            background: #e9ecef;
            padding: 12px 20px;
            border-radius: 8px;
            margin-bottom: 20px;
            font-weight: 500;
            color: #495057;
        }

        .map-size-selector {
            margin-bottom: 24px;
            background: #f8f9fa;
            padding: 20px;
            border-radius: 8px;
            border: 1px solid #e9ecef;
        }

        .map-size-selector h3 {
            color: #495057;
            margin-bottom: 16px;
            font-size: 1.125rem;
            font-weight: 600;
        }

        .size-buttons {
            display: flex;
            gap: 12px;
            justify-content: center;
            flex-wrap: wrap;
        }

        .size-btn {
            padding: 12px 20px;
            font-size: 0.95rem;
            font-weight: 500;
            border: 2px solid #6c757d;
            border-radius: 8px;
            background: white;
            color: #6c757d;
            cursor: pointer;
            transition: all 0.2s ease;
            min-width: 120px;
        }

        .size-btn:hover {
            background: #6c757d;
            color: white;
        }

        .size-btn.active {
            background: #495057;
            color: white;
            border-color: #495057;
        }

        .control-buttons {
            display: flex;
            gap: 12px;
            justify-content: center;
            margin-bottom: 24px;
            flex-wrap: wrap;
        }

        .control-buttons button {
            padding: 12px 24px;
            font-size: 1rem;
            font-weight: 500;
            border: 2px solid #6c757d;
            border-radius: 8px;
            background: white;
            color: #6c757d;
            cursor: pointer;
            transition: all 0.2s ease;
            min-width: 100px;
        }

        .control-buttons button:hover {
            background: #6c757d;
            color: white;
        }

        .control-buttons button:disabled {
            opacity: 0.5;
            cursor: not-allowed;
        }

        #startBtn.active {
            background: #28a745;
            border-color: #28a745;
            color: white;
        }

        #pauseBtn.active {
            background: #ffc107;
            border-color: #ffc107;
            color: #212529;
        }

        #resetBtn:hover {
            background: #dc3545;
            border-color: #dc3545;
            color: white;
        }

        .mobile-controls {
            display: none;
            grid-template-rows: repeat(2, 1fr);
            gap: 12px;
            max-width: 200px;
            margin: 0 auto;
        }

        .control-row {
            display: flex;
            justify-content: center;
            gap: 12px;
        }

        .control-btn {
            width: 48px;
            height: 48px;
            border: 2px solid #6c757d;
            border-radius: 8px;
            background: white;
            color: #6c757d;
            font-size: 1.25rem;
            font-weight: 600;
            cursor: pointer;
            transition: all 0.2s ease;
            display: flex;
            align-items: center;
            justify-content: center;
        }

        .control-btn:hover {
            background: #6c757d;
            color: white;
        }

        .game-over {
            position: fixed;
            top: 50%;
            left: 50%;
            transform: translate(-50%, -50%);
            background: #343a40;
            padding: 40px;
            border-radius: 12px;
            border: 2px solid #495057;
            text-align: center;
            z-index: 1000;
            min-width: 320px;
            box-shadow: 0 10px 30px rgba(0, 0, 0, 0.3);
        }

        .game-over h2 {
            color: #f8f9fa;
            font-size: 2.2rem;
            margin-bottom: 20px;
            font-weight: 700;
            text-shadow: 0 2px 4px rgba(0, 0, 0, 0.3);
        }

        .game-over p {
            font-size: 1.25rem;
            margin-bottom: 28px;
            color: #adb5bd;
            font-weight: 500;
        }

        #playAgainBtn {
            padding: 14px 28px;
            font-size: 1.1rem;
            font-weight: 600;
            border: 2px solid #6c757d;
            border-radius: 8px;
            background: #495057;
            color: #f8f9fa;
            cursor: pointer;
            transition: all 0.2s ease;
            text-transform: uppercase;
            letter-spacing: 0.5px;
        }

        #playAgainBtn:hover {
            background: #6c757d;
            border-color: #6c757d;
            transform: translateY(-2px);
            box-shadow: 0 4px 12px rgba(0, 0, 0, 0.2);
        }

        .hidden {
            display: none;
        }

        .speed-selector {
            margin-bottom: 24px;
            background: #f8f9fa;
            padding: 20px;
            border-radius: 8px;
            border: 1px solid #e9ecef;
        }

        .speed-selector h3 {
            color: #495057;
            margin-bottom: 16px;
            font-size: 1.125rem;
            font-weight: 600;
        }

        .speed-buttons {
            display: flex;
            gap: 12px;
            justify-content: center;
            flex-wrap: wrap;
        }

        .speed-btn {
            padding: 10px 16px;
            font-size: 0.9rem;
            font-weight: 500;
            border: 2px solid #6c757d;
            border-radius: 8px;
            background: white;
            color: #6c757d;
            cursor: pointer;
            transition: all 0.2s ease;
            min-width: 80px;
        }

        .speed-btn:hover {
            background: #6c757d;
            color: white;
        }

        .speed-btn.active {
            background: #495057;
            color: white;
            border-color: #495057;
        }

        /* Responsive Design */
        @media (max-width: 768px) {
            .game-container {
                padding: 20px;
                margin: 10px;
            }
            
            .game-header h1 {
                font-size: 2rem;
            }
            
            .game-info {
                flex-direction: column;
                gap: 12px;
            }
            
            #gameCanvas {
                width: 100%;
                max-width: 100%;
            }
            
            .control-buttons {
                flex-direction: column;
                align-items: center;
            }

            .control-buttons button {
                min-width: 200px;
            }
            
            .mobile-controls {
                display: grid;
                margin-top: 20px;
            }

            .size-buttons, .speed-buttons {
                flex-direction: column;
                align-items: center;
            }

            .size-btn, .speed-btn {
                min-width: 200px;
            }
        }

        @media (min-width: 769px) {
            .mobile-controls {
                display: none;
            }
        }

        /* Focus styles for accessibility */
        button:focus {
            outline: 2px solid #495057;
            outline-offset: 2px;
        }

        /* Smooth animations */
        .game-container {
            animation: fadeIn 0.3s ease-in;
        }

        @keyframes fadeIn {
            from { opacity: 0; transform: translateY(10px); }
            to { opacity: 1; transform: translateY(0); }
        }
    </style>
</head>
<body>
    <div class="game-container">
        <div class="game-header">
            <h1>🎯 Ball Shooter Game</h1>
            <div class="game-info">
                <div class="score">Score: <span id="score">0</span></div>
                <div class="high-score">High Score: <span id="high-score">0</span></div>
            </div>
        </div>
        
        <div class="game-area">
            <canvas id="gameCanvas" width="400" height="400"></canvas>
        </div>
        
        <div class="game-controls">
            <div class="instructions">
                <h3>🎮 How to Play</h3>
                <p>Use arrow keys or A/D to move left and right</p>
                <p>Use spacebar to shoot bullets at falling balls</p>
                <p>Hit the red balls to score points and prevent them from reaching the bottom!</p>
            </div>

            <div class="game-status" id="gameStatus">
                Press arrow keys or A/D to move, spacebar to shoot
            </div>
            
            <div class="map-size-selector">
                <h3>Game Difficulty</h3>
                <div class="size-buttons">
                    <button class="size-btn" data-size="small">Easy</button>
                    <button class="size-btn active" data-size="medium">Normal</button>
                    <button class="size-btn" data-size="large">Hard</button>
                </div>
            </div>

            <div class="speed-selector">
                <h3>Ball Speed</h3>
                <div class="speed-buttons">
                    <button class="speed-btn" data-speed="slow">Slow</button>
                    <button class="speed-btn active" data-speed="normal">Normal</button>
                    <button class="speed-btn" data-speed="fast">Fast</button>
                    <button class="speed-btn" data-speed="extreme">Extreme</button>
                </div>
            </div>
            
            <div class="control-buttons">
                <button id="startBtn">Start Game</button>
                <button id="pauseBtn" disabled>Pause</button>
                <button id="resetBtn">Reset Game</button>
            </div>
            
            <div class="mobile-controls">
                <div class="control-row">
                    <button class="control-btn" data-direction="shoot">🔫</button>
                </div>
                <div class="control-row">
                    <button class="control-btn" data-direction="left">←</button>
                    <button class="control-btn" data-direction="right">→</button>
                </div>
            </div>
        </div>
        
        <div id="gameOver" class="game-over hidden">
            <h2>Game Over!</h2>
            <p>Final Score: <span id="finalScore">0</span></p>
            <button id="playAgainBtn">Play Again</button>
        </div>
    </div>
    
    <script>
        // Game variables
        const canvas = document.getElementById('gameCanvas');
        const ctx = canvas.getContext('2d');
        const scoreElement = document.getElementById('score');
        const highScoreElement = document.getElementById('high-score');
        const gameOverDiv = document.getElementById('gameOver');
        const finalScoreElement = document.getElementById('finalScore');

        // Game settings - Difficulty levels
        const difficultySettings = {
            small: { ballSpeed: 1, spawnRate: 0.02, ballSize: 20 },     // Easy
            medium: { ballSpeed: 2, spawnRate: 0.025, ballSize: 18 },   // Normal  
            large: { ballSpeed: 3, spawnRate: 0.03, ballSize: 16 }      // Hard
        };

        const gameSpeeds = {
            slow: 30,    // 30 FPS
            normal: 40,  // 40 FPS
            fast: 50,    // 50 FPS
            extreme: 60  // 60 FPS
        };

        let currentDifficulty = 'medium';
        let currentSpeed = 'normal';
        let gameSpeed = gameSpeeds[currentSpeed];
        let difficulty = difficultySettings[currentDifficulty];

        // Game objects
        let player = {
            x: canvas.width / 2 - 25,
            y: canvas.height - 40,
            width: 50,
            height: 30,
            speed: 5
        };

        let bullets = [];
        let balls = [];
        let score = 0;
        let highScore = localStorage.getItem('shooterHighScore') || 0;
        let gameRunning = false;
        let gamePaused = false;
        let gameLoop;
        let autoStarted = false;

        // Input handling
        let keys = {
            left: false,
            right: false,
            space: false
        };

        // UI Elements
        const gameStatus = document.getElementById('gameStatus');
        const startBtn = document.getElementById('startBtn');
        const pauseBtn = document.getElementById('pauseBtn');
        const resetBtn = document.getElementById('resetBtn');

        // Initialize the game
        function init() {
            console.log('Initializing Ball Shooter Game...');
            highScoreElement.textContent = highScore;
            drawGame();
            updateGameStatus();
            
            // Add event listeners
            document.addEventListener('keydown', handleKeyDown);
            document.addEventListener('keyup', handleKeyUp);
            startBtn.addEventListener('click', startGame);
            pauseBtn.addEventListener('click', togglePause);
            resetBtn.addEventListener('click', resetGame);
            document.getElementById('playAgainBtn').addEventListener('click', resetGame);
            
            // Mobile controls
            document.querySelectorAll('.control-btn').forEach(btn => {
                btn.addEventListener('click', handleMobileControl);
            });

            // Difficulty controls
            document.querySelectorAll('.size-btn').forEach(btn => {
                btn.addEventListener('click', handleDifficultyChange);
            });

            // Speed controls
            document.querySelectorAll('.speed-btn').forEach(btn => {
                btn.addEventListener('click', handleSpeedChange);
            });
        }

        // Update game status display
        function updateGameStatus() {
            if (gameRunning && !gamePaused) {
                gameStatus.textContent = 'Game in progress - Move with A/D or arrows, shoot with spacebar';
                gameStatus.style.background = '#d4edda';
                gameStatus.style.color = '#155724';
                startBtn.textContent = 'Playing...';
                startBtn.classList.add('active');
                startBtn.disabled = true;
                pauseBtn.disabled = false;
            } else if (gamePaused) {
                gameStatus.textContent = 'Game paused - Click Resume to continue';
                gameStatus.style.background = '#fff3cd';
                gameStatus.style.color = '#856404';
                startBtn.disabled = true;
                pauseBtn.disabled = false;
            } else {
                gameStatus.textContent = 'Press arrow keys or A/D to move, spacebar to shoot';
                gameStatus.style.background = '#e9ecef';
                gameStatus.style.color = '#495057';
                startBtn.textContent = 'Start Game';
                startBtn.classList.remove('active');
                startBtn.disabled = false;
                pauseBtn.disabled = true;
                pauseBtn.textContent = 'Pause';
            }
        }

        // Handle speed change
        function handleSpeedChange(e) {
            if (gameRunning) {
                alert('Please reset the game before changing speed!');
                return;
            }

            document.querySelectorAll('.speed-btn').forEach(btn => {
                btn.classList.remove('active');
            });

            e.target.classList.add('active');
            currentSpeed = e.target.dataset.speed;
            gameSpeed = gameSpeeds[currentSpeed];
            
            console.log('Speed changed to:', currentSpeed, 'FPS:', gameSpeed);
        }

        // Handle difficulty change
        function handleDifficultyChange(e) {
            console.log('Difficulty button clicked:', e.target.dataset.size);
            
            if (gameRunning) {
                alert('Please reset the game before changing difficulty!');
                return;
            }

            // Remove active class from all buttons
            document.querySelectorAll('.size-btn').forEach(btn => {
                btn.classList.remove('active');
            });

            // Add active class to clicked button
            e.target.classList.add('active');

            // Update difficulty
            currentDifficulty = e.target.dataset.size;
            difficulty = difficultySettings[currentDifficulty];
            console.log('Difficulty changed to:', currentDifficulty);
            
            resetGame();
        }

        // Handle keyboard input
        function handleKeyDown(e) {
            const key = e.key.toLowerCase();
            
            // Movement keys
            if (key === 'arrowleft' || key === 'a') {
                keys.left = true;
                if (!gameRunning && !autoStarted) {
                    autoStarted = true;
                    startGame();
                }
            }
            if (key === 'arrowright' || key === 'd') {
                keys.right = true;
                if (!gameRunning && !autoStarted) {
                    autoStarted = true;
                    startGame();
                }
            }
            
            // Shooting
            if (key === ' ' || key === 'spacebar') {
                e.preventDefault();
                if (gameRunning && !gamePaused) {
                    keys.space = true;
                    shoot();
                } else if (!gameRunning && !autoStarted) {
                    autoStarted = true;
                    startGame();
                }
            }
            
            // Other controls
            if (key === 'r') {
                resetGame();
            }
        }

        function handleKeyUp(e) {
            const key = e.key.toLowerCase();
            
            if (key === 'arrowleft' || key === 'a') {
                keys.left = false;
            }
            if (key === 'arrowright' || key === 'd') {
                keys.right = false;
            }
            if (key === ' ' || key === 'spacebar') {
                keys.space = false;
            }
        }

        // Handle mobile controls
        function handleMobileControl(e) {
            const direction = e.target.dataset.direction;
            
            // Auto-start game on mobile control
            if (!gameRunning && !autoStarted) {
                autoStarted = true;
                startGame();
            }
            
            if (!gameRunning || gamePaused) return;
            
            switch (direction) {
                case 'left':
                    player.x = Math.max(0, player.x - player.speed * 3);
                    break;
                case 'right':
                    player.x = Math.min(canvas.width - player.width, player.x + player.speed * 3);
                    break;
                case 'shoot':
                    shoot();
                    break;
            }
        }

        // Start the game
        function startGame() {
            if (gameRunning && !gamePaused) return;
            
            gameRunning = true;
            gamePaused = false;
            gameOverDiv.classList.add('hidden');
            
            // Reset game objects if starting fresh
            if (!autoStarted || (bullets.length === 0 && balls.length === 0)) {
                bullets = [];
                balls = [];
                player.x = canvas.width / 2 - 25;
            }
            
            gameLoop = setInterval(updateGame, 1000 / gameSpeed);
            updateGameStatus();
        }

        // Toggle pause
        function togglePause() {
            if (!gameRunning) return;
            
            gamePaused = !gamePaused;
            
            if (gamePaused) {
                clearInterval(gameLoop);
                pauseBtn.textContent = 'Resume';
                pauseBtn.classList.add('active');
            } else {
                gameLoop = setInterval(updateGame, 1000 / gameSpeed);
                pauseBtn.textContent = 'Pause';
                pauseBtn.classList.remove('active');
            }
            
            updateGameStatus();
        }

        // Reset the game
        function resetGame() {
            clearInterval(gameLoop);
            gameRunning = false;
            gamePaused = false;
            autoStarted = false;
            
            // Reset game state
            player.x = canvas.width / 2 - 25;
            bullets = [];
            balls = [];
            score = 0;
            scoreElement.textContent = score;
            
            // Reset UI
            gameOverDiv.classList.add('hidden');
            
            drawGame();
            updateGameStatus();
        }

        // Shoot bullet
        function shoot() {
            bullets.push({
                x: player.x + player.width / 2 - 2.5,
                y: player.y,
                width: 5,
                height: 10,
                speed: 8
            });
        }

        // Spawn ball
        function spawnBall() {
            if (Math.random() < difficulty.spawnRate) {
                balls.push({
                    x: Math.random() * (canvas.width - difficulty.ballSize),
                    y: -difficulty.ballSize,
                    size: difficulty.ballSize,
                    speed: difficulty.ballSpeed
                });
            }
        }

        // Update game state
        function updateGame() {
            if (gamePaused || !gameRunning) return;
            
            // Move player
            if (keys.left && player.x > 0) {
                player.x -= player.speed;
            }
            if (keys.right && player.x < canvas.width - player.width) {
                player.x += player.speed;
            }
            
            // Update bullets
            for (let i = bullets.length - 1; i >= 0; i--) {
                bullets[i].y -= bullets[i].speed;
                
                // Remove bullets that are off screen
                if (bullets[i].y < -bullets[i].height) {
                    bullets.splice(i, 1);
                }
            }
            
            // Spawn new balls
            spawnBall();
            
            // Update balls
            for (let i = balls.length - 1; i >= 0; i--) {
                balls[i].y += balls[i].speed;
                
                // Check if ball reached bottom
                if (balls[i].y > canvas.height) {
                    gameOver();
                    return;
                }
            }
            
            // Check bullet-ball collisions
            for (let i = bullets.length - 1; i >= 0; i--) {
                for (let j = balls.length - 1; j >= 0; j--) {
                    if (checkCollision(bullets[i], balls[j])) {
                        bullets.splice(i, 1);
                        balls.splice(j, 1);
                        score += 10;
                        scoreElement.textContent = score;
                        
                        // Update high score
                        if (score > highScore) {
                            highScore = score;
                            highScoreElement.textContent = highScore;
                            localStorage.setItem('shooterHighScore', highScore);
                        }
                        
                        createParticles(balls[j] ? balls[j].x : 0, balls[j] ? balls[j].y : 0);
                        break;
                    }
                }
            }
            
            drawGame();
        }

        // Check collision between bullet and ball
        function checkCollision(bullet, ball) {
            return bullet.x < ball.x + ball.size &&
                   bullet.x + bullet.width > ball.x &&
                   bullet.y < ball.y + ball.size &&
                   bullet.y + bullet.height > ball.y;
        }

        // Game over
        function gameOver() {
            clearInterval(gameLoop);
            gameRunning = false;
            gamePaused = false;
            autoStarted = false;
            
            finalScoreElement.textContent = score;
            gameOverDiv.classList.remove('hidden');
            
            updateGameStatus();
        }

        // Draw the game
        function drawGame() {
            // Clear canvas with sky blue background
            ctx.fillStyle = '#87CEEB';
            ctx.fillRect(0, 0, canvas.width, canvas.height);
            
            // Draw player (shooter)
            ctx.fillStyle = '#495057';
            ctx.fillRect(player.x, player.y, player.width, player.height);
            
            // Draw gun barrel
            ctx.fillStyle = '#212529';
            ctx.fillRect(player.x + player.width/2 - 3, player.y - 10, 6, 15);
            
            // Draw bullets
            ctx.fillStyle = '#ffc107';
            for (let bullet of bullets) {
                ctx.fillRect(bullet.x, bullet.y, bullet.width, bullet.height);
            }
            
            // Draw balls
            for (let ball of balls) {
                ctx.fillStyle = '#dc3545';
                ctx.beginPath();
                ctx.arc(ball.x + ball.size/2, ball.y + ball.size/2, ball.size/2, 0, 2 * Math.PI);
                ctx.fill();
                
                // Add shine effect
                ctx.fillStyle = '#ff6b6b';
                ctx.beginPath();
                ctx.arc(ball.x + ball.size/2 - ball.size/6, ball.y + ball.size/2 - ball.size/6, ball.size/6, 0, 2 * Math.PI);
                ctx.fill();
            }
        }

        // Add particle effects for ball destruction
        function createParticles(x, y) {
            const particles = [];
            for (let i = 0; i < 8; i++) {
                particles.push({
                    x: x,
                    y: y,
                    vx: (Math.random() - 0.5) * 6,
                    vy: (Math.random() - 0.5) * 6,
                    life: 20,
                    color: '#dc3545'
                });
            }
            
            // Animate particles
            const animateParticles = () => {
                ctx.save();
                for (let particle of particles) {
                    if (particle.life > 0) {
                        ctx.globalAlpha = particle.life / 20;
                        ctx.fillStyle = particle.color;
                        ctx.fillRect(particle.x, particle.y, 3, 3);
                        
                        particle.x += particle.vx;
                        particle.y += particle.vy;
                        particle.life--;
                    }
                }
                ctx.restore();
                
                if (particles.some(p => p.life > 0)) {
                    requestAnimationFrame(animateParticles);
                }
            };
            
            animateParticles();
        }

        // Initialize the game when page loads
        document.addEventListener('DOMContentLoaded', init);

        // Prevent arrow keys from scrolling the page
        window.addEventListener('keydown', function(e) {
            if(['ArrowUp', 'ArrowDown', 'ArrowLeft', 'ArrowRight', ' '].includes(e.key)) {
                e.preventDefault();
            }
        });

        // Add touch support for mobile
        let touchStartX = 0;

        canvas.addEventListener('touchstart', function(e) {
            e.preventDefault();
            touchStartX = e.touches[0].clientX;
        });

        canvas.addEventListener('touchend', function(e) {
            e.preventDefault();
            if (!gameRunning || gamePaused) return;
            
            const touchEndX = e.changedTouches[0].clientX;
            const deltaX = touchEndX - touchStartX;
            
            // Minimum swipe distance to register
            const minSwipeDistance = 30;
            
            if (Math.abs(deltaX) > minSwipeDistance) {
                if (deltaX > 0) {
                    // Swipe right
                    player.x = Math.min(canvas.width - player.width, player.x + player.speed * 3);
                } else {
                    // Swipe left
                    player.x = Math.max(0, player.x - player.speed * 3);
                }
            } else {
                // Tap to shoot
                shoot();
            }
        });
    </script>
</body>
</html>
