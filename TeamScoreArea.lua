--
-- Created by IntelliJ IDEA.
-- User: binghambryan
-- Date: 2/6/13
-- Time: 10:05 PM
-- To change this template use File | Settings | File Templates.
--

TSA = {};

function TSA.new()

    local gsTeamNameText = display.newRetinaText("", 0,0, "Interstate", 20)
    gsTeamNameText:setReferencePoint( display.TopCenterReferencePoint );
    gsTeamNameText.x, gsTeamNameText.y = 0, 0

    local gsTeamUserName = display.newRetinaText("", 0,0, "Interstate", 15)
    gsTeamUserName:setReferencePoint( display.TopCenterReferencePoint );
    gsTeamUserName:setTextColor(136, 136, 136)
    gsTeamUserName.x, gsTeamUserName.y = 0, 138

    local gsTeamScoreText = display.newRetinaText("", 0,0, "Interstate", 90)
    gsTeamScoreText:setReferencePoint( display.TopCenterReferencePoint );
    gsTeamScoreText.x, gsTeamScoreText.y = 178, 60

    local gsPossessionBall = display.newImage( "images/possessionBall.png" )
    gsPossessionBall:setReferencePoint(display.TopLeftReferencePoint)
    gsPossessionBall.x, gsPossessionBall.y = 220, 109

    local gsTeamTimeOutBg = display.newImage( "images/TimeOutOuterBg.png" )
    local gsTeamTimeOutLeft = display.newImage( "images/TimeOutLeft.png" )
    gsTeamTimeOutLeft.x, gsTeamTimeOutLeft.y = 51, 13

    local gsTeamTimeOutBox = display.newGroup()
    gsTeamTimeOutBox.x, gsTeamTimeOutBox.y = 112, 104

    gsTeamTimeOutBox:insert ( gsTeamTimeOutBg )
    gsTeamTimeOutBox:insert ( gsTeamTimeOutLeft )

    local gsTeamScoreInfoBox = display.newGroup()

    gsTeamScoreInfoBox:insert ( gsTeamNameText )
    gsTeamScoreInfoBox:insert ( gsTeamScoreText )
    gsTeamScoreInfoBox:insert ( gsTeamTimeOutBox )
    gsTeamScoreInfoBox:insert ( gsTeamUserName )
    gsTeamScoreInfoBox:insert ( gsPossessionBall )

    function gsTeamScoreInfoBox:setTeamName(name)
        gsTeamNameText.text = string.upper(name);
    end

    function gsTeamScoreInfoBox:setUsername(name)
        gsTeamUserName.text = name;
    end

    function gsTeamScoreInfoBox:setScore(score)
        gsTeamScoreText.text = score;
    end

    function gsTeamScoreInfoBox:setLogo(url)
        local gsTeamLogo = display.newImage( url )
        gsTeamLogo:setReferencePoint(display.TopLeftReferencePoint)
        gsTeamLogo.x, gsTeamLogo.y = -1, 25
        gsTeamScoreInfoBox:insert ( gsTeamLogo )
    end

    function gsTeamScoreInfoBox:togglePossession(hasPos)
        gsPossessionBall.isVisible = hasPos;
    end;

    return gsTeamScoreInfoBox

end

return TSA;