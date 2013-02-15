--
-- Created by IntelliJ IDEA.
-- User: binghambryan
-- Date: 2/12/13
-- Time: 8:09 PM
-- To change this template use File | Settings | File Templates.
--

GSA = {};

function GSA.new()

    local gsQuarterText = display.newText("", 0,0, "Interstate", 20)
    gsQuarterText:setReferencePoint( display.TopCenterReferencePoint )
    gsQuarterText.text = string.upper( "3rd qtr" )
    gsQuarterText.x, gsQuarterText.y = 64, 0

    local gsCurrentGameTimeText = display.newText("", 0,0, "Interstate", 34)
    gsCurrentGameTimeText:setReferencePoint( display.TopCenterReferencePoint )
    gsCurrentGameTimeText.x, gsCurrentGameTimeText.y = 64, 26

    local gsCurrentDownTopText = display.newText("", 0,0, "Interstate", 27)
    gsCurrentDownTopText:setReferencePoint( display.TopCenterReferencePoint )
    gsCurrentDownTopText.x, gsCurrentDownTopText.y = 230, 0

    local gsCurrentDownBottomText = display.newText("", 0,0, "Interstate", 27)
    gsCurrentDownBottomText:setReferencePoint( display.TopCenterReferencePoint )
    gsCurrentDownBottomText.x, gsCurrentDownBottomText.y = 230, 28

    local gsGameStatusBox = display.newGroup()

    gsGameStatusBox:insert ( gsQuarterText )
    gsGameStatusBox:insert ( gsCurrentGameTimeText )
    gsGameStatusBox:insert ( gsCurrentDownTopText )
    gsGameStatusBox:insert ( gsCurrentDownBottomText )

    function gsGameStatusBox:setQuarter(quarter)
        gsQuarterText.text = string.upper(quarter .. " qtr");
    end

    --Update the time: parameter in seconds
    function gsGameStatusBox:setTime(time)
        local minutes = math.floor(time / 60);
        local seconds = time % 60;
        gsCurrentGameTimeText.text = minutes .. ":" .. seconds;
    end

    function gsGameStatusBox:setDown(down)
        gsCurrentDownTopText.text = string.upper(down .. " down");
    end

    function gsGameStatusBox:setYardsToGo(yards)
        gsCurrentDownBottomText.text = string.upper("And " .. yards);
    end

    return gsGameStatusBox;
end

return GSA;