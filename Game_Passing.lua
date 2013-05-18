--
-- Created by IntelliJ IDEA.
-- User: binghambryan
-- Date: 5/3/13
-- Time: 9:58 AM
-- To change this template use File | Settings | File Templates.
--

-----------------------------------------------------------------------------------------
--
-- Game_Passing.lua
--
-----------------------------------------------------------------------------------------
-- forward declarations and other locals
local storyboard = require( "storyboard" )
local scene = storyboard.newScene()

-- include Corona's "widget" library
local widget = require "widget"
local physics = require("physics")
local reciever = require("Class_Reciever");

-- load imagesheet
local sheetInfo = require("FGBallAnim")

local football;
local wideReceivers = {};
local kickArrowGroup;
local lastFgTime = 1000;


--Routs
function runNextRoute(r)
    r.routeCounter = r.routeCounter + 1;
    local newRoute = r.route.routes[r.routeCounter];
    if (newRoute ~= nil) then
        transition.to(r, {time=newRoute.time, x=r.x + newRoute.dx, y=r.y + newRoute.dy})
    end
end

--------------------------------------------
--Listeners
local function footballTouched(event)
    if (event.phase == "began") then
        display.getCurrentStage():setFocus(event.target);
        --Run Routs
        for i = 1, #wideReceivers do
            local r = wideReceivers[i];
            transition.to( r, { time=r.route.routes[1].time, y=r.y + r.route.routes[1].dy, x= r.x + r.route.routes[1].dx, onComplete=runNextRoute})
        end
    elseif (event.phase == "moved") then
        --local t = kickArrowGroup
        --local distance = math.sqrt((football.x-event.x)^2+(football.y-event.y)^2)
        --t.height = 250
        --print(t.height)
    elseif (event.phase == "ended") then
        --physics.setGravity(5, 10);   --Wind
        event.target.bodyType = "dynamic";
        event.target:applyLinearImpulse(event.xStart - event.x, event.yStart - event.y, football.x, football.y);
        event.target:play();
        display.getCurrentStage():setFocus(nil);
    end
end

local function catchCollision(self, event)
    self.isCaught = true;
    timer.performWithDelay(10,
        function()
            local r = event.other;
            if (r.type == "receiver") then
                local joint = physics.newJoint( "weld", self, r, r.x, r.y )
                self.isCaught = true;
                self:pause();
                scene:dispatchEvent({name = "catch"});
            else
                scene:dispatchEvent({name = "missed"});
            end
        end)
end

local function gameLoop(event)
    if (football ~= nil) then
        if (football.isBodyActive) then
            local vx, vy = football:getLinearVelocity();
            if (vy > 0 and football.isCaught == false) then
                physics.pause();
                football:pause();
                scene:dispatchEvent({name = "missed"});
            end
        end
    end
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
    football = display.newSprite( fgBallSheet, fgBallSheetInfo )
    football.x, football.y = 520, 625
    physics.addBody(football, "kinematic", {density = 1.0, friction = 0.3, bounce = 0.2});
    football:addEventListener("touch", footballTouched);
    football.isCaught = false;
    football.isBullet = true;
    football.collision = catchCollision;
    football:addEventListener("collision", football)


    local uiBackground = display.newImageRect( "images/UIBg.png", 1024, 768 )
    uiBackground:setReferencePoint( display.CenterReferencePoint )
    uiBackground.x = display.contentCenterX
    uiBackground.y = display.contentCenterY
    group:insert(uiBackground);

    local fgField = display.newImageRect( "images/fgGame/fieldFull.png", 1024, 724 )
    fgField:setReferencePoint( display.TopLeftReferencePoint )
    fgField.x, fgField.y = 0, 0


    local popGroup = display.newGroup()

    popGroup:insert( fgField )

    popGroup:setReferencePoint( display.TopCenterReferencePoint )
    popGroup.x = display.contentCenterX
    popGroup.y = 44


    --DLinePosition
    local leftDLineman1 = display.newImageRect( "images/fgGame/leftDLineman.png", 26, 60 )
    leftDLineman1:setReferencePoint( display.TopLeftReferencePoint )
    leftDLineman1.x, leftDLineman1.y =  444, 490
    popGroup:insert(leftDLineman1);

    local leftDLineman2 = display.newImageRect( "images/fgGame/leftDLineman.png", 26, 60 )
    leftDLineman2:setReferencePoint( display.TopLeftReferencePoint )
    leftDLineman2.x, leftDLineman2.y =  488, 490
    popGroup:insert(leftDLineman2);

    local rightDLineman1 = display.newImageRect( "images/fgGame/rightDLineman.png", 26, 60 )
    rightDLineman1:setReferencePoint( display.TopLeftReferencePoint )
    rightDLineman1.x, rightDLineman1.y =  524, 490
    popGroup:insert(rightDLineman1);

    local rightDLineman2 = display.newImageRect( "images/fgGame/rightDLineman.png", 26, 60 )
    rightDLineman2:setReferencePoint( display.TopLeftReferencePoint )
    rightDLineman2.x, rightDLineman2.y =  560, 490
    popGroup:insert(rightDLineman2);


    --DBack Position

    local rightDBack1 = display.newImageRect( "images/fgGame/rightDBack.png", 26, 60 )
    rightDBack1:setReferencePoint( display.TopLeftReferencePoint )
    rightDBack1.x, rightDBack1.y =  664, 500
    popGroup:insert(rightDBack1)
    physics.addBody(rightDBack1, "dynamic", {density = 1.0, friction = 0.3, bounce = 0.5});

    local rightDBack2 = display.newImageRect( "images/fgGame/rightDBack.png", 26, 60 )
    rightDBack2:setReferencePoint( display.TopLeftReferencePoint )
    rightDBack2.x, rightDBack2.y =  771, 502
    popGroup:insert(rightDBack2)
    physics.addBody(rightDBack2, "dynamic", {density = 1.0, friction = 0.3, bounce = 0.5});

    local rightDBack3 = display.newImageRect( "images/fgGame/rightDBack.png", 26, 60 )
    rightDBack3:setReferencePoint( display.TopLeftReferencePoint )
    rightDBack3.x, rightDBack3.y =  500, 440
    popGroup:insert(rightDBack3)

    local rightDBack4 = display.newImageRect( "images/fgGame/rightDBack.png", 26, 60 )
    rightDBack4:setReferencePoint( display.TopLeftReferencePoint )
    rightDBack4.x, rightDBack4.y =  580, 370
    popGroup:insert(rightDBack4)

    local leftDBack1 = display.newImageRect( "images/fgGame/leftDBack.png", 26, 60 )
    leftDBack1:setReferencePoint( display.TopLeftReferencePoint )
    leftDBack1.x, leftDBack1.y =  210, 502
    leftDBack1.type = "defender";
    popGroup:insert(leftDBack1)
    physics.addBody(leftDBack1, "static", {density = 1.0, friction = 0.3, bounce = 0.5});

    local leftDBack2 = display.newImageRect( "images/fgGame/leftDBack.png", 26, 60 )
    leftDBack2:setReferencePoint( display.TopLeftReferencePoint )
    leftDBack2.x, leftDBack2.y =  316, 500
    leftDBack2.type = "defender";
    popGroup:insert(leftDBack2)
    physics.addBody(leftDBack2, "static", {density = 1.0, friction = 0.3, bounce = 0.5});

    local leftDBack3 = display.newImageRect( "images/fgGame/leftDBack.png", 26, 60 )
    leftDBack3:setReferencePoint( display.TopLeftReferencePoint )
    leftDBack3.x, leftDBack3.y =  362, 362
    popGroup:insert(leftDBack3)


    --OLine Position
    local leftOLineman1 = display.newImageRect( "images/fgGame/leftOLineman.png", 30, 70 )
    leftOLineman1:setReferencePoint( display.TopLeftReferencePoint )
    leftOLineman1.x, leftOLineman1.y =  442, 520
    popGroup:insert(leftOLineman1)

    local leftOLineman2 = display.newImageRect( "images/fgGame/leftOLineman.png", 30, 70 )
    leftOLineman2:setReferencePoint( display.TopLeftReferencePoint )
    leftOLineman2.x, leftOLineman2.y =  474, 520
    popGroup:insert(leftOLineman2)

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


    --Kick Arrow Positions
    local kickCircle = display.newImageRect( "images/fgGame/kickerCircle.png", 56, 38 )
    kickCircle:setReferencePoint( display.TopLeftReferencePoint )
    kickCircle.x, kickCircle.y =  0, 94

    local kickArrowTop = display.newImageRect( "images/fgGame/arrowTop.png", 36, 36 )
    kickArrowTop:setReferencePoint( display.TopLeftReferencePoint )
    kickArrowTop.x, kickArrowTop.y =  10, 0

    local kickArrowMiddle = display.newImageRect( "images/fgGame/arrowMiddle.png", 18, 40 )
    kickArrowMiddle:setReferencePoint( display.TopLeftReferencePoint )
    kickArrowMiddle.x, kickArrowMiddle.y =  19, 36

    local kickArrowBottom = display.newImageRect( "images/fgGame/arrowBottom.png", 18, 26 )
    kickArrowBottom:setReferencePoint( display.TopLeftReferencePoint )
    kickArrowBottom.x, kickArrowBottom.y =  19, 76

    kickArrowGroup = display.newGroup()

    kickArrowGroup:insert( kickCircle )
    kickArrowGroup:insert( kickArrowBottom )
    kickArrowGroup:insert( kickArrowMiddle )
    kickArrowGroup:insert( kickArrowTop )

    kickArrowGroup:setReferencePoint( display.TopLeftReferencePoint )
    kickArrowGroup.x = 492
    kickArrowGroup.y = 520
    popGroup:insert(kickArrowGroup);

    local halfback =  display.newImageRect( "images/fgGame/halfback.png", 32, 76 )
    halfback:setReferencePoint( display.TopLeftReferencePoint )
    halfback.x, halfback.y =  440, 588
    popGroup:insert(halfback)

    local quarterback = display.newImageRect( "images/fgGame/quarterback.png", 28, 80 )
    quarterback:setReferencePoint( display.TopLeftReferencePoint )
    quarterback.x, quarterback.y =  506, 585
    popGroup:insert(quarterback)


    --Wide Receiver positions

    local wideReceiverRight1 =  reciever.new(1);
    popGroup:insert(wideReceiverRight1)
    wideReceivers[1] = wideReceiverRight1;
    physics.addBody(wideReceiverRight1, "static", {density = 1.0, friction = 0.3, bounce = 0});
    local joint1 = physics.newJoint( "weld", wideReceiverRight1, rightDBack1, rightDBack1.x, rightDBack1.y )

    local wideReceiverRight2 =  reciever.new(2);
    popGroup:insert(wideReceiverRight2)
    wideReceivers[2] = wideReceiverRight2;
    physics.addBody(wideReceiverRight2, "static", {density = 1.0, friction = 0.3, bounce = 0});
    local joint2 = physics.newJoint( "weld", wideReceiverRight2, rightDBack2, rightDBack2.x, rightDBack2.y )

    local wideReceiverLeft1 =  reciever.new(3);
    popGroup:insert(wideReceiverLeft1)
    wideReceivers[3] = wideReceiverLeft1;
    physics.addBody(wideReceiverLeft1, "static", {density = 1.0, friction = 0.3, bounce = 0});

    local wideReceiverLeft2 =  reciever.new(4);
    popGroup:insert(wideReceiverLeft2)
    wideReceivers[4] = wideReceiverLeft2;
    physics.addBody(wideReceiverLeft2, "static", {density = 1.0, friction = 0.3, bounce = 0});

    popGroup:insert(football)

    popGroup:setReferencePoint( display.CenterReferencePoint )
    popGroup.x = display.contentCenterX
    popGroup.y = display.contentCenterY

    group:insert(popGroup);

    scene:addEventListener("catch");
    scene:addEventListener("missed");
end

-- Called immediately after scene has moved onscreen:
function scene:enterScene( event )
    local group = self.view

    -- INSERT code here (e.g. start timers, load audio, start listeners, etc.)

end

-- Called when scene is about to move offscreen:
function scene:exitScene( event )
    local group = self.view
    scene:removeEventListener("catch")
    scene:removeEventListener("missed")
    -- INSERT code here (e.g. stop timers, remove listenets, unload sounds, etc.)
    physics.stop();
end

-- If scene's view is removed, scene:destroyScene() will be called just prior to:
function scene:destroyScene( event )
    local group = self.view

    --package.loaded[physics] = nil;
    --physics = nil;
end

function scene:catch(event)
    print("Catch!");
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