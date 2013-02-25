--
-- Created by IntelliJ IDEA.
-- User: binghambryan
-- Date: 2/14/13
-- Time: 7:18 PM
-- To change this template use File | Settings | File Templates.
--

F = {};

function F.new()
    local gsFieldBg = display.newImage( "images/FieldOuter.jpg" )

    local gsHomeEndZoneBg = display.newImage( "images/EndzoneRed.jpg" )
    local gsHomeEndZoneText = display.newText("", 0,0, "Interstate", 36)
    gsHomeEndZoneText.text = string.upper( "Rock Cats" )
    gsHomeEndZoneText:setReferencePoint(display.CenterReferencePoint)
    gsHomeEndZoneText.x, gsHomeEndZoneText.y = 27, 150
    gsHomeEndZoneText:rotate(-90)
    local gsHomeEndZone = display.newGroup()
    gsHomeEndZone.x, gsHomeEndZone.y = 5, 5

    gsHomeEndZone:insert ( gsHomeEndZoneBg )
    gsHomeEndZone:insert ( gsHomeEndZoneText )

    local gsAwayEndZoneBg = display.newImage( "images/EndzoneBlue.jpg" )
    local gsAwayEndZoneText = display.newText("", 0,0, "Interstate", 36)
    gsAwayEndZoneText.text = string.upper( "Cubs" )
    gsAwayEndZoneText:setReferencePoint(display.CenterReferencePoint)
    gsAwayEndZoneText.x, gsAwayEndZoneText.y = 27, 150
    gsAwayEndZoneText:rotate(90)
    local gsAwayEndZone = display.newGroup()
    gsAwayEndZone.x, gsAwayEndZone.y = 510, 5

    gsAwayEndZone:insert ( gsAwayEndZoneBg )
    gsAwayEndZone:insert ( gsAwayEndZoneText )

    local gsLineOfScrimmage = display.newImage( "images/fieldLineOfScrimmage.png" )
    gsLineOfScrimmage:setReferencePoint(display.TopLeftReferencePoint)
    gsLineOfScrimmage.x, gsLineOfScrimmage.y = 349, 5

    local gsFirstDownLine = display.newImage( "images/fieldFirstDownLine.png" )
    gsFirstDownLine:setReferencePoint(display.TopLeftReferencePoint)
    gsFirstDownLine.x, gsFirstDownLine.y = 304, 5

    local gsFieldGroup = display.newGroup()
    gsFieldGroup.x, gsFieldGroup.y = 40, 274

    gsFieldGroup:insert ( gsFieldBg )
    gsFieldGroup:insert ( gsHomeEndZone )
    gsFieldGroup:insert ( gsAwayEndZone )
    gsFieldGroup:insert ( gsLineOfScrimmage )
    gsFieldGroup:insert ( gsFirstDownLine )

    function gsFieldGroup:updateLineOfScrimmage(yardLine, possession)
        gsLineOfScrimmage.x = getXForYardLine(yardLine, possession);
    end

    function gsFieldGroup:updateFirstDownLine(yardLine,possession)
        gsFirstDownLine.x = getXForYardLine(yardLine, possession);
    end

    function getXForYardLine(yardLine, possession)
        local x = 0;
        local offset = 0;
        local fieldWidth = 450;
        local pixelsPerYard = fieldWidth / 100;
        local endZoneWidth = 60;
        if (possession == 0) then -- Home
            x = yardLine * pixelsPerYard + endZoneWidth;
        else --Away
            x = fieldWidth - (yardLine * pixelsPerYard) + endZoneWidth;
        end
        return x - offset;
    end

    return gsFieldGroup;

end

return F;