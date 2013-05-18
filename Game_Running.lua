--
-- Created by IntelliJ IDEA.
-- User: binghambryan
-- Date: 5/17/13
-- Time: 1:18 PM
-- To change this template use File | Settings | File Templates.
--

-----------------------------------------------------------------------------------------
--
-- Game_Running.lua
--
-----------------------------------------------------------------------------------------

local storyboard = require( "storyboard" )
local scene = storyboard.newScene()

-- include Corona's "widget" library
local widget = require "widget"
local physics = require "physics"

--------------------------------------------

-- forward declarations and other locals
-- Layers (Groups). Think as Photoshop layers: you can order things with Corona groups,
-- as well have display objects on the same group render together at once.
local gameLayer;
local enemiesLayer;

-- Declare variables
local gameIsActive = false
local scoreText
local sounds
local score = 0
local toRemove = {}
local background
local player
local halfPlayerWidth
local halfEnemyWidth
local touchingLeft;
local touchingRight;
local enemies = {};

-- Take care of collisions
local function onCollision(self, event)
    -- enemy hit player
    if self.name == "player" and event.other.name == "enemy" then

        local gameoverText = display.newText("Game Over!", 0, 0, "HelveticaNeue", 35)
        gameoverText:setTextColor(255, 255, 255)
        gameoverText.x = display.contentCenterX
        gameoverText.y = display.contentCenterY
        gameLayer:insert(gameoverText)

        -- This will stop the gameLoop
        gameIsActive = false

        scene:dispatchEvent({name = "GameOver"});
    end
end
--------------------------------------------------------------------------------
-- Game loop
--------------------------------------------------------------------------------
local timeLastEnemy = 0

local function gameLoop(event)
    if gameIsActive then
        -- Remove collided enemy planes
        for i = 1, #toRemove do
            toRemove[i].parent:remove(toRemove[i])
            toRemove[i] = nil
        end

        --Move player if touching
        if touchingRight  then
            -- Update player x axis
            player.x = player.x + 2;
        elseif touchingLeft then
            player.x = player.x - 2;
        end

        --chase
        for i=1, #enemies do
            local e =  enemies[i];
            if (e ~= nil) then
                if (player.x > e.x) then
                    e.x = e.x + 1;
                else
                    e.x = e.x - 1;
                end
                if (player.y > e.y) then
                    e.y = e.y + 4;
                else
                    enemies[i].parent:remove(enemies[i])
                    enemies[i] = nil;
                end
            end
        end


        -- Check if it's time to spawn another enemy,
        -- based on a random range and last spawn (timeLastEnemy)
        if event.time - timeLastEnemy >= math.random(600, 1000) then
            -- Randomly position it on the top of the screen
            local enemy = display.newImage("images/fgGame/leftDBack.png")
            enemy.x = math.random(halfEnemyWidth, display.contentWidth - halfEnemyWidth)
            enemy.y = -enemy.contentHeight

            -- This has to be dynamic, making it react to gravity, so it will
            -- fall to the bottom of the screen.
            physics.addBody(enemy, "dynamic", {bounce = 0})
            enemy.name = "enemy"

            enemiesLayer:insert(enemy)
            table.insert(enemies, enemy)
            timeLastEnemy = event.time
        end
    end
end

-- Call the gameLoop function EVERY frame,
-- e.g. gameLoop() will be called 30 times per second ir our case.
Runtime:addEventListener("enterFrame", gameLoop)

--------------------------------------------------------------------------------
-- Basic controls
--------------------------------------------------------------------------------

local function playerMovement(event)
    -- Doesn't respond if the game is ended
    if not gameIsActive then return false end

    if event.phase == "began" then
        if event.x >= display.contentWidth * .5 then
            touchingRight = true
        else
            touchingLeft = true;
        end

    elseif event.phase == "ended" then
        if event.x >= display.contentWidth * .5 then
            touchingRight = false
        else
            touchingLeft = false;
        end
    end
end
-- Player will listen to touches
Runtime:addEventListener("touch", playerMovement)

-----------------------------------------------------------------------------------------
-- BEGINNING OF YOUR IMPLEMENTATION
--
-- NOTE: Code outside of listener functions (below) will only be executed once,
--		 unless storyboard.removeScene() is called.
--
-----------------------------------------------------------------------------------------

-- Called when the scene's view does not exist:
function scene:createScene( event )
    local group = self.view;
    gameLayer = display.newGroup()
    enemiesLayer = display.newGroup()
    enemies = {};
    toRemove = {};
    touchingLeft = false;
    touchingRight = false;
    physics.start()

    -- A heavier gravity, so enemies planes fall faster
    -- !! Note: there are a thousand better ways of doing the enemies movement,
    -- but I'm going with gravity for the sake of simplicity. !!
    physics.setGravity(0, 0)



    -- Keep the texture for the enemy and bullet on memory, so Corona doesn't load them everytime
    local textureCache = {}
    textureCache[1] = display.newImage("images/fgGame/leftDBack.png"); textureCache[1].isVisible = false;
    halfEnemyWidth = textureCache[1].contentWidth * .5

    -- Blue background
    background = display.newImage("images/fgGame/fieldFull.png")
    gameLayer:insert(background)

    -- Order layers (background was already added, so add the bullets, enemies, and then later on
    -- the player and the score will be added - so the score will be kept on top of everything)
    gameLayer:insert(enemiesLayer)

    -- Load and position the player
    player = display.newImage("images/fgGame/halfback.png")
    player.x = display.contentCenterX
    player.y = display.contentHeight - player.contentHeight

    -- Add a physics body. It is kinematic, so it doesn't react to gravity.
    physics.addBody(player, "kinematic", {bounce = 0})

    -- This is necessary so we know who hit who when taking care of a collision event
    player.name = "player"

    -- Listen to collisions
    player.collision = onCollision
    player:addEventListener("collision", player)

    -- Add to main layer
    gameLayer:insert(player)

    -- Store half width, used on the game loop
    halfPlayerWidth = player.contentWidth * .5

    -- Show the score
    scoreText = display.newText(score, 0, 0, "HelveticaNeue", 35)
    scoreText:setTextColor(255, 255, 255)
    scoreText.x = 30
    scoreText.y = 25
    gameLayer:insert(scoreText)

    group:insert(gameLayer);
    gameIsActive = true

    scene:addEventListener("GameOver");
end

-- Called immediately after scene has moved onscreen:
function scene:enterScene( event )
    local group = self.view

    -- INSERT code here (e.g. start timers, load audio, start listeners, etc.)

end

-- Called when scene is about to move offscreen:
function scene:exitScene( event )
    local group = self.view

    -- INSERT code here (e.g. stop timers, remove listenets, unload sounds, etc.)
    physics.stop();
end

-- If scene's view is removed, scene:destroyScene() will be called just prior to:
function scene:destroyScene( event )
    local group = self.view
end

function scene:GameOver(event)
    print("Game over!");
    storyboard.gotoScene( "menu", "flipFadeOutIn", 200 )
end

-----------------------------------------------------------------------------------------
-- END OF YOUR IMPLEMENTATION
-----------------------------------------------------------------------------------------

-- "createScene" event is dispatched if scene's view does not exist
scene:addEventListener( "createScene", scene )

-- "enterScene" event is dispatched whenever scene transition has finished
scene:addEventListener( "enterScene", scene )

-- "exitScene" event is dispatched whenever before next scene's transition begins
scene:addEventListener( "exitScene", scene )

-- "destroyScene" event is dispatched before view is unloaded, which can be
-- automatically unloaded in low memory situations, or explicitly via a call to
-- storyboard.purgeScene() or storyboard.removeScene().
scene:addEventListener( "destroyScene", scene )

-----------------------------------------------------------------------------------------

-----------------------------------------------------------------------------------------

return scene