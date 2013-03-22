-----------------------------------------------------------------------------------------
--
-- temp.lua
--
-----------------------------------------------------------------------------------------

local storyboard = require( "storyboard" )
local scene = storyboard.newScene()

-- include Corona's "widget" library
local widget = require "widget"

--------------------------------------------

-- forward declarations and other locals


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
    local fontName = "Interstate";

    -- display a background image
    local background = display.newImageRect( "images/UIBg.jpg", display.contentWidth, display.contentHeight )
    background:setReferencePoint( display.TopLeftReferencePoint )
    background.x, background.y = 0, 0
    group:insert(background);

    -- create/position logo/title image on upper-half of the screen
    local titleLogo = display.newRetinaText( "Pocket Dynasty Football", 264, 42, fontName, 34)
    titleLogo:setReferencePoint( display.CenterReferencePoint )
    titleLogo.x = display.contentWidth * 0.5
    titleLogo.y = 100
    group:insert(titleLogo);

    local titleLogo = display.newRetinaText( "Login", 264, 42, fontName, 28)
    titleLogo:setReferencePoint( display.CenterReferencePoint )
    titleLogo.x = display.contentWidth * 0.5
    titleLogo.y = 200;
    group:insert(titleLogo);

    local loginBox = display.newGroup();
    local txtUserName = native.newTextBox( 15, 70, 280, 70 )
    txtUserName.text = "This is line 1.\nAnd this is line2"
    --txtUserName:addEventListener( "userInput", inputListener )
    loginBox:insert(txtUserName);

    group:insert(loginBox);
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