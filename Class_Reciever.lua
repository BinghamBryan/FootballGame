--
-- Created by IntelliJ IDEA.
-- User: binghambryan
-- Date: 5/10/13
-- Time: 10:51 AM
-- To change this template use File | Settings | File Templates.
--

R = {};
function R.new(routeId)

    --Route {startX, startY, routes = {{dx,dy}, {dx,dy},...}}
    local Routes = {
        {startX = 670, startY = 528, routes = {{dx = 0, dy = -100, time=500}, {dx= -400, dy=-100, time=2000}}}, --Slot right, slant left
        {startX = 776, startY = 530, routes = {{dx = 0, dy = -400, time=2500}}}, --Outside right, straight
        {startX = 304, startY = 528, routes = {{dx = 0, dy = -100, time=500}, {dx= 400, dy=-100, time=2000}}}, --Slot left, slant right
        {startX = 200, startY = 530, routes = {{dx = 0, dy = -400, time=2500}}} --Outside left, straight
    };

    local wideReceiver=  display.newImageRect( "images/fgGame/wideReceiverRight.png", 36, 72 )
    wideReceiver:setReferencePoint( display.TopLeftReferencePoint )
    wideReceiver.route = Routes[routeId];
    wideReceiver.routeCounter = 1;
    wideReceiver.type = "receiver";
    wideReceiver.x, wideReceiver.y =  Routes[routeId].startX, Routes[routeId].startY
    return wideReceiver;

end

return R;