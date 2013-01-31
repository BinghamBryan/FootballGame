-----------------------------------------------------------------------------------------
--
-- game.lua
--
-----------------------------------------------------------------------------------------

local storyboard = require( "storyboard" )
local scene = storyboard.newScene()

-- include Corona's "physics" library
local physics = require "physics"
physics.start(); physics.pause()

--------------------------------------------

-- forward declarations and other locals
local screenW, screenH, halfW = display.contentWidth, display.contentHeight, display.contentWidth*0.5

local playContainers = {};
local plays = {};

--local posX, posY = 100, 200
local sizeX, sizeY = 40, 40
local playSizeW, playSizeH = 30, 30;
--local posX1, posY1 = 150, 200
--local posx, posy = 10, 50

local function playsListener(event)
    local self = event.target;
    if event.phase == "began" then

        self.markX = self.x    -- store x location of object
        self.markY = self.y    -- store y location of object

    elseif event.phase == "moved" then

        local x = (event.x - event.xStart) + self.markX
        local y = (event.y - event.yStart) + self.markY

        self.x, self.y = x, y    -- move object based on calculations above

        for i = 0, #playContainers do
            local posX, posY =  playContainers[i].x, playContainers[i].y;

            -- do your code to check to see if your object is in your container
            if (((x >= ((sizeX/2) + posX - ((2/3) * sizeX))) and (y >= ((sizeY/2) + posY - ((1/3) * sizeY))) and (x <= ((sizeX/2) + posX + ((2/3) * sizeX))) and (y <= ((sizeY/2) + posY + ((1/3) * sizeY)))) or ((x >= ((sizeX/2) + posX - ((1/3) * sizeX))) and (y >= ((sizeY/2) + posY - ((2/3) * sizeY))) and (x <= ((sizeX/2) + posX + ((1/3) * sizeX))) and (y <= ((sizeY/2) + posY + ((2/3) * sizeY)))) or ((x >= ((sizeX/2) + posX - ((1/2) * sizeX))) and (y >= ((sizeY/2) + posY - ((1/2) * sizeY))) and (x <= ((sizeX/2) + posX + ((1/2) * sizeX))) and (y <= ((sizeY/2) + posY + ((1/2) * sizeY))))) then
                playContainers[i]:setFillColor( 0,0,255 )
            else
                playContainers[i]:setFillColor( 255,0,0 )
            end
        end

    elseif event.phase == "ended" then

        local x = (event.x - event.xStart) + self.markX
        local y = (event.y - event.yStart) + self.markY

        for i = 0, #playContainers do
            local posX, posY =  playContainers[i].x, playContainers[i].y;
            -- main condition: I calculated 3 areas to atract the object to the target container, 2 areas that atract it when it's 1/3 in the target and 1 area that atract it when it's 1/4 in the target
            if (((x >= ((sizeX/2) + posX - ((2/3) * sizeX))) and (y >= ((sizeY/2) + posY - ((1/3) * sizeY))) and (x <= ((sizeX/2) + posX + ((2/3) * sizeX))) and (y <= ((sizeY/2) + posY + ((1/3) * sizeY)))) or ((x >= ((sizeX/2) + posX - ((1/3) * sizeX))) and (y >= ((sizeY/2) + posY - ((2/3) * sizeY))) and (x <= ((sizeX/2) + posX + ((1/3) * sizeX))) and (y <= ((sizeY/2) + posY + ((2/3) * sizeY)))) or ((x >= ((sizeX/2) + posX - ((1/2) * sizeX))) and (y >= ((sizeY/2) + posY - ((1/2) * sizeY))) and (x <= ((sizeX/2) + posX + ((1/2) * sizeX))) and (y <= ((sizeY/2) + posY + ((1/2) * sizeY))))) then
                self.x, self.y = posX + (sizeX/2), posY + (sizeY/2);
            end
        end
    end

    return true
end

-----------------------------------------------------------------------------------------
-- BEGINNING OF YOUR IMPLEMENTATION
--
-- NOTE: Code outside of listener functions (below) will only be executed once,
--		 unless storyboard.removeScene() is called.
--
-----------------------------------------------------------------------------------------

-- Called when the scene's view does not exist:
function scene:createScene( event )
    local group = self.view

    -- create a grey rectangle as the backdrop
    local background = display.newRect( 0, 0, screenW, screenH )
    background:setFillColor( 128 )


    local container = display.newRoundedRect( 100, 200, sizeX, sizeY, 3 )
    container:setFillColor( 0,0,255 )
    container.strokeWidth = 3
    container:setStrokeColor(100, 100, 100)
    playContainers[0] = container;

    local container2 = display.newRoundedRect( 150, 200, sizeX, sizeY, 3 )
    container2:setFillColor( 0,0,255 )
    container2.strokeWidth = 3
    container2:setStrokeColor(100, 100, 100)
    playContainers[1] = container2;

    local container3 = display.newRoundedRect( 200, 200, sizeX, sizeY, 3 )
    container3:setFillColor( 0,0,255 )
    container3.strokeWidth = 3
    container3:setStrokeColor(100, 100, 100)
    playContainers[2] = container3;


    plays[0] = display.newRoundedRect(20, 20 , playSizeW, playSizeH, 3)
    plays[0]:addEventListener("touch", playsListener)
    plays[1] = display.newRoundedRect(60, 20 , playSizeW, playSizeH, 3)
    plays[1]:addEventListener("touch", playsListener)
    plays[2] = display.newRoundedRect(100, 20 , playSizeW, playSizeH, 3)
    plays[2]:addEventListener("touch", playsListener)

    -- all display objects must be inserted into group
    group:insert( background )

end

-- Called immediately after scene has moved onscreen:
function scene:enterScene( event )
    local group = self.view

    --physics.start()

end

-- Called when scene is about to move offscreen:
function scene:exitScene( event )
    local group = self.view

    --physics.stop()

end

-- If scene's view is removed, scene:destroyScene() will be called just prior to:
function scene:destroyScene( event )
    local group = self.view

    --package.loaded[physics] = nil
    --dsphysics = nil
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

return scene