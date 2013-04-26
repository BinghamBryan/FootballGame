--
-- Created by IntelliJ IDEA.
-- User: binghambryan
-- Date: 4/11/13
-- Time: 9:49 PM
-- To change this template use File | Settings | File Templates.
--

DP = {};
local Play = require("Play");
local plays = {};

function DP.new()
    local gsChoosePlaysFullGroup = display.newGroup();
    --Play Buttons
    local playPassDeepLeft = Play.new();
    playPassDeepLeft.x, playPassDeepLeft.y = 14, 177
    playPassDeepLeft.homeX, playPassDeepLeft.homeY = 14, 177
    playPassDeepLeft:setText("Defend", "Deep", "Left");
    playPassDeepLeft:addEventListener("touch", playsListener)
    playPassDeepLeft.name = "Defend Pass Left";
    playPassDeepLeft.maxYards = 50;
    playPassDeepLeft.probability = .2;
    playPassDeepLeft.playType = "PD";
    playPassDeepLeft.playDirection = "Left";
    plays[0] = playPassDeepLeft;
    gsChoosePlaysFullGroup:insert(playPassDeepLeft);

    local playPassDeepMiddle = Play.new();
    playPassDeepMiddle.x, playPassDeepMiddle.y = 103, 177
    playPassDeepMiddle.homeX, playPassDeepMiddle.homeY = 103, 177
    playPassDeepMiddle:setText("Defend", "Deep", "Middle");
    playPassDeepMiddle:addEventListener("touch", playsListener)
    playPassDeepMiddle.name = "Defend Pass Middle";
    playPassDeepMiddle.maxYards = 35;
    playPassDeepMiddle.probability = .2;
    playPassDeepMiddle.playType = "PD";
    playPassDeepMiddle.playDirection = "Middle";
    plays[1] = playPassDeepMiddle;
    gsChoosePlaysFullGroup:insert(playPassDeepMiddle);

    local playPassDeepRight = Play.new();
    playPassDeepRight.x, playPassDeepRight.y = 192, 177
    playPassDeepRight.homeX, playPassDeepRight.homeY = 192, 177
    playPassDeepRight:setText("Defend", "Deep", "Right");
    playPassDeepRight:addEventListener("touch", playsListener)
    playPassDeepRight.name = "Defend Pass Right";
    playPassDeepRight.maxYards = 50;
    playPassDeepRight.probability = .2;
    playPassDeepRight.playType = "PD";
    playPassDeepRight.playDirection = "Right";
    plays[2] = playPassDeepRight;
    gsChoosePlaysFullGroup:insert(playPassDeepRight);

    local playPassShortLeft = Play.new();
    playPassShortLeft.x, playPassShortLeft.y = 14, 267
    playPassShortLeft.homeX, playPassShortLeft.homeY = 14, 267
    playPassShortLeft:setText("Defend", "Short", "Left");
    playPassShortLeft:addEventListener("touch", playsListener)
    playPassShortLeft.name = "Defend Short Left";
    playPassShortLeft.maxYards = 20;
    playPassShortLeft.probability = .5;
    playPassShortLeft.playType = "PS";
    playPassShortLeft.playDirection = "Left";
    plays[3] = playPassShortLeft;
    gsChoosePlaysFullGroup:insert(playPassShortLeft);

    local playPassShortMiddle = Play.new();
    playPassShortMiddle.x, playPassShortMiddle.y = 103, 267
    playPassShortMiddle.homeX, playPassShortMiddle.homeY = 103, 267
    playPassShortMiddle:setText("Defend", "Short", "Middle");
    playPassShortMiddle:addEventListener("touch", playsListener)
    playPassShortMiddle.name = "Defend Short Middle";
    playPassShortMiddle.maxYards = 15;
    playPassShortMiddle.probability = .5;
    playPassShortMiddle.playType = "PS";
    playPassShortMiddle.playDirection = "Middle";
    plays[4] = playPassShortMiddle;
    gsChoosePlaysFullGroup:insert(playPassShortMiddle);

    local playPassShortRight = Play.new();
    playPassShortRight.x, playPassShortRight.y = 192, 267
    playPassShortRight.homeX, playPassShortRight.homeY = 192, 267
    playPassShortRight:setText("Defend", "Short", "Right");
    playPassShortRight:addEventListener("touch", playsListener)
    playPassShortRight.name = "Defend Short Right";
    playPassShortRight.maxYards = 20;
    playPassShortRight.probability = .5;
    playPassShortRight.playType = "PS";
    playPassShortRight.playDirection = "Right";
    plays[5] = playPassShortRight;
    gsChoosePlaysFullGroup:insert(playPassShortRight);

    local playRunLeft = Play.new();
    playRunLeft.x, playRunLeft.y = 14, 357
    playRunLeft.homeX, playRunLeft.homeY = 14, 357
    playRunLeft:setText("Defend", "Run", "Left");
    playRunLeft:addEventListener("touch", playsListener)
    playRunLeft.name = "Defend Run Left";
    playRunLeft.maxYards = 15;
    playRunLeft.probability = .8;
    playRunLeft.playType = "R";
    playRunLeft.playDirection = "Left";
    plays[6] = playRunLeft;
    gsChoosePlaysFullGroup:insert(playRunLeft);

    local playRunMiddle = Play.new();
    playRunMiddle.x, playRunMiddle.y = 103, 357
    playRunMiddle.homeX, playRunMiddle.homeY = 103, 357
    playRunMiddle:setText("Defend", "Run", "Middle");
    playRunMiddle:addEventListener("touch", playsListener)
    playRunMiddle.name = "Defend Run Middle";
    playRunMiddle.maxYards = 10;
    playRunMiddle.probability = .9;
    playRunMiddle.playType = "R";
    playRunMiddle.playDirection = "Middle";
    plays[7] = playRunMiddle;
    gsChoosePlaysFullGroup:insert(playRunMiddle);

    local playRunRight = Play.new();
    playRunRight.x, playRunRight.y = 192, 357
    playRunRight.homeX, playRunRight.homeY = 192, 357
    playRunRight:setText("Defend", "Run", "Right");
    playRunRight:addEventListener("touch", playsListener)
    playRunRight.name = "Defend Run Right";
    playRunRight.maxYards = 15;
    playRunRight.probability = .8;
    playRunRight.playType = "R";
    playRunRight.playDirection = "Right";
    plays[8] = playRunRight;
    gsChoosePlaysFullGroup:insert(playRunRight);

    return gsChoosePlaysFullGroup;

end

return DP;