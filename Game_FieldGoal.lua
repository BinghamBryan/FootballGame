--
-- Created by IntelliJ IDEA.
-- User: binghambryan
-- Date: 4/22/13
-- Time: 9:23 PM
-- To change this template use File | Settings | File Templates.
--

-----------------------------------------------------------------------------------------
--
-- Game_FieldGoal.lua
--
-----------------------------------------------------------------------------------------
-- forward declarations and other locals
local storyboard = require( "storyboard" )
local scene = storyboard.newScene()

-- include Corona's "widget" library
local widget = require "widget"
local physics = require("physics")

-- load imagesheet
local sheetInfo = require("FGBallAnim")

local fgBallSheet = graphics.newImageSheet( "images/fgGame/FGBallAnim.png", sheetInfo:getSheet() )

local fgBallSheetInfo =
{
    { name = "forwardSpin",  --name of animation sequence
        start = 1,  --starting frame index
        count = 21,  --total number of frames to animate consecutively before stopping or looping
        time = 200,  --optional, in milliseconds; if not supplied, the sprite is frame-based
        loopCount = 0,  --optional. 0 (default) repeats forever; a positive integer specifies the number of loops
        loopDirection = "forward"  --optional, either "forward" (default) or "bounce" which will play forward then backwards through the sequence of frames
    }
}

local football;
local fgRightPost;
local fgLeftPost;
local movePostLeft;
local movePostRight;
local expandFgBar;
local contractFgBar;
local expandFgShadow;
local contractFgShadow;
local lastFgTime = 1000;


--------------------------------------------
--Listeners
local function footballTouched(event)
    if (event.phase == "began") then
        display.getCurrentStage():setFocus(event.target);
    elseif (event.phase == "ended") then
        --physics.setGravity(5, 10);   --Wind
        event.target.bodyType = "dynamic";
        event.target:applyLinearImpulse(event.xStart - event.x, event.yStart - event.y, football.x, football.y);
        event.target:play();
        display.getCurrentStage():setFocus(nil);
    end
end

local function gameLoop(event)
    if event.time - lastFgTime > 1000  then
        if (football.y > 50 and football.y < 80) then
            if (football.x > fgLeftPost.x and football.x < fgRightPost.x) then
                scene:dispatchEvent({name = "made"});
            else
                scene:dispatchEvent({name = "missed"});
            end
            lastFgTime = event.time
        end
    end
end

movePostLeft = function (target)
    transition.to( target, { time=300, x=(target.x-65), onComplete=movePostRight } )
end

movePostRight = function (target)
    transition.to( target, { time=300, x=(target.x+65), onComplete=movePostLeft } )
end

expandFgBar = function (target)
    transition.to( target, { time=300, width=136, onComplete=contractFgBar})
end

contractFgBar = function (target)
    transition.to( target, { time=300, width=20, onComplete=expandFgBar})
end

expandFgShadow = function (target)
    transition.to( target, { time=300, width=130, onComplete=contractFgShadow})
end

contractFgShadow = function (target)
    transition.to( target, { time=300, width=20, onComplete=expandFgShadow})
end

Runtime:addEventListener("enterFrame", gameLoop);

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
    physics.start();
    physics.setScale(15);
    physics.setDrawMode( "normal" ) -- debug, hybrid, normal

    football = display.newSprite( fgBallSheet, fgBallSheetInfo )
    football.x, football.y = 425, 430;
    physics.addBody(football, "kinematic", {density = 1.0, friction = 0.3, bounce = 0.2});
    football:addEventListener("touch", footballTouched);
    football.isBullet = true;

    local uiBackground = display.newImageRect( "images/UIBg.png", 1024, 768 )
    uiBackground:setReferencePoint( display.CenterReferencePoint )
    uiBackground.x = display.contentCenterX
    uiBackground.y = display.contentCenterY
    group:insert(uiBackground);

    local popContainer = display.newRect(0, 0, 720, 480)
    popContainer:setReferencePoint( display.TopLeftReferencePoint )
    popContainer.x, popContainer.y = 0, 0
    popContainer:setFillColor(140, 140, 140)

    local fgField = display.newImageRect( "images/fgGame/field.png", 704, 464 )
    fgField:setReferencePoint( display.TopLeftReferencePoint )
    fgField.x, fgField.y = 8, 8

    local fgEndZone = display.newImageRect( "images/fgGame/endzones/darkBlue.png", 704, 60 )
    fgEndZone:setReferencePoint( display.TopLeftReferencePoint )
    fgEndZone.x, fgEndZone.y = 8, 72

    local fgShadow = display.newImageRect( "images/fgGame/fgShadow.png", 130, 43 )
    fgShadow:setReferencePoint( display.TopLeftReferencePoint )
    fgShadow.x, fgShadow.y =  (19 + 275), (0 + 8)

    local fgBar = display.newImageRect( "images/fgGame/fgBar.png", 136, 26 )
    fgBar:setReferencePoint( display.TopLeftReferencePoint )
    fgBar.x, fgBar.y =  (16 + 275), (33 + 8)

    fgLeftPost = display.newImage( "images/fgGame/fgLeftPost.png", 20, 49 )
    fgLeftPost:setReferencePoint( display.TopLeftReferencePoint )
    fgLeftPost.x, fgLeftPost.y =  (0 + 275), (4 + 8)
    physics.addBody(fgLeftPost, "static", {density = 1.0, friction = 0.3, bounce = 0.2, isSensor = false});

    fgRightPost = display.newImage( "images/fgGame/fgRightPost.png", 20, 49 )
    fgRightPost:setReferencePoint( display.TopLeftReferencePoint )
    fgRightPost.x, fgRightPost.y =  (149 + 275), (4 + 8)
    physics.addBody(fgRightPost, "static", {density = 1.0, friction = 0.3, bounce = 0.2, isSensor = false});


    local popGroup = display.newGroup()
    popGroup:insert( popContainer )
    popGroup:insert( fgField )
    popGroup:insert( fgEndZone )
    popGroup:insert( fgShadow )
    popGroup:insert( fgBar )
    popGroup:insert( fgLeftPost )
    popGroup:insert( fgRightPost )
    popGroup:insert(football)
    --popGroup:insert(football)

    popGroup:setReferencePoint( display.CenterReferencePoint )
    popGroup.x = display.contentCenterX
    popGroup.y = display.contentCenterY

    group:insert(popGroup);

    scene:addEventListener("made");
    scene:addEventListener("missed");

    transition.to( fgRightPost, { time=300, x=(fgRightPost.x - 65), onComplete=movePostRight } )
    transition.to( fgLeftPost, { time=300, x=(fgLeftPost.x + 65), onComplete=movePostLeft } )
    transition.to( fgBar, { time=300, width=20, onComplete=expandFgBar})
    transition.to( fgShadow, { time=300, width=20, onComplete=expandFgShadow})
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

    package.loaded[physics] = nil;
    physics = nil;
end

function scene:made(event)
    print("Made!");
end

function scene:missed(event)
    print("Miss");
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