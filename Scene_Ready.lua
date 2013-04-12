--
-- Created by IntelliJ IDEA.
-- User: binghambryan
-- Date: 4/12/13
-- Time: 3:08 PM
-- To change this template use File | Settings | File Templates.
--

-----------------------------------------------------------------------------------------
--
-- Scene_Ready.lua
--
-----------------------------------------------------------------------------------------

local storyboard = require( "storyboard" )
local scene = storyboard.newScene()

-- include Corona's "widget" library
local widget = require "widget"

--------------------------------------------

-- forward declarations and other locals
local function onBtnRelease(event)
    storyboard.hideOverlay("fade", 400);
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
    local group = self.view;
    parent = event.params.parent;
    local popup = display.newGroup();
    group:insert(popup);
    local uiBackground =  display.newRect( 0, 0, display.contentWidth, display.contentHeight )
    uiBackground:setFillColor( 50,50,50 )
    uiBackground.alpha = 0.8;

    local content = display.newGroup();

    local contentBg = display.newRect( 0, 0, display.contentWidth*0.75, display.contentHeight*0.75 );
    contentBg:setFillColor( 0,0,0 )

    local header = display.newText("Player Ready?", 0, 0, "Interstate", 34);
    header.x, header.y = display.contentWidth*0.375,25;

    local readyBtn = widget.newButton{
        id="ready",
        label="Ready",
        labelColor = { default={255}, over={128} },
        defaultFile="images/ChoosePlayBtn.png",
        width=250, height=60,
        onRelease = onBtnRelease,	-- event listener function
        font = "Interstate",
        fontSize = 26
    }
    readyBtn.x = display.contentWidth*0.375
    readyBtn.y = 100;

    content:insert(contentBg);
    content:insert(readyBtn);
    content:insert(header);
    content:setReferencePoint(display.CenterReferencePoint);
    content.x = display.contentWidth*0.5;
    content.y = display.contentHeight * 0.5;

    popup:insert(uiBackground);
    popup:insert(content);
    popup:setReferencePoint(display.CenterReferencePoint);
    popup.x = display.contentWidth*0.5;
    popup.y = display.contentHeight * 0.5;
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

end

-- If scene's view is removed, scene:destroyScene() will be called just prior to:
function scene:destroyScene( event )
    local group = self.view
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