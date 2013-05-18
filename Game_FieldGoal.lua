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
    football.x, football.y = 512, 600;
    physics.addBody(football, "kinematic", {density = 1.0, friction = 0.3, bounce = 0.2});
    football:addEventListener("touch", footballTouched);
    football.isBullet = true;

    local uiBackground = display.newImageRect( "images/UIBg.png", 1024, 768 )
    uiBackground:setReferencePoint( display.CenterReferencePoint )
    uiBackground.x = display.contentCenterX
    uiBackground.y = display.contentCenterY
    group:insert(uiBackground);

    local popGroup = display.newGroup()

    local fgField = display.newImageRect( "images/fgGame/field.png", 1024, 724 )
    fgField:setReferencePoint( display.TopLeftReferencePoint )
    fgField.x, fgField.y = 0, 0
    popGroup:insert(fgField)

    local fgEndZone = display.newImageRect( "images/fgGame/endzones/darkBlue.png", 1024, 94 )
    fgEndZone:setReferencePoint( display.TopLeftReferencePoint )
    fgEndZone.x, fgEndZone.y = 0, 140
    popGroup:insert(fgEndZone);


    --Field Goal SHADOW Graphics
    local fgShadowBase = display.newImageRect( "images/fgGame/fgShadowBase.png", 16, 18 )
    fgShadowBase:setReferencePoint( display.TopLeftReferencePoint )
    fgShadowBase.x, fgShadowBase.y =  78, 46

    local fgShadowBar = display.newImageRect( "images/fgGame/fgShadowBar.png", 80, 8 )
    fgShadowBar:setReferencePoint( display.TopCenterReferencePoint )
    fgShadowBar.x, fgShadowBar.y =  85, 42

    local fgShadowLeftPost = display.newImageRect( "images/fgGame/fgShadowLeftPost.png", 19, 38 )
    fgShadowLeftPost:setReferencePoint( display.TopLeftReferencePoint )
    fgShadowLeftPost.x, fgShadowLeftPost.y =  26, 10

    local fgShadowRightPost = display.newImageRect( "images/fgGame/fgShadowRightPost.png", 19, 38 )
    fgShadowRightPost:setReferencePoint( display.TopLeftReferencePoint )
    fgShadowRightPost.x, fgShadowRightPost.y =  125, 10

    local fgShadowGroup = display.newGroup()

    fgShadowGroup:insert( fgShadowBase )
    fgShadowGroup:insert( fgShadowBar )
    fgShadowGroup:insert( fgShadowLeftPost )
    fgShadowGroup:insert( fgShadowRightPost )

    fgShadowGroup:setReferencePoint( display.TopLeftReferencePoint )
    fgShadowGroup.x = 451
    fgShadowGroup.y = 84
    popGroup:insert(fgShadowGroup);

    --Field Goal Graphics
    local fgBase = display.newImageRect( "images/fgGame/fgBase.png", 16, 26 )
    fgBase:setReferencePoint( display.TopLeftReferencePoint )
    fgBase.x, fgBase.y =  504, 131
    popGroup:insert(fgBase)

    local fgBar = display.newImageRect( "images/fgGame/fgBar.png", 136, 4 )
    fgBar:setReferencePoint( display.TopLeftReferencePoint )
    fgBar.x, fgBar.y =  444, 147
    popGroup:insert(fgBar)

    fgLeftPost = display.newImageRect( "images/fgGame/fgLeftPost.png", 20, 49 )
    fgLeftPost:setReferencePoint( display.TopLeftReferencePoint )
    fgLeftPost.x, fgLeftPost.y =  429, 102
    physics.addBody(fgLeftPost, "static", {density = 1.0, friction = 0.3, bounce = 0.2, isSensor = false});
    popGroup:insert(fgLeftPost)

    fgRightPost = display.newImageRect( "images/fgGame/fgRightPost.png", 20, 49 )
    fgRightPost:setReferencePoint( display.TopLeftReferencePoint )
    fgRightPost.x, fgRightPost.y =  576, 102
    physics.addBody(fgRightPost, "static", {density = 1.0, friction = 0.3, bounce = 0.2, isSensor = false});
    popGroup:insert(fgRightPost)


    --DLinePosition
    local leftDLineman1 = display.newImageRect( "images/fgGame/leftDLineman.png", 26, 60 )
    leftDLineman1:setReferencePoint( display.TopLeftReferencePoint )
    leftDLineman1.x, leftDLineman1.y =  376, 490
    popGroup:insert(leftDLineman1)

    local leftDLineman2 = display.newImageRect( "images/fgGame/leftDLineman.png", 26, 60 )
    leftDLineman2:setReferencePoint( display.TopLeftReferencePoint )
    leftDLineman2.x, leftDLineman2.y =  408, 490
    popGroup:insert(leftDLineman2)

    local leftDLineman3 = display.newImageRect( "images/fgGame/leftDLineman.png", 26, 60 )
    leftDLineman3:setReferencePoint( display.TopLeftReferencePoint )
    leftDLineman3.x, leftDLineman3.y =  440, 490
    popGroup:insert(leftDLineman3)

    local leftDLineman4 = display.newImageRect( "images/fgGame/leftDLineman.png", 26, 60 )
    leftDLineman4:setReferencePoint( display.TopLeftReferencePoint )
    leftDLineman4.x, leftDLineman4.y =  468, 490
    popGroup:insert(leftDLineman4)

    local leftDLineman5 = display.newImageRect( "images/fgGame/leftDLineman.png", 26, 60 )
    leftDLineman5:setReferencePoint( display.TopLeftReferencePoint )
    leftDLineman5.x, leftDLineman5.y =  500, 490
    popGroup:insert(leftDLineman5)

    local rightDLineman1 = display.newImageRect( "images/fgGame/rightDLineman.png", 26, 60 )
    rightDLineman1:setReferencePoint( display.TopLeftReferencePoint )
    rightDLineman1.x, rightDLineman1.y =  530, 490
    popGroup:insert(rightDLineman1)

    local rightDLineman2 = display.newImageRect( "images/fgGame/rightDLineman.png", 26, 60 )
    rightDLineman2:setReferencePoint( display.TopLeftReferencePoint )
    rightDLineman2.x, rightDLineman2.y =  560, 490
    popGroup:insert(rightDLineman2)

    local rightDLineman3 = display.newImageRect( "images/fgGame/rightDLineman.png", 26, 60 )
    rightDLineman3:setReferencePoint( display.TopLeftReferencePoint )
    rightDLineman3.x, rightDLineman3.y =  594, 490
    popGroup:insert(rightDLineman3)

    local rightDLineman4 = display.newImageRect( "images/fgGame/rightDLineman.png", 26, 60 )
    rightDLineman4:setReferencePoint( display.TopLeftReferencePoint )
    rightDLineman4.x, rightDLineman4.y =  626, 490
    popGroup:insert(rightDLineman4)


    --DBack Position

    local rightDBack1 = display.newImageRect( "images/fgGame/rightDBack.png", 26, 60 )
    rightDBack1:setReferencePoint( display.TopLeftReferencePoint )
    rightDBack1.x, rightDBack1.y =  660, 500
    popGroup:insert(rightDBack1)

    local rightDBack2 = display.newImageRect( "images/fgGame/rightDBack.png", 26, 60 )
    rightDBack2:setReferencePoint( display.TopLeftReferencePoint )
    rightDBack2.x, rightDBack2.y =  576, 470
    popGroup:insert(rightDBack2)

    --OLine Position
    local leftOLineman1 = display.newImageRect( "images/fgGame/leftOLineman.png", 30, 70 )
    leftOLineman1:setReferencePoint( display.TopLeftReferencePoint )
    leftOLineman1.x, leftOLineman1.y =  376, 520
    popGroup:insert(leftOLineman1)

    local leftOLineman2 = display.newImageRect( "images/fgGame/leftOLineman.png", 30, 70 )
    leftOLineman2:setReferencePoint( display.TopLeftReferencePoint )
    leftOLineman2.x, leftOLineman2.y =  408, 520
    popGroup:insert(leftOLineman2)

    local leftOLineman3 = display.newImageRect( "images/fgGame/leftOLineman.png", 30, 70 )
    leftOLineman3:setReferencePoint( display.TopLeftReferencePoint )
    leftOLineman3.x, leftOLineman3.y =  440, 520
    popGroup:insert(leftOLineman3)

    local leftOLineman4 = display.newImageRect( "images/fgGame/leftOLineman.png", 30, 70 )
    leftOLineman4:setReferencePoint( display.TopLeftReferencePoint )
    leftOLineman4.x, leftOLineman4.y =  472, 520
    popGroup:insert(leftOLineman4)

    local centerOLineman = display.newImageRect( "images/fgGame/centerOLineman.png", 30, 70 )
    centerOLineman:setReferencePoint( display.TopLeftReferencePoint )
    centerOLineman.x, centerOLineman.y =  504, 520
    popGroup:insert(centerOLineman)

    local rightOLineman1 = display.newImageRect( "images/fgGame/rightOLineman.png", 30, 70 )
    rightOLineman1:setReferencePoint( display.TopLeftReferencePoint )
    rightOLineman1.x, rightOLineman1.y =  536, 520
    popGroup:insert(rightOLineman1)

    local rightOLineman2 = display.newImageRect( "images/fgGame/rightOLineman.png", 30, 70 )
    rightOLineman2:setReferencePoint( display.TopLeftReferencePoint )
    rightOLineman2.x, rightOLineman2.y =  568, 520
    popGroup:insert(rightOLineman2)

    local rightOLineman3 = display.newImageRect( "images/fgGame/rightOLineman.png", 30, 70 )
    rightOLineman3:setReferencePoint( display.TopLeftReferencePoint )
    rightOLineman3.x, rightOLineman3.y =  600, 520
    popGroup:insert(rightOLineman3)

    local rightOLineman4 = display.newImageRect( "images/fgGame/rightOLineman.png", 30, 70 )
    rightOLineman4:setReferencePoint( display.TopLeftReferencePoint )
    rightOLineman4.x, rightOLineman4.y =  630, 520
    popGroup:insert(rightOLineman4)


    --Kick Arrow Positions
    local kickCircle = display.newImageRect( "images/fgGame/kickerCircle.png", 56, 38 )
    kickCircle:setReferencePoint( display.TopLeftReferencePoint )
    kickCircle.x, kickCircle.y =  0, 94

    local kickArrowTop = display.newImageRect( "images/fgGame/arrowTop.png", 36, 36 )
    kickArrowTop:setReferencePoint( display.TopLeftReferencePoint )
    kickArrowTop.x, kickArrowTop.y =  0, 0

    local kickArrowMiddle = display.newImageRect( "images/fgGame/arrowMiddle.png", 18, 40 )
    kickArrowMiddle:setReferencePoint( display.TopLeftReferencePoint )
    kickArrowMiddle.x, kickArrowMiddle.y =  9, 36

    local kickArrowBottom = display.newImageRect( "images/fgGame/arrowBottom.png", 18, 26 )
    kickArrowBottom:setReferencePoint( display.TopLeftReferencePoint )
    kickArrowBottom.x, kickArrowBottom.y =  9, 76

    local kickArrowGroup = display.newGroup()

    kickArrowGroup:insert( kickCircle )
    kickArrowGroup:insert( kickArrowBottom )
    kickArrowGroup:insert( kickArrowMiddle )
    kickArrowGroup:insert( kickArrowTop )

    kickArrowGroup:setReferencePoint( display.TopLeftReferencePoint )
    kickArrowGroup.x = 504
    kickArrowGroup.y = 520
    popGroup:insert(kickArrowGroup)

    local holder = display.newImageRect( "images/fgGame/holder.png", 36, 54 )
    holder:setReferencePoint( display.TopLeftReferencePoint )
    holder.x, holder.y =  512, 600
    popGroup:insert(holder)

    local kicker = display.newImageRect( "images/fgGame/kicker.png", 30, 86 )
    kicker:setReferencePoint( display.TopLeftReferencePoint )
    kicker.x, kicker.y =  470, 604
    popGroup:insert(kicker)

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
    --transition.to( fgShadow, { time=300, width=20, onComplete=expandFgShadow})
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

    --package.loaded[physics] = nil;
    --physics = nil;
end

function scene:made(event)
    print("Made!");
    storyboard.gotoScene( "menu", "flipFadeOutIn", 200 )
end

function scene:missed(event)
    print("Miss");
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