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
function changePossession()
    if possession == 0 then
        possession = 1;
    else
        possession = 0;
    end
    yardsToGo = 10;
    currentDown = 1;
    currentYardLine = 100 - currentYardLine;

    print("Other team is now on offense");
end

function kickoff()
    currentYardLine = 65;
    local maxKick = 80;
    local minKick = 50;
    math.randomseed(os.time());
    local yards = math.floor((maxKick - (maxKick - minKick)) * math.random()) + minKick;
    currentYardLine = currentYardLine - yards;

    --TO DO: program the return

    if (currentYardLine < 1) then
        currentYardLine = 20;
    end
    --update time
    currentTime = currentTime - 20;
    print("Kickoff: " .. yards .. " yards");
    changePossession();
end

function punt()
    local maxPunt = 50;
    local minPunt = 30;
    math.randomseed(os.time());
    local yards = math.floor((maxPunt - (maxPunt - minPunt)) * math.random()) + minPunt;
    currentYardLine = currentYardLine - yards;

    if (currentYardLine < 1) then
        currentYardLine = 20;
    end
    changePossession();
    --update time
    currentTime = currentTime - 60;
    print("PUNT: " .. yards .. " yards");
end

function fieldGoal()
    local fieldGoalLength = currentYardLine + 17;
    local kickProbability = .95;
    if (fieldGoalLength > 30 and fieldGoalLength < 40) then
        kickProbability = .85;
    elseif (fieldGoalLength >= 40 and fieldGoalLength < 50) then
        kickProbability = .6
    elseif (fieldGoalLength >=50) then
        kickProbability = .3;
    end
    math.randomseed(os.time());
    local madeKick = (kickProbability + math.random()) > 1;

    if (madeKick) then
        print("Field goal is good from " .. fieldGoalLength .. " yards out!")
        if (possession == 0) then
            homeScore = homeScore + 3;
        else
            awayScore = awayScore + 3;
        end
    else
        print("Missed field goal from " .. fieldGoalLength .. " yards out");
    end

    return madeKick;
end

function runPlays(e)
    local self = e.target --the button
    local gameOver = false;
    local totalYardsGained = 0;
    print("CURRENT YARD LINE: " .. currentYardLine);
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

            --check time
            currentTime = currentTime - 30;
            if currentTime <= 0 then
                currentQuarter = currentQuarter + 1;
                if (currentQuarter == 5) then
                    gameOver = true;
                    break;
                else
                    currentTime = 900;
                end
            end

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
        end
    end

    --[CHECKS]
    if gameOver then --Game over
        print("Game Over");
        storyboard.gotoScene( "menu", "fade", 1000 )
    elseif currentYardLine < 1 then--Touchdown
        kickoff();
    elseif (yardsToGo < 1) then--First Down
        print("First Down! Pick 3 more plays");
        currentDown = 1;
        yardsToGo = 10;
    else
        if (currentYardLine + 17 < 60) then
            local madeFieldGoal = fieldGoal();
            if (madeFieldGoal) then
               kickoff();
            else
                changePossession();
            end
        else
            punt();
        end
    end

    --[UPDATE] game screen
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
    local gsCallTOText = display.newRetinaText("CALL TIMEOUT", 66,13, "Interstate", 26)
    local gsCallTOBtn = display.newGroup()
    gsCallTOBtn.x, gsCallTOBtn.y = 649, 603

    gsCallTOBtn:insert ( gsCallTOBg )
    gsCallTOBtn:insert ( gsCallTOText )

    --local gsDrivesBg = display.newImage( "images/DrivesBtn.png" )
    local gsDrivesText = display.newRetinaText("DRIVES", 33,13, "Interstate", 26)
    local gsDrivesBtn = display.newGroup()
    gsDrivesBtn.x, gsDrivesBtn.y = 649, 671

    --gsDrivesBtn:insert ( gsDrivesBg )
    gsDrivesBtn:insert ( gsDrivesText )

    --local gsStatsBg = display.newImage( "images/DrivesBtn.png" )
    local gsStatsText = display.newRetinaText("STATS", 38,13, "Interstate", 26)
    local gsStatsBtn = display.newGroup()
    gsStatsBtn.x, gsStatsBtn.y = 822, 671

    --gsStatsBtn:insert ( gsStatsBg )
    gsStatsBtn:insert ( gsStatsText )

    --GameScreen Field Area
    field = Field.new();
    field.x, field.y = 40, 274;

    --Start game
    possession = 0;
    kickoff();

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