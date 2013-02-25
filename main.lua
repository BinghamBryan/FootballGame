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

-- load menu screen
storyboard.gotoScene( "menu" )

