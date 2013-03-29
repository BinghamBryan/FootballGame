-----------------------------------------------------------------------------------------
--
-- main.lua
--
-----------------------------------------------------------------------------------------

-- hide the status bar
display.setStatusBar( display.HiddenStatusBar )
-- include the Corona "storyboard" module
local storyboard = require "storyboard"
local fontName = "Interstate";

--Corona Cloud initialize
CC_Access_Key = "5a4df41d305a0721416703a495fe52c0738fc729";
CC_Secret_Key = "c89a2561f5416cac825a0c0d322d12025cfcf251";
coronaCloud = require("coronaCloudController");
coronaCloud.init(CC_Access_Key, CC_Secret_Key);
coronaCloud.debugEnabled = true;

--gameNetwork = require( "gameNetwork" )
--local params = { accessKey = CC_Access_Key, secretKey = CC_Secret_Key, }
--gameNetwork.init( "corona", params )

--Login/Registration Events Code
local currentAuthToken = "";  --variable to store the login 'authToken'

local function loginSuccess( event )
    --store the 'authToken' on login success
    currentAuthToken = coronaCloud.authToken;
    storyboard.gotoScene( "menu" )
end

local function loginFailure( event )
    --clear the 'authToken' on login failure
    currentAuthToken = "";
    storyboard.gotoScene( "Scene_Login" )
end

local function registrationHandler( event )
    --code to handle the registration
    --this is a logical place to call the login code
    storyboard.gotoScene( "Scene_Login" );
end

Runtime:addEventListener( "UserRegistered", registrationHandler )
Runtime:addEventListener( "LoggedIn", loginSuccess );
Runtime:addEventListener( "LoginError", loginFailure );

--Start
-- load menu screen
--storyboard.gotoScene( "Scene_Login" );
storyboard.gotoScene( "Scene_Login" )

