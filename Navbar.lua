--
-- Created by IntelliJ IDEA.
-- User: binghambryan
-- Date: 2/6/13
-- Time: 9:09 PM
-- To change this template use File | Settings | File Templates.
--

NB = {};

function NB.new()

    local navBarBg = display.newImage("images/NavBarBg.jpg" )

    local navBarBackArrowBtn = display.newImage( "images/TopNavHomeBtn.png" )
    navBarBackArrowBtn.x, navBarBackArrowBtn.y = 36, 21

    local navBarHeaderText = display.newText("", 0, 20, "Interstate", 20)
    navBarHeaderText:setTextColor(255, 255, 255)
    navBarHeaderText:setReferencePoint(display.TopCenterReferencePoint)
    navBarHeaderText.x = display.viewableContentWidth/2
    navBarHeaderText.text = "Rock Cats v. Cubs"

    local navBarGroup = display.newGroup()

    navBarGroup:insert( navBarBg )
    navBarGroup:insert( navBarBackArrowBtn )
    navBarGroup:insert( navBarHeaderText)

    return navBarGroup

end

return NB;