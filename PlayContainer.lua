--
-- Created by IntelliJ IDEA.
-- User: binghambryan
-- Date: 2/12/13
-- Time: 8:32 PM
-- To change this template use File | Settings | File Templates.
--

PC = {};

function PC.new()
    local gsChoosePlaysDownSlotOneBg = display.newImage( "images/PickPlayBtnEnter.png" )
    local gsChoosePlaysDownSlotOneTextDrag = display.newText("DRAG A PLAY", 0,0, "Interstate", 9)
    gsChoosePlaysDownSlotOneTextDrag:setTextColor(40, 40, 40)
    gsChoosePlaysDownSlotOneTextDrag.x, gsChoosePlaysDownSlotOneTextDrag.y = 42, 64

    local gsChoosePlaysDownSlotOneTextDown = display.newText("DOWN", 0,0, "Interstate", 16)
    gsChoosePlaysDownSlotOneTextDown:setTextColor(40, 40, 40)
    gsChoosePlaysDownSlotOneTextDown.x, gsChoosePlaysDownSlotOneTextDown.y = 40, 48

    local gsChoosePlaysDownSlotOneTextDownNum = display.newText("", 0,0, "Interstate", 30)
    gsChoosePlaysDownSlotOneTextDownNum:setReferencePoint(display.TopCenterReferencePoint)
    gsChoosePlaysDownSlotOneTextDownNum:setTextColor(40, 40, 40)
    gsChoosePlaysDownSlotOneTextDownNum.x, gsChoosePlaysDownSlotOneTextDownNum.y = 41, 6

    local playContatainerGroup = display.newGroup()
    playContatainerGroup.x, playContatainerGroup.y = 13, 73

    playContatainerGroup:insert ( gsChoosePlaysDownSlotOneBg )
    playContatainerGroup:insert ( gsChoosePlaysDownSlotOneTextDrag )
    playContatainerGroup:insert ( gsChoosePlaysDownSlotOneTextDown )
    playContatainerGroup:insert ( gsChoosePlaysDownSlotOneTextDownNum )

    function playContatainerGroup:setText(text)
        gsChoosePlaysDownSlotOneTextDownNum.text = string.upper( text );
    end

    return playContatainerGroup;

end

return PC;