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
local PlayContainer = require("PlayContainer");
local OffensivePlays = require("OffensivePlays");
local DefensivePlays = require("DefensivePlays");
local Field = require("Field");

-- include Corona's "physics" library
local physics = require "physics"
physics.start(); physics.pause()
--------------------------------------------
--[GLOBALS]

--[VARIABLES]
-- forward declarations and other locals
local screenW, screenH, halfW = display.contentWidth, display.contentHeight, display.contentWidth*0.5
local navbar;
local homeTeamScoreArea;
local awayTeamScoreArea;
local choosePlaysArea;
local oPlays;
local dPlays;
local field;
local gameStatusArea;
local isOffenseTurn = true;

--Game variables
local playContainers = {};
local offMove = {};
local defMove = {};
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
    local gameOver = false;
    local totalYardsGained = 0;
    local resultsTable = {};
    resultsTable.offensivePlays = offMove;
    resultsTable.defensivePlays = defMove;
    resultsTable.isTouchdown = false;
    resultsTable.isFirstDown = false;
    resultsTable.isFieldGoal = false;
    resultsTable.FieldGoalLength = 0;
    resultsTable.isPunt = false;
    resultsTable.puntLength = 0;
    resultsTable.yardLine = currentYardLine;
    local resultsString = "";
    print("CURRENT YARD LINE: " .. currentYardLine);
    for i = 0, #offMove do
        if (offMove[i] ~= nil and yardsToGo > 0) then
            math.randomseed(os.time());
            local play = offMove[i];
            --Check Defense
            local playModifier = 0;
            if (play.playType == defMove[i].playType) then
                if (play.playDirection == defMove[i].playDirection) then
                   playModifier = 0; --Perfect guess
                   print("Defesne guessed right");
                else
                    playModifier = 1;
                    print("Defense guessed play type correctly");
                end
            else
                if (offMove[i].playDirection == defMove[i].playDirection) then
                    playModifier = 1;
                    print("Defense guessed play direction correctly");
                else
                    playModifier = 2;
                    print("Defense guessed wrong");
                end
            end
            local yards = math.floor(play.maxYards * math.random());
            local isPositive = (play.probability + math.random()) > 1;
            
            if (playModifier == 0) then
                isPositive = false;
            elseif (playModifier == 2) then
                isPositive = true; 
            end
            
            --Include play modifier
            yards = yards * playModifier;

            if (isPositive) then
                totalYardsGained = totalYardsGained + yards;
                yardsToGo = yardsToGo - yards;
                currentYardLine = currentYardLine - yards;
                print("You gained " .. yards .. " Yards!");
                resultsString = resultsString .. "You gained " .. yards .. " Yards!\n";
                resultsTable.offensivePlays[i].result = yards;
            else
                print("Failed to gain yards");
                resultsString = resultsString .. "Failed to gain yards\n";
                resultsTable.offensivePlays[i].result = 0;
            end
            currentDown = currentDown + 1;

            --check time
            currentTime = currentTime - 30;
            if currentTime <= 0 then
                currentTime = 0; --prevent showing the user negative time
                currentQuarter = currentQuarter + 1;
                if (currentQuarter == 5) then
                    currentQuarter = 4; --prevent showing the user a quarter > 4
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
                resultsTable.isTouchdown = true;
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
        storyboard.gotoScene( "menu", "flipFadeOutIn", 200 )
    elseif currentYardLine < 1 then--Touchdown
        scene:dispatchEvent({name = "onKickoff"});
    elseif (yardsToGo < 1) then--First Down
        print("First Down! Pick 3 more plays");
        resultsString = resultsString .. "First Down! Pick 3 more plays\n";
        resultsTable.isFirstDown = true;
        currentDown = 1;
        yardsToGo = 10;

        --update field markers
        updateFieldMarkers()
    else
        if (currentYardLine + 17 < 60) then
            resultsTable.isFieldGoal = true;
            scene:dispatchEvent({name = "onFieldGoal"})
        else
            resultsTable.isPunt = true;
            scene:dispatchEvent({name = "onPunt"});
        end
    end

    --[UPDATE] game screen
    if currentTime >= 0 then
        gameStatusArea:setTime(currentTime);
    end
    gameStatusArea:setQuarter(currentQuarter);
    gameStatusArea:setDown(currentDown);

    homeTeamScoreArea:setScore(homeScore);
    awayTeamScoreArea:setScore(awayScore);
    return resultsTable;
end

--Update field Markers
function updateFieldMarkers()
    field:updateFirstDownLine(currentYardLine - yardsToGo, possession);
    field:updateLineOfScrimmage(currentYardLine, possession);
end

--Save Plays
function savePlays(type)
    local plays = nil;
    if (type == "offense") then
        plays = offMove;
    else
        plays = defMove;
    end
    for i = 0, #playContainers do
        if playContainers[i].hasPlay then
            plays[i] = playContainers[i].play;
        end
    end
end
--Reset Plays
function resetPlays()
    for i = 0, #playContainers do
        if playContainers[i].hasPlay then
            playContainers[i].hasPlay = false;
            playContainers[i].play.x = playContainers[i].play.homeX;
            playContainers[i].play.y = playContainers[i].play.homeY;
            playContainers[i].play = nil;
        end
    end
end

--[LISTENERS]

-----------------------------------------------------------------------------------------
-- BEGINNING OF YOUR IMPLEMENTATION
--
-- NOTE: Code outside of listener functions (below) will only be executed once,
--		 unless storyboard.removeScene() is called.
--
-----------------------------------------------------------------------------------------
--[SCENE EVENTS]
-- Called when the scene's view does not exist:
function scene:createScene( event )
    local group = self.view

    --Ryan's Layout Start
    local uiBackground = display.newImage( "images/UIBg.jpg" )
    group:insert(uiBackground);

    --NavBar Layout
    navbar = Navbar.new();
    group:insert(navbar);

    --GameScreen Home Team Score Area Layout
    homeTeamScoreArea = TeamScoreArea.new();
    group:insert(homeTeamScoreArea);
    homeTeamScoreArea:setTeamName("Rock cats")
    homeTeamScoreArea:setLogo("images/TeamLogoBg-RC.png");
    homeTeamScoreArea:setUsername("Player 1");
    homeTeamScoreArea:setScore(homeScore)
    homeTeamScoreArea.x, homeTeamScoreArea.y = 40, 85

    --GameScreen Away Team Score Area Layout
    awayTeamScoreArea = TeamScoreArea.new();
    group:insert(awayTeamScoreArea);
    awayTeamScoreArea:setTeamName("Cubs")
    awayTeamScoreArea:setLogo("images/TeamLogoBg-Cubs.png");
    awayTeamScoreArea:setUsername("Player 2");
    awayTeamScoreArea:setScore(awayScore)
    awayTeamScoreArea.x, awayTeamScoreArea.y = 345, 85

    --GameScreen Game Status Area Layout

    gameStatusArea = GameStatusArea.new();
    group:insert(gameStatusArea);
    gameStatusArea:setQuarter(currentQuarter);
    gameStatusArea:setTime(currentTime);
    gameStatusArea:setDown(currentDown);
    gameStatusArea:setYardsToGo(yardsToGo);
    gameStatusArea.x, gameStatusArea.y = 650, 85;


    --GameScreen Choose Plays Area Layout

    choosePlaysArea = display.newGroup();
    --local gsChoosePlaysOuterBg = display.newImage( "images/ChoosePlayOuterBg.png" )
    --gsChoosePlaysOuterBg:setReferencePoint(display.TopLeftReferencePoint)
    --gsChoosePlaysOuterBg.x, gsChoosePlaysOuterBg.y = 0, 59
    --gsChoosePlaysFullGroup:insert ( gsChoosePlaysOuterBg )
    local runPlaysButton = widget.newButton{
        label="CHOOSE YOUR PLAYS",
        labelColor = { default={255}, over={128} },
        defaultFile="images/ChoosePlayBtn.png",
        width=340, height=48,
        onRelease = onPlayBtnRelease,	-- event listener function
        font = "Interstate",
        fontSize = 26
    }
    choosePlaysArea:insert(runPlaysButton);
    --Create 3 containers
    for i = 0, 2 do
        local playc = PlayContainer.new();
        playc:setText(i + 1);
        playc.x, playc.y = 13 + (i * 89), 73
        playc.hasPlay = false;
        choosePlaysArea:insert(playc);
        playContainers[i] = playc;
    end
    --gsChoosePlaysFullGroup:insert();
    oPlays = OffensivePlays.new();
    choosePlaysArea:insert(oPlays);
    dPlays = DefensivePlays.new();
    choosePlaysArea:insert(dPlays);
    dPlays.isVisible = false;
    local gsPowerMeterBg = display.newImage ( "images/PowerMeter.png" )
    gsPowerMeterBg:setReferencePoint( display.TopLeftReferencePoint )
    gsPowerMeterBg.x, gsPowerMeterBg.y = 283, 177

    choosePlaysArea:insert ( gsPowerMeterBg )
    group:insert(choosePlaysArea);
    choosePlaysArea.x, choosePlaysArea.y = 648, 136

    --GameScreen Bottom Blue Buttons

    local gsCallTOBg = display.newImage( "images/CallTimeOutBtn.png" )
    local gsCallTOText = display.newText("CALL TIMEOUT", 66,13, "Interstate", 26)
    local gsCallTOBtn = display.newGroup()
    group:insert(gsCallTOBtn);
    gsCallTOBtn.x, gsCallTOBtn.y = 649, 603

    gsCallTOBtn:insert ( gsCallTOBg )
    gsCallTOBtn:insert ( gsCallTOText )

    --local gsDrivesBg = display.newImage( "images/DrivesBtn.png" )
    local gsDrivesText = display.newText("DRIVES", 33,13, "Interstate", 26)
    local gsDrivesBtn = display.newGroup();
    group:insert(gsDrivesBtn);
    gsDrivesBtn.x, gsDrivesBtn.y = 649, 671

    --gsDrivesBtn:insert ( gsDrivesBg )
    gsDrivesBtn:insert ( gsDrivesText )

    --local gsStatsBg = display.newImage( "images/DrivesBtn.png" )
    local gsStatsText = display.newText("STATS", 38,13, "Interstate", 26)
    local gsStatsBtn = display.newGroup();
    group:insert(gsStatsBtn);
    gsStatsBtn.x, gsStatsBtn.y = 822, 671

    --gsStatsBtn:insert ( gsStatsBg )
    gsStatsBtn:insert ( gsStatsText )

    --GameScreen Field Area
    field = Field.new();
    group:insert(field);
    field.x, field.y = 40, 274;

    --Add Event Listeners
    scene:addEventListener("onPossessionChange");
    scene:addEventListener("onPunt");
    scene:addEventListener("onFieldGoal");
    scene:addEventListener("onKickoff");
    scene:addEventListener("onSendPlays");

end

-- Called immediately after scene has moved onscreen:
function scene:enterScene( event )
    local group = self.view
    --Reset Previous game
    currentQuarter = 1;
    currentTime = 900; -- in seconds
    currentYardLine = 80;
    homeScore = 0;
    awayScore = 0;
    currentDown = 1;
    yardsToGo = 10;
    homeTimeouts = 3;
    awayTimeouts = 3;
    possession = 0; -- 0 = Home, 1 = Away
    if currentTime >= 0 then
        gameStatusArea:setTime(currentTime);
    end
    gameStatusArea:setQuarter(currentQuarter);
    gameStatusArea:setDown(currentDown);

    homeTeamScoreArea:setScore(homeScore);
    awayTeamScoreArea:setScore(awayScore);

    --Do Coin Toss First
    -- display scene overlay
    local options =
    {
        effect = "fade",
        time = 200,
        isModal = true,
        params = { parent = scene }
    }

    storyboard.showOverlay( "Scene_CoinToss", options )
    print("show Overlay");

    --Start game
    possession = 0;
    scene:dispatchEvent({name = "onKickoff" });
end

-- the following event is dispatched once the overlay is in place
function scene:overlayBegan( event )
    print( "Showing overlay: " .. event.sceneName )
end

-- the following event is dispatched once overlay is removed
function scene:overlayEnded( event )
    print(self.choice); --parameter from popup
    print( "Overlay removed: " .. event.sceneName )
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

--[FOOTBALL EVENTS]
function scene:onPossessionChange(event)
    if possession == 0 then
        possession = 1;
        awayTeamScoreArea:togglePossession(true);
        homeTeamScoreArea:togglePossession(false);
    else
        homeTeamScoreArea:togglePossession(true);
        awayTeamScoreArea:togglePossession(false);
        possession = 0;
    end
    yardsToGo = 10;
    currentDown = 1;
    currentYardLine = 100 - currentYardLine;

    --update field markers
    updateFieldMarkers();
    print("Other team is now on offense");
end

function scene:onKickoff(event)
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

    --update field markers
    updateFieldMarkers();

    print("Kickoff: " .. yards .. " yards");
    scene:dispatchEvent({name = "onPossessionChange"});
end

function scene:onPunt(event)
    local maxPunt = 50;
    local minPunt = 30;
    math.randomseed(os.time());
    local yards = math.floor((maxPunt - (maxPunt - minPunt)) * math.random()) + minPunt;
    currentYardLine = currentYardLine - yards;

    if (currentYardLine < 1) then
        currentYardLine = 20;
    end
    scene:dispatchEvent({name = "onPossessionChange"});
    --update time
    currentTime = currentTime - 60;

    --update field markers
    updateFieldMarkers();
    print("PUNT: " .. yards .. " yards");
end

function scene:onFieldGoal(event)
    local fieldGoalLength = currentYardLine + 17;
    local kickProbability = .99;
    if (fieldGoalLength > 30 and fieldGoalLength < 40) then
        kickProbability = .9;
    elseif (fieldGoalLength >= 40 and fieldGoalLength < 50) then
        kickProbability = .75
    elseif (fieldGoalLength >=50) then
        kickProbability = .5;
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

    if (madeKick) then
        scene:dispatchEvent({name = "onKickoff"});
    else
        scene:dispatchEvent({name = "onPossessionChange"});
    end
end

--[GAME EVENTS]
function scene:onSendPlays(event)
    if (event.type == "offense") then
        savePlays("offense");
        resetPlays();
        oPlays.isVisible = false;
        dPlays.isVisible = true;
        isOffenseTurn = false;
        local options =
        {
            effect = "fade",
            time = 200,
            isModal = true,
            params = { parent = scene }
        }

        storyboard.showOverlay( "Scene_Ready", options )
    else
        savePlays("defense");
        local results = runPlays(event);
        resetPlays();
        oPlays.isVisible = true;
        dPlays.isVisible = false;
        isOffenseTurn = true;

        local options =
        {
            effect = "fade",
            time = 200,
            isModal = true,
            params = { parent = scene, results = results }
        }

        storyboard.showOverlay( "Scene_Result", options )
    end
end
--[BUTTON EVENTS]
function onPlayBtnRelease(event)
    local has3plays = true;
    for i = 0, #playContainers do
        if playContainers[i].hasPlay then
            --do nothing
        else
            has3plays = false;
        end
    end
    if has3plays then
        if (isOffenseTurn) then
            scene:dispatchEvent({name = "onSendPlays", type = "offense"});
        else
            scene:dispatchEvent({name = "onSendPlays", type = "defense"});
        end
    else
        print("Please choose 3 plays");
    end
end

--[TOUCH EVENTS]
function playsListener(event)
    local self = event.target;
    local sizeX, sizeY = 80, 80
    local playSizeW, playSizeH = 80, 80;

    if event.phase == "began" then

        self.markX = self.x    -- store x location of object
        self.markY = self.y    -- store y location of object

    elseif event.phase == "moved" and self.markX ~= nil then

        local x = (event.x - event.xStart) + self.markX
        local y = (event.y - event.yStart) + self.markY

        self.x, self.y = x, y    -- move object based on calculations above

        for i = 0, #playContainers do
            local posX, posY =  playContainers[i].x, playContainers[i].y;

            -- do your code to check to see if your object is in your container
            if (((x >= (posX - ((2/3) * sizeX))) and (y >= (posY - ((1/3) * sizeY))) and (x <= (posX + ((2/3) * sizeX))) and (y <= (posY + ((1/3) * sizeY)))) or ((x >= (posX - ((1/3) * sizeX))) and (y >= (posY - ((2/3) * sizeY))) and (x <= (posX + ((1/3) * sizeX))) and (y <= (posY + ((2/3) * sizeY)))) or ((x >= (posX - ((1/2) * sizeX))) and (y >= (posY - ((1/2) * sizeY))) and (x <= (posX + ((1/2) * sizeX))) and (y <= (posY + ((1/2) * sizeY))))) then
                playContainers[i]:setText( "YES" )
            else
                playContainers[i]:setText( "NO" )
            end
        end

    elseif event.phase == "ended" and self.markX ~= nil then

        local x = (event.x - event.xStart) + self.markX
        local y = (event.y - event.yStart) + self.markY
        local isInContainer = false;

        for i = 0, #playContainers do
            local posX, posY =  playContainers[i].x, playContainers[i].y;
            -- main condition: I calculated 3 areas to attract the object to the target container, 2 areas that atract it when it's 1/3 in the target and 1 area that atract it when it's 1/4 in the target
            if (((x >= (posX - ((2/3) * sizeX))) and (y >= (posY - ((1/3) * sizeY))) and (x <= (posX + ((2/3) * sizeX))) and (y <= (posY + ((1/3) * sizeY)))) or ((x >= (posX - ((1/3) * sizeX))) and (y >= (posY - ((2/3) * sizeY))) and (x <= (posX + ((1/3) * sizeX))) and (y <= (posY + ((2/3) * sizeY)))) or ((x >= (posX - ((1/2) * sizeX))) and (y >= (posY - ((1/2) * sizeY))) and (x <= (posX + ((1/2) * sizeX))) and (y <= (posY + ((1/2) * sizeY))))) then
                --check to see if there is already a play there
                if (playContainers[i].hasPlay) then
                    local play = playContainers[i].play;
                    play.x = play.homeX;
                    play.y = play.homeY;
                    playContainers[i].play = nil;
                    playContainers[i].hasPlay = false;
                end
                self.x, self.y = posX, posY;
                playContainers[i].hasPlay = true;
                playContainers[i].play = self;
                isInContainer = true;
                print("play added");
                break;
            end
            if (isInContainer == false) then
                self.x, self.y = self.homeX, self.homeY;
            end
        end
    end
    return true
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

scene:addEventListener( "overlayBegan" )
scene:addEventListener( "overlayEnded" )

-----------------------------------------------------------------------------------------

return scene