--
-- Created by IntelliJ IDEA.
-- User: binghambryan
-- Date: 2/6/13
-- Time: 8:41 PM
-- To change this template use File | Settings | File Templates.
--

P = {};

function P.new()

    local playBg = display.newImage( "images/PickPlayBtn.png" )
    local playTextTop = display.newText("PASS", 18,14, "Interstate", 15)
    local playTextMiddle = display.newText("DEEP", 18,30, "Interstate", 15)
    local playTextBottom = display.newText("LEFT", 18,46, "Interstate", 15)
    local playText = display.newGroup()

    playText:insert ( playTextTop )
    playText:insert ( playTextMiddle )
    playText:insert ( playTextBottom )

    local play = display.newGroup()

    play:insert ( playBg )
    play:insert ( playText )

    function play:setText(top, middle, bottom)
        playTextTop.text = string.upper(top);
        playTextMiddle.text = string.upper(middle);
        playTextBottom.text = string.upper(bottom);
    end

    return play;

end

return P;