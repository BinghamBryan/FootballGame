--
-- created with TexturePacker (http://www.codeandweb.com/texturepacker)
--
-- $TexturePacker:SmartUpdate:a03348e4beea552f8ba382b33f0803be$
--
-- local sheetInfo = require("mysheet")
-- local myImageSheet = graphics.newImageSheet( "mysheet.png", sheetInfo:getSheet() )
-- local sprite = display.newSprite( myImageSheet , {frames={sheetInfo:getFrameIndex("sprite")}} )
--

local SheetInfo = {}

SheetInfo.sheet =
{
    frames = {
    
        {
            -- 01
            x=50,
            y=20,
            width=10,
            height=16,

        },
        {
            -- 02
            x=38,
            y=20,
            width=10,
            height=16,

        },
        {
            -- 03
            x=26,
            y=20,
            width=10,
            height=16,

        },
        {
            -- 04
            x=14,
            y=20,
            width=10,
            height=16,

        },
        {
            -- 05
            x=2,
            y=20,
            width=10,
            height=16,

        },
        {
            -- 06
            x=50,
            y=2,
            width=10,
            height=16,

        },
        {
            -- 07
            x=38,
            y=68,
            width=10,
            height=12,

            sourceX = 0,
            sourceY = 2,
            sourceWidth = 10,
            sourceHeight = 16
        },
        {
            -- 08
            x=50,
            y=54,
            width=10,
            height=12,

            sourceX = 0,
            sourceY = 2,
            sourceWidth = 10,
            sourceHeight = 16
        },
        {
            -- 09
            x=38,
            y=54,
            width=10,
            height=12,

            sourceX = 0,
            sourceY = 2,
            sourceWidth = 10,
            sourceHeight = 16
        },
        {
            -- 10
            x=26,
            y=54,
            width=10,
            height=14,

            sourceX = 0,
            sourceY = 0,
            sourceWidth = 10,
            sourceHeight = 16
        },
        {
            -- 11
            x=14,
            y=54,
            width=10,
            height=14,

            sourceX = 0,
            sourceY = 0,
            sourceWidth = 10,
            sourceHeight = 16
        },
        {
            -- 12
            x=2,
            y=54,
            width=10,
            height=14,

            sourceX = 0,
            sourceY = 0,
            sourceWidth = 10,
            sourceHeight = 16
        },
        {
            -- 13
            x=50,
            y=38,
            width=10,
            height=14,

            sourceX = 0,
            sourceY = 0,
            sourceWidth = 10,
            sourceHeight = 16
        },
        {
            -- 14
            x=38,
            y=38,
            width=10,
            height=14,

            sourceX = 0,
            sourceY = 0,
            sourceWidth = 10,
            sourceHeight = 16
        },
        {
            -- 15
            x=26,
            y=38,
            width=10,
            height=14,

            sourceX = 0,
            sourceY = 0,
            sourceWidth = 10,
            sourceHeight = 16
        },
        {
            -- 16
            x=14,
            y=38,
            width=10,
            height=14,

            sourceX = 0,
            sourceY = 0,
            sourceWidth = 10,
            sourceHeight = 16
        },
        {
            -- 17
            x=2,
            y=38,
            width=10,
            height=14,

            sourceX = 0,
            sourceY = 0,
            sourceWidth = 10,
            sourceHeight = 16
        },
        {
            -- 18
            x=38,
            y=2,
            width=10,
            height=16,

        },
        {
            -- 19
            x=26,
            y=2,
            width=10,
            height=16,

        },
        {
            -- 20
            x=14,
            y=2,
            width=10,
            height=16,

        },
        {
            -- 21
            x=2,
            y=2,
            width=10,
            height=16,

        },
    },
    
    sheetContentWidth = 64,
    sheetContentHeight = 128
}

SheetInfo.frameIndex =
{

    ["01"] = 1,
    ["02"] = 2,
    ["03"] = 3,
    ["04"] = 4,
    ["05"] = 5,
    ["06"] = 6,
    ["07"] = 7,
    ["08"] = 8,
    ["09"] = 9,
    ["10"] = 10,
    ["11"] = 11,
    ["12"] = 12,
    ["13"] = 13,
    ["14"] = 14,
    ["15"] = 15,
    ["16"] = 16,
    ["17"] = 17,
    ["18"] = 18,
    ["19"] = 19,
    ["20"] = 20,
    ["21"] = 21,
}

function SheetInfo:getSheet()
    return self.sheet;
end

function SheetInfo:getFrameIndex(name)
    return self.frameIndex[name];
end

return SheetInfo
