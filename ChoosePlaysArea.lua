--
-- Created by IntelliJ IDEA.
-- User: binghambryan
-- Date: 2/12/13
-- Time: 8:31 PM
-- To change this template use File | Settings | File Templates.
--

CPA = {};
local PlayContainer = require("PlayContainer")
local Play = require("Play");
local widget = require("widget");

local sizeX, sizeY = 80, 80
local playSizeW, playSizeH = 80, 80;

local plays = {};

local function playsListener(event)
    local self = event.target;
    if event.phase == "began" then

        self.markX = self.x    -- store x location of object
        self.markY = self.y    -- store y location of object

    elseif event.phase == "moved" then

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

    elseif event.phase == "ended" then

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
local function onPlayBtnRelease(event)
    local has3plays = true;
    for i = 0, #playContainers do
        if playContainers[i].hasPlay then
            --do nothing
        else
            has3plays = false;
        end
    end
    if has3plays then
        runPlays(event);
    else
        print("Please choose 3 plays");
    end
end

function CPA.new()
    local gsChoosePlaysFullGroup = display.newGroup();
    local runPlaysButton = widget.newButton{
        label="CHOOSE YOUR PLAYS",
        labelColor = { default={255}, over={128} },
        default="images/ChoosePlayBtn.png",
        width=340, height=48,
        onRelease = onPlayBtnRelease,	-- event listener function
        font = "Interstate",
        fontSize = 26
    }

    gsChoosePlaysFullGroup:insert(runPlaysButton);

    --local gsChoosePlaysOuterBg = display.newImage( "images/ChoosePlayOuterBg.png" )
    --gsChoosePlaysOuterBg:setReferencePoint(display.TopLeftReferencePoint)
    --gsChoosePlaysOuterBg.x, gsChoosePlaysOuterBg.y = 0, 59

    --Create 3 containers
    for i = 0, 2 do
        local playc = PlayContainer.new();
        playc:setText(i + 1);
        playc.x, playc.y = 13 + (i * 89), 73
        playc.hasPlay = false;
        gsChoosePlaysFullGroup:insert(playc);
        playContainers[i] = playc;
    end

    --Play Buttons
    local playPassDeepLeft = Play.new();
    playPassDeepLeft.x, playPassDeepLeft.y = 14, 177
    playPassDeepLeft.homeX, playPassDeepLeft.homeY = 14, 177
    playPassDeepLeft:setText("Pass", "Deep", "Left");
    playPassDeepLeft:addEventListener("touch", playsListener)
    playPassDeepLeft.name = "Deep Pass Left";
    playPassDeepLeft.maxYards = 50;
    playPassDeepLeft.probability = .2;
    plays[0] = playPassDeepLeft;
    gsChoosePlaysFullGroup:insert(playPassDeepLeft);

    local playPassDeepMiddle = Play.new();
    playPassDeepMiddle.x, playPassDeepMiddle.y = 103, 177
    playPassDeepMiddle.homeX, playPassDeepMiddle.homeY = 103, 177
    playPassDeepMiddle:setText("Pass", "Deep", "Middle");
    playPassDeepMiddle:addEventListener("touch", playsListener)
    playPassDeepMiddle.name = "Deep Pass Middle";
    playPassDeepMiddle.maxYards = 35;
    playPassDeepMiddle.probability = .2;
    plays[1] = playPassDeepMiddle;
    gsChoosePlaysFullGroup:insert(playPassDeepMiddle);

    local playPassDeepRight = Play.new();
    playPassDeepRight.x, playPassDeepRight.y = 192, 177
    playPassDeepRight.homeX, playPassDeepRight.homeY = 192, 177
    playPassDeepRight:setText("Pass", "Deep", "Right");
    playPassDeepRight:addEventListener("touch", playsListener)
    playPassDeepRight.name = "Deep Pass Right";
    playPassDeepRight.maxYards = 50;
    playPassDeepRight.probability = .2;
    plays[2] = playPassDeepRight;
    gsChoosePlaysFullGroup:insert(playPassDeepRight);

    local playPassShortLeft = Play.new();
    playPassShortLeft.x, playPassShortLeft.y = 14, 267
    playPassShortLeft.homeX, playPassShortLeft.homeY = 14, 267
    playPassShortLeft:setText("Pass", "Short", "Left");
    playPassShortLeft:addEventListener("touch", playsListener)
    playPassShortLeft.name = "Deep Short Left";
    playPassShortLeft.maxYards = 20;
    playPassShortLeft.probability = .5;
    plays[3] = playPassShortLeft;
    gsChoosePlaysFullGroup:insert(playPassShortLeft);

    local playPassShortMiddle = Play.new();
    playPassShortMiddle.x, playPassShortMiddle.y = 103, 267
    playPassShortMiddle.homeX, playPassShortMiddle.homeY = 103, 267
    playPassShortMiddle:setText("Pass", "Short", "Middle");
    playPassShortMiddle:addEventListener("touch", playsListener)
    playPassShortMiddle.name = "Deep Short Middle";
    playPassShortMiddle.maxYards = 15;
    playPassShortMiddle.probability = .5;
    plays[4] = playPassShortMiddle;
    gsChoosePlaysFullGroup:insert(playPassShortMiddle);

    local playPassShortRight = Play.new();
    playPassShortRight.x, playPassShortRight.y = 192, 267
    playPassShortRight.homeX, playPassShortRight.homeY = 192, 267
    playPassShortRight:setText("Pass", "Short", "Right");
    playPassShortRight:addEventListener("touch", playsListener)
    playPassShortRight.name = "Deep Short Right";
    playPassShortRight.maxYards = 20;
    playPassShortRight.probability = .5;
    plays[5] = playPassShortRight;
    gsChoosePlaysFullGroup:insert(playPassShortRight);

    local playRunLeft = Play.new();
    playRunLeft.x, playRunLeft.y = 14, 357
    playRunLeft.homeX, playRunLeft.homeY = 14, 357
    playRunLeft:setText("Run", "Left", "");
    playRunLeft:addEventListener("touch", playsListener)
    playRunLeft.name = "Run Left";
    playRunLeft.maxYards = 15;
    playRunLeft.probability = .8;
    plays[6] = playRunLeft;
    gsChoosePlaysFullGroup:insert(playRunLeft);

    local playRunMiddle = Play.new();
    playRunMiddle.x, playRunMiddle.y = 103, 357
    playRunMiddle.homeX, playRunMiddle.homeY = 103, 357
    playRunMiddle:setText("Run", "Middle", "");
    playRunMiddle:addEventListener("touch", playsListener)
    playRunMiddle.name = "Run Middle";
    playRunMiddle.maxYards = 10;
    playRunMiddle.probability = .9;
    plays[7] = playRunMiddle;
    gsChoosePlaysFullGroup:insert(playRunMiddle);

    local playRunRight = Play.new();
    playRunRight.x, playRunRight.y = 192, 357
    playRunRight.homeX, playRunRight.homeY = 192, 357
    playRunRight:setText("Run", "Right", "");
    playRunRight:addEventListener("touch", playsListener)
    playRunRight.name = "Run Right";
    playRunRight.maxYards = 15;
    playRunRight.probability = .8;
    plays[8] = playRunRight;
    gsChoosePlaysFullGroup:insert(playRunRight);

    local gsPowerMeterBg = display.newImage ( "images/PowerMeter.png" )
    gsPowerMeterBg:setReferencePoint( display.TopLeftReferencePoint )
    gsPowerMeterBg.x, gsPowerMeterBg.y = 283, 177

    --gsChoosePlaysFullGroup:insert ( gsChoosePlaysOuterBg )
    gsChoosePlaysFullGroup:insert ( gsPowerMeterBg )

    return gsChoosePlaysFullGroup;

end

return CPA;