--
-- Created by IntelliJ IDEA.
-- User: binghambryan
-- Date: 3/22/13
-- Time: 3:33 PM
-- To change this template use File | Settings | File Templates.
--

-----------------------------------------------------------------------------------------
--
-- Scene_UserRegistration.lua
--
-----------------------------------------------------------------------------------------

local storyboard = require( "storyboard" )
local scene = storyboard.newScene()

-- include Corona's "widget" library
local widget = require "widget"

local txtFirstName;
local txtLastName;
local txtUserName;
local txtEmail;
local txtPassword;
local txtPasswordConfirm;

--------------------------------------------

-- forward declarations and other locals
local function onRegister(event)
    if (txtPassword.text == txtPasswordConfirm.text) then
        coronaCloud.registerUser( txtFirstName.text, txtLastName.text, txtUserName.text, txtEmail.text, txtPassword.text )
    else
        --Passwords don't match
    end
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
    local fontName = "Interstate";

    -- display a background image
    local background = display.newImageRect( "images/UIBg.jpg", display.contentWidth, display.contentHeight )
    background:setReferencePoint( display.TopLeftReferencePoint )
    background.x, background.y = 0, 0
    group:insert(background);

    -- create/position logo/title image on upper-half of the screen
    local titleLogo = display.newText( "Pocket Dynasty Football", 264, 42, fontName, 34)
    titleLogo:setReferencePoint( display.CenterReferencePoint )
    titleLogo.x = display.contentWidth * 0.5
    titleLogo.y = 100
    group:insert(titleLogo);

    local header = display.newText( "Register", 264, 42, fontName, 28)
    header:setReferencePoint( display.CenterReferencePoint )
    header.x = display.contentWidth * 0.5
    header.y = 200;
    group:insert(header);

    local loginBox = display.newGroup();
    txtUserName = native.newTextField( 10, 30, 180, 30 )
    txtUserName.text = "Username"
    --txtUserName:addEventListener( "userInput", inputListener )
    loginBox:insert(txtUserName);
    txtUserName.x, txtUserName.y = 10, 30;

    txtFirstName = native.newTextField( 10, 30, 180, 30 )
    txtFirstName.text = "First Name"
    --txtUserName:addEventListener( "userInput", inputListener )
    loginBox:insert(txtFirstName);
    txtFirstName.x, txtFirstName.y = 10, 90;

    txtLastName = native.newTextField( 10, 30, 180, 30 )
    txtLastName.text = "Last Name"
    --txtUserName:addEventListener( "userInput", inputListener )
    loginBox:insert(txtLastName);
    txtLastName.x, txtLastName.y = 10, 150;

    txtEmail = native.newTextField( 10, 30, 180, 30 )
    txtEmail.text = "Email"
    --txtUserName:addEventListener( "userInput", inputListener )
    loginBox:insert(txtEmail);
    txtEmail.x, txtEmail.y = 10, 210;

    txtPassword = native.newTextField( 10, 30, 180, 30 )
    txtPassword.text = "Password"
    --txtUserName:addEventListener( "userInput", inputListener )
    loginBox:insert(txtPassword);
    txtPassword.x, txtPassword.y = 10, 270;

    txtPasswordConfirm = native.newTextField( 10, 30, 180, 30 )
    txtPasswordConfirm.text = "Confirm Password"
    --txtUserName:addEventListener( "userInput", inputListener )
    loginBox:insert(txtPasswordConfirm);
    txtPasswordConfirm.x, txtPasswordConfirm.y = 10, 330;

    local btnRegister = widget.newButton{
        label="REGISTER",
        labelColor = { default={255}, over={128} },
        defaultFile="images/ChoosePlayBtn.png",
        width=340, height=48,
        onRelease = onRegister,	-- event listener function
        font = "Interstate",
        fontSize = 26
    }
    loginBox:insert(btnRegister);
    btnRegister.x, btnRegister.y = 10, 390;

    loginBox:setReferencePoint(display.CenterReferencePoint);
    loginBox.x, loginBox.y = display.contentWidth * .5, display.contentHeight * .5;
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
    txtEmail:removeSelf();
    txtPassword:removeSelf();
    txtPasswordConfirm:removeSelf();
    txtUserName:removeSelf();
    txtFirstName:removeSelf();
    txtLastName:removeSelf();
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