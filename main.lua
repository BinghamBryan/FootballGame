-----------------------------------------------------------------------------------------
--
-- main.lua
--
-----------------------------------------------------------------------------------------

-- hide the status bar
display.setStatusBar( display.HiddenStatusBar )

--Corona Cloud initialize
CC_Access_Key = "5a4df41d305a0721416703a495fe52c0738fc729";
CC_Secret_Key = "c89a2561f5416cac825a0c0d322d12025cfcf251";
coronaCloud = require("coronaCloudController");
coronaCloud.init(CC_Access_Key, CC_Secret_Key);

--gameNetwork = require( "gameNetwork" )
--local params = { accessKey = CC_Access_Key, secretKey = CC_Secret_Key, }
--gameNetwork.init( "corona", params )

-- include the Corona "storyboard" module
local storyboard = require "storyboard"
local fontName = "Interstate";

-- load menu screen
storyboard.gotoScene( "Scene_Login" )

