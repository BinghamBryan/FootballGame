-----------------------------------------------------------------------------------------
--
-- game.lua
--
-----------------------------------------------------------------------------------------

local storyboard = require( "storyboard" )
local scene = storyboard.newScene()

local widget = require("widget")
local Navbar = require("Navbar");
local TeamScoreArea = require("TeamScoreArea");
local GameStatusArea = require("GameStatusArea");
local ChoosePlaysArea = require("ChoosePlaysArea");
local Field = require("Field");

-- include Corona's "physics" library
local physics = require "physics"
physics.start(); physics.pause()
--------------------------------------------
--[GLOBALS]
selectedPlays = {};

--[VARIABLES]
-- forward declarations and other locals
local screenW, screenH, halfW = display.contentWidth, display.contentHeight, display.contentWidth*0.5
local navbar;
local homeTeamScoreArea;
local awayTeamScoreArea;
local choosePlaysArea;
local field;
local gameStatusArea;

--Game variables
local currentQuarter = 1;
local currentTime = 900; -- in seconds
local currentYardLine = 80;
local homeScore = 0;
local awayScore = 0;
local currentDown = 1;
local yardsToGo = 10;
local homeTimeouts = 3;
local awayTimeouts = 3;
local possession = 0; -- 0 = Home, 1 = Away


--[FUNCTIONS]
function runPlays(e)
    local self = e.target --the button
    --gsChoosePlaysMessageText:removeSelf();
    local playsChosen = "";
    local gameOver = false;
    local totalYardsGained = 0;
    for i = 0, #selectedPlays do
        if (selectedPlays[i] ~= nil and yardsToGo > 0) then
            math.randomseed(os.time());
            local yards = math.floor(selectedPlays[i].maxYards * math.random());
            local isPositive = (selectedPlays[i].probability + math.random()) > 1;

            if (isPositive) then
                totalYardsGained = totalYardsGained + yards;
                yardsToGo = yardsToGo - yards;
                currentYardLine = currentYardLine - yards;
                print("You gained " .. yards .. " Yards!");
            else
                print("Failed to gain yards");
            end
            currentDown = currentDown + 1;

            --Check for first down
            if yardsToGo < 1 then
               break;
            end

            --check for Touchdown
            if currentYardLine < 1 then
                print("TOUCHDOWN!");
                if (possession == 0) then
                    homeScore = homeScore + 7;
                else
                    awayScore = awayScore + 7;
                end
                break;
            end

            --check time
            currentTime = currentTime - 30;
            if currentTime == 0 then
                currentQuarter = currentQuarter + 1;
                if (currentQuarter == 5) then
                    gameOver = true;
                    break;
                else
                    currentTime = 900;
                end
            end
        end
    end
    --Check for game over
    if gameOver then
        print("Game Over");
    --Check if First Down
    elseif (yardsToGo < 1) then
        print("First Down! Pick 3 more plays");
    else
        if possession == 0 then
            possession = 1;
        else
            possession = 0;
        end
        currentYardLine = 80;
        print("Other team is now on offense");
    end


    --Reset
    yardsToGo = 10;
    currentDown = 1;

    --update game screen
    gameStatusArea:setTime(currentTime);
    gameStatusArea:setQuarter(currentQuarter);
    gameStatusArea:setDown(currentDown);

    homeTeamScoreArea:setScore(homeScore);
    awayTeamScoreArea:setScore(awayScore);
    gameStatusArea:setTime(currentTime);

end

--[LISTENERS]

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

    --Ryan's Layout Start
    local uiBackground = display.newImage( "images/UIBg.jpg" )


    --NavBar Layout
    navbar = Navbar.new();

    --GameScreen Home Team Score Area Layout
    homeTeamScoreArea = TeamScoreArea.new();
    homeTeamScoreArea:setTeamName("Rock cats")
    homeTeamScoreArea:setLogo("images/TeamLogoBg-RC.png");
    homeTeamScoreArea:setUsername("Player 1");
    homeTeamScoreArea:setScore(42)
    homeTeamScoreArea.x, homeTeamScoreArea.y = 40, 85

    --GameScreen Away Team Score Area Layout
    awayTeamScoreArea = TeamScoreArea.new();
    awayTeamScoreArea:setTeamName("Cubs")
    awayTeamScoreArea:setLogo("images/TeamLogoBg-Cubs.png");
    awayTeamScoreArea:setUsername("Player 2");
    awayTeamScoreArea:setScore(28)
    awayTeamScoreArea.x, awayTeamScoreArea.y = 345, 85

    --GameScreen Game Status Area Layout

    gameStatusArea = GameStatusArea.new();
    gameStatusArea:setQuarter("1st Qtr");
    gameStatusArea:setTime(currentTime);
    gameStatusArea:setDown(currentDown);
    gameStatusArea:setYardsToGo(yardsToGo);
    gameStatusArea.x, gameStatusArea.y = 650, 85;


    --GameScreen Choose Plays Area Layout
    choosePlaysArea = ChoosePlaysArea.new();
    choosePlaysArea.x, choosePlaysArea.y = 648, 136

    --GameScreen Bottom Blue Buttons

    local gsCallTOBg = display.newImage( "images/CallTimeOutBtn.png" )
    local gsCallTOText = display.newText("CALL TIMEOUT", 66,13, "Interstate", 26)
    local gsCallTOBtn = display.newGroup()
    gsCallTOBtn.x, gsCallTOBtn.y = 649, 603

    gsCallTOBtn:insert ( gsCallTOBg )
    gsCallTOBtn:insert ( gsCallTOText )

    --local gsDrivesBg = display.newImage( "images/DrivesBtn.png" )
    local gsDrivesText = display.newText("DRIVES", 33,13, "Interstate", 26)
    local gsDrivesBtn = display.newGroup()
    gsDrivesBtn.x, gsDrivesBtn.y = 649, 671

    --gsDrivesBtn:insert ( gsDrivesBg )
    gsDrivesBtn:insert ( gsDrivesText )

    --local gsStatsBg = display.newImage( "images/DrivesBtn.png" )
    local gsStatsText = display.newText("STATS", 38,13, "Interstate", 26)
    local gsStatsBtn = display.newGroup()
    gsStatsBtn.x, gsStatsBtn.y = 822, 671

    --gsStatsBtn:insert ( gsStatsBg )
    gsStatsBtn:insert ( gsStatsText )

    --GameScreen Field Area
    field = Field.new();
    field.x, field.y = 40, 274;

end

-- Called immediately after scene has moved onscreen:
function scene:enterScene( event )
    local group = self.view

    --physics.start()

end

-- Called when scene is about to move offscreen:
function scene:exitScene( event )
    local group = self.view

    --physics.stop()

end

-- If scene's view is removed, scene:destroyScene() will be called just prior to:
function scene:destroyScene( event )
    local group = self.view

    --package.loaded[physics] = nil
    --dsphysics = nil
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

return scene