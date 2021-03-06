-----------------------------------------------------------------------------------------
--
-- menu.lua
--
-----------------------------------------------------------------------------------------

local storyboard = require( "storyboard" )
local scene = storyboard.newScene()

-- include Corona's "widget" library
local widget = require "widget"

--------------------------------------------

-- forward declarations and other locals
local playBtn;
local fgBtn;
local passBtn;
local runBtn;

-- 'onRelease' event listener for playBtn
local function onPlayBtnRelease()
	-- go to game.lua scene
	storyboard.gotoScene( "game", "flipFadeOutIn", 200 )
	
	return true	-- indicates successful touch
end

local function onFgBtnRelease()
    -- go to game.lua scene
    storyboard.purgeScene("Game_FieldGoal");
    storyboard.gotoScene( "Game_FieldGoal", "flipFadeOutIn", 200 )

    return true	-- indicates successful touch
end

local function onPassBtnRelease()
    -- go to game.lua scene
    storyboard.purgeScene("Game_Passing");
    storyboard.gotoScene( "Game_Passing", "flipFadeOutIn", 200 )

    return true	-- indicates successful touch
end

local function onRunBtnRelease()
    -- go to game.lua scene
    storyboard.purgeScene("Game_Running");
    storyboard.gotoScene( "Game_Running", "flipFadeOutIn", 200 )

    return true	-- indicates successful touch
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
	
	-- create/position logo/title image on upper-half of the screen
	local titleLogo = display.newText( "Pocket Dynasty Football", 264, 42, fontName, 34)
	titleLogo:setReferencePoint( display.CenterReferencePoint )
	titleLogo.x = display.contentWidth * 0.5
	titleLogo.y = 100
	
	-- create a widget button (which will loads game.lua on release)
	playBtn = widget.newButton{
		label="Play Now",
		labelColor = { default={255}, over={128} },
		defaultFile="images/ChoosePlayBtn.png",
		width=250, height=60,
		onRelease = onPlayBtnRelease,	-- event listener function
        font = fontName,
        fontSize = 26
    }
	playBtn:setReferencePoint( display.CenterReferencePoint )
	playBtn.x = display.contentWidth*0.5
	playBtn.y = display.contentHeight - 175

    -- create a widget button (which will loads game.lua on release)
    fgBtn = widget.newButton{
        label="Field Goal Game",
        labelColor = { default={255}, over={128} },
        defaultFile="images/ChoosePlayBtn.png",
        width=250, height=60,
        onRelease = onFgBtnRelease,	-- event listener function
        font = fontName,
        fontSize = 26
    }
    fgBtn:setReferencePoint( display.CenterReferencePoint )
    fgBtn.x = display.contentWidth*0.5
    fgBtn.y = display.contentHeight - 275

    -- create a widget button (which will loads game.lua on release)
    passBtn = widget.newButton{
        label="Passing Game",
        labelColor = { default={255}, over={128} },
        defaultFile="images/ChoosePlayBtn.png",
        width=250, height=60,
        onRelease = onPassBtnRelease,	-- event listener function
        font = fontName,
        fontSize = 26
    }
    passBtn:setReferencePoint( display.CenterReferencePoint )
    passBtn.x = display.contentWidth*0.5
    passBtn.y = display.contentHeight - 375

    -- create a widget button (which will loads game.lua on release)
    runBtn = widget.newButton{
        label="Running Game",
        labelColor = { default={255}, over={128} },
        defaultFile="images/ChoosePlayBtn.png",
        width=250, height=60,
        onRelease = onRunBtnRelease,	-- event listener function
        font = fontName,
        fontSize = 26
    }
    runBtn:setReferencePoint( display.CenterReferencePoint )
    runBtn.x = display.contentWidth*0.5
    runBtn.y = display.contentHeight - 475

	-- all display objects must be inserted into group
	group:insert( background )
	group:insert( titleLogo )
	group:insert( playBtn )
    group:insert(fgBtn);
    group:insert(passBtn);
    group:insert(runBtn);
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
	
	if playBtn then
		playBtn:removeSelf()	-- widgets must be manually removed
		playBtn = nil
    end
    if layoutBtn then
        layoutBtn:removeSelf()
        layoutBtn = nil;
    end
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