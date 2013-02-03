display.setStatusBar( display.HiddenStatusBar )

local uiBackground = display.newImage( "images/UIBg.jpg" )


--NavBar Layout

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

--GameScreen Home Team Score Area Layout

local gsHomeTeamNameText = display.newText("", 0,0, "Interstate", 20)
gsHomeTeamNameText.text = string.upper( "Rock Cats" )
gsHomeTeamNameText:setReferencePoint( display.TopLeftReferencePoint )
gsHomeTeamNameText.x, gsHomeTeamNameText.y = 0, 0

local gsHomeTeamLogo = display.newImage( "images/TeamLogoBg-RC.png" )
gsHomeTeamLogo:setReferencePoint(display.TopLeftReferencePoint)
gsHomeTeamLogo.x, gsHomeTeamLogo.y = -1, 25

local gsHomeTeamUserName = display.newText("", 0,0, "Interstate", 15)
gsHomeTeamUserName.text = "UsernameOfPlayerOne"
gsHomeTeamUserName:setReferencePoint( display.TopLeftReferencePoint )
gsHomeTeamUserName:setTextColor(136, 136, 136)
gsHomeTeamUserName.x, gsHomeTeamUserName.y = 0, 138

local gsHomeTeamScoreText = display.newText("", 0,0, "Interstate", 90)
gsHomeTeamScoreText:setReferencePoint( display.TopCenterReferencePoint )
gsHomeTeamScoreText.text = 42
gsHomeTeamScoreText.x, gsHomeTeamScoreText.y = 178, 60

local gsPossessionBall = display.newImage( "images/possessionBall.png" )
gsPossessionBall:setReferencePoint(display.TopLeftReferencePoint)
gsPossessionBall.x, gsPossessionBall.y = 220, 109

local gsHomeTeamTimeOutBg = display.newImage( "images/TimeOutOuterBg.png" )
local gsHomeTeamTimeOutLeft = display.newImage( "images/TimeOutLeft.png" )
gsHomeTeamTimeOutLeft.x, gsHomeTeamTimeOutLeft.y = 51, 13

local gsHomeTeamTimeOutBox = display.newGroup()
gsHomeTeamTimeOutBox.x, gsHomeTeamTimeOutBox.y = 112, 104

gsHomeTeamTimeOutBox:insert ( gsHomeTeamTimeOutBg )
gsHomeTeamTimeOutBox:insert ( gsHomeTeamTimeOutLeft )

local gsHomeTeamScoreInfoBox = display.newGroup()
gsHomeTeamScoreInfoBox.x, gsHomeTeamScoreInfoBox.y = 40, 85

gsHomeTeamScoreInfoBox:insert ( gsHomeTeamNameText )
gsHomeTeamScoreInfoBox:insert ( gsHomeTeamLogo )
gsHomeTeamScoreInfoBox:insert ( gsHomeTeamScoreText )
gsHomeTeamScoreInfoBox:insert ( gsHomeTeamTimeOutBox )
gsHomeTeamScoreInfoBox:insert ( gsHomeTeamUserName )
gsHomeTeamScoreInfoBox:insert ( gsPossessionBall )


--GameScreen Away Team Score Area Layout

local gsAwayTeamNameText = display.newText("", 0,0, "Interstate", 20)
gsAwayTeamNameText.text = string.upper( "Cubs" )
gsAwayTeamNameText:setReferencePoint( display.TopLeftReferencePoint )
gsAwayTeamNameText.x, gsAwayTeamNameText.y = 0, 0

local gsAwayTeamLogo = display.newImage( "images/TeamLogoBg-Cubs.png" )
gsAwayTeamLogo:setReferencePoint(display.TopLeftReferencePoint)
gsAwayTeamLogo.x, gsAwayTeamLogo.y = -1, 25

local gsAwayTeamUserName = display.newText("", 0,0, "Interstate", 15)
gsAwayTeamUserName.text = "UsernameOfPlayerTwo"
gsAwayTeamUserName:setReferencePoint( display.TopLeftReferencePoint )
gsAwayTeamUserName:setTextColor(136, 136, 136)
gsAwayTeamUserName.x, gsAwayTeamUserName.y = 0, 138

local gsAwayTeamScoreText = display.newText("", 0,0, "Interstate", 90)
gsAwayTeamScoreText:setReferencePoint( display.TopCenterReferencePoint )
gsAwayTeamScoreText.text = 28
gsAwayTeamScoreText.x, gsAwayTeamScoreText.y = 178, 60

local gsAwayTeamTimeOutBg = display.newImage( "images/TimeOutOuterBg.png" )
local gsAwayTeamTimeOutLeft = display.newImage( "images/TimeOutLeft.png" )
gsAwayTeamTimeOutLeft.x, gsAwayTeamTimeOutLeft.y = 51, 13

local gsAwayTeamTimeOutBox = display.newGroup()
gsAwayTeamTimeOutBox.x, gsAwayTeamTimeOutBox.y = 112, 104

gsAwayTeamTimeOutBox:insert ( gsAwayTeamTimeOutBg )
gsAwayTeamTimeOutBox:insert ( gsAwayTeamTimeOutLeft )

local gsAwayTeamScoreInfoBox = display.newGroup()
gsAwayTeamScoreInfoBox.x, gsAwayTeamScoreInfoBox.y = 345, 85

gsAwayTeamScoreInfoBox:insert ( gsAwayTeamNameText )
gsAwayTeamScoreInfoBox:insert ( gsAwayTeamLogo )
gsAwayTeamScoreInfoBox:insert ( gsAwayTeamScoreText )
gsAwayTeamScoreInfoBox:insert ( gsAwayTeamTimeOutBox )
gsAwayTeamScoreInfoBox:insert ( gsAwayTeamUserName )

--GameScreen Game Status Area Layout

local gsQuarterText = display.newText("", 0,0, "Interstate", 20)
gsQuarterText:setReferencePoint( display.TopCenterReferencePoint )
gsQuarterText.text = string.upper( "3rd qtr" )
gsQuarterText.x, gsQuarterText.y = 64, 0

local gsCurrentGameTimeText = display.newText("", 0,0, "Interstate", 34)
gsCurrentGameTimeText:setReferencePoint( display.TopCenterReferencePoint )
gsCurrentGameTimeText.text = 12 .. ":" .. 48
gsCurrentGameTimeText.x, gsCurrentGameTimeText.y = 64, 26

local gsCurrentDownTopText = display.newText("", 0,0, "Interstate", 27)
gsCurrentDownTopText:setReferencePoint( display.TopCenterReferencePoint )
gsCurrentDownTopText.text = string.upper( "1st down" )
gsCurrentDownTopText.x, gsCurrentDownTopText.y = 230, 0

local gsCurrentDownBottomText = display.newText("", 0,0, "Interstate", 27)
gsCurrentDownBottomText:setReferencePoint( display.TopCenterReferencePoint )
gsCurrentDownBottomText.text = string.upper( "and " ) .. 10
gsCurrentDownBottomText.x, gsCurrentDownBottomText.y = 230, 28

local gsGameStatusBox = display.newGroup()
gsGameStatusBox.x, gsGameStatusBox.y = 650, 85

gsGameStatusBox:insert ( gsQuarterText )
gsGameStatusBox:insert ( gsCurrentGameTimeText )
gsGameStatusBox:insert ( gsCurrentDownTopText )
gsGameStatusBox:insert ( gsCurrentDownBottomText )


--GameScreen Choose Plays Area Layout

local gsChoosePlaysMessageBg = display.newImage( "images/ChoosePlayBtn.png" )
gsChoosePlaysMessageBg:setReferencePoint(display.TopLeftReferencePoint)
gsChoosePlaysMessageBg.x, gsChoosePlaysMessageBg.y = 0, 0
local gsChoosePlaysMessageText = display.newText("CHOOSE YOUR PLAYS", 0,0, "Interstate", 26)
gsChoosePlaysMessageText:setReferencePoint(display.TopCenterReferencePoint)
gsChoosePlaysMessageText.x, gsChoosePlaysMessageText.y = 168, 8

local gsChoosePlaysMessageBox = display.newGroup()

gsChoosePlaysMessageBox:insert ( gsChoosePlaysMessageBg )
gsChoosePlaysMessageBox:insert ( gsChoosePlaysMessageText )

local gsChoosePlaysOuterBg = display.newImage( "images/ChoosePlayOuterBg.png" )
gsChoosePlaysOuterBg:setReferencePoint(display.TopLeftReferencePoint)
gsChoosePlaysOuterBg.x, gsChoosePlaysOuterBg.y = 0, 59


--First Drag Box - this should be a loop

local gsChoosePlaysDownSlotOneBg = display.newImage( "images/PickPlayBtnEnter.png" )
local gsChoosePlaysDownSlotOneTextDrag = display.newText("DRAG A PLAY", 0,0, "Interstate", 9)
gsChoosePlaysDownSlotOneTextDrag:setTextColor(40, 40, 40)
gsChoosePlaysDownSlotOneTextDrag.x, gsChoosePlaysDownSlotOneTextDrag.y = 42, 64

local gsChoosePlaysDownSlotOneTextDown = display.newText("DOWN", 0,0, "Interstate", 16)
gsChoosePlaysDownSlotOneTextDown:setTextColor(40, 40, 40)
gsChoosePlaysDownSlotOneTextDown.x, gsChoosePlaysDownSlotOneTextDown.y = 40, 48

local gsChoosePlaysDownSlotOneTextDownNum = display.newText("", 0,0, "Interstate", 30)
gsChoosePlaysDownSlotOneTextDownNum.text = string.upper( "1st" )
gsChoosePlaysDownSlotOneTextDownNum:setReferencePoint(display.TopCenterReferencePoint)
gsChoosePlaysDownSlotOneTextDownNum:setTextColor(40, 40, 40)
gsChoosePlaysDownSlotOneTextDownNum.x, gsChoosePlaysDownSlotOneTextDownNum.y = 41, 6

local gsChoosePlaysDownSlotOneBox = display.newGroup()
gsChoosePlaysDownSlotOneBox.x, gsChoosePlaysDownSlotOneBox.y = 13, 73

gsChoosePlaysDownSlotOneBox:insert ( gsChoosePlaysDownSlotOneBg )
gsChoosePlaysDownSlotOneBox:insert ( gsChoosePlaysDownSlotOneTextDrag )
gsChoosePlaysDownSlotOneBox:insert ( gsChoosePlaysDownSlotOneTextDown )
gsChoosePlaysDownSlotOneBox:insert ( gsChoosePlaysDownSlotOneTextDownNum )

--Second Drag Box

local gsChoosePlaysDownSlotTwoBg = display.newImage( "images/PickPlayBtnEnter.png" )
local gsChoosePlaysDownSlotTwoTextDrag = display.newText("DRAG A PLAY", 0,0, "Interstate", 9)
gsChoosePlaysDownSlotTwoTextDrag:setTextColor(40, 40, 40)
gsChoosePlaysDownSlotTwoTextDrag.x, gsChoosePlaysDownSlotTwoTextDrag.y = 42, 64

local gsChoosePlaysDownSlotTwoTextDown = display.newText("DOWN", 0,0, "Interstate", 16)
gsChoosePlaysDownSlotTwoTextDown:setTextColor(40, 40, 40)
gsChoosePlaysDownSlotTwoTextDown.x, gsChoosePlaysDownSlotTwoTextDown.y = 40, 48

local gsChoosePlaysDownSlotTwoTextDownNum = display.newText("", 0,0, "Interstate", 30)
gsChoosePlaysDownSlotTwoTextDownNum.text = string.upper( "2nd" )
gsChoosePlaysDownSlotTwoTextDownNum:setReferencePoint(display.TopCenterReferencePoint)
gsChoosePlaysDownSlotTwoTextDownNum:setTextColor(40, 40, 40)
gsChoosePlaysDownSlotTwoTextDownNum.x, gsChoosePlaysDownSlotTwoTextDownNum.y = 41, 6

local gsChoosePlaysDownSlotTwoBox = display.newGroup()
gsChoosePlaysDownSlotTwoBox.x, gsChoosePlaysDownSlotTwoBox.y = 102, 73

gsChoosePlaysDownSlotTwoBox:insert ( gsChoosePlaysDownSlotTwoBg )
gsChoosePlaysDownSlotTwoBox:insert ( gsChoosePlaysDownSlotTwoTextDrag )
gsChoosePlaysDownSlotTwoBox:insert ( gsChoosePlaysDownSlotTwoTextDown )
gsChoosePlaysDownSlotTwoBox:insert ( gsChoosePlaysDownSlotTwoTextDownNum )

--Third Drag Box

local gsChoosePlaysDownSlotThreeBg = display.newImage( "images/PickPlayBtnEnter.png" )
local gsChoosePlaysDownSlotThreeTextDrag = display.newText("DRAG A PLAY", 0,0, "Interstate", 9)
gsChoosePlaysDownSlotThreeTextDrag:setTextColor(40, 40, 40)
gsChoosePlaysDownSlotThreeTextDrag.x, gsChoosePlaysDownSlotThreeTextDrag.y = 42, 64

local gsChoosePlaysDownSlotThreeTextDown = display.newText("DOWN", 0,0, "Interstate", 16)
gsChoosePlaysDownSlotThreeTextDown:setTextColor(40, 40, 40)
gsChoosePlaysDownSlotThreeTextDown.x, gsChoosePlaysDownSlotThreeTextDown.y = 40, 48

local gsChoosePlaysDownSlotThreeTextDownNum = display.newText("", 0,0, "Interstate", 30)
gsChoosePlaysDownSlotThreeTextDownNum.text = string.upper( "3rd" )
gsChoosePlaysDownSlotThreeTextDownNum:setReferencePoint(display.TopCenterReferencePoint)
gsChoosePlaysDownSlotThreeTextDownNum:setTextColor(40, 40, 40)
gsChoosePlaysDownSlotThreeTextDownNum.x, gsChoosePlaysDownSlotThreeTextDownNum.y = 41, 6

local gsChoosePlaysDownSlotThreeBox = display.newGroup()
gsChoosePlaysDownSlotThreeBox.x, gsChoosePlaysDownSlotThreeBox.y = 191, 73

gsChoosePlaysDownSlotThreeBox:insert ( gsChoosePlaysDownSlotThreeBg )
gsChoosePlaysDownSlotThreeBox:insert ( gsChoosePlaysDownSlotThreeTextDrag )
gsChoosePlaysDownSlotThreeBox:insert ( gsChoosePlaysDownSlotThreeTextDown )
gsChoosePlaysDownSlotThreeBox:insert ( gsChoosePlaysDownSlotThreeTextDownNum )

--Play Buttons

local gsPassDeepLeftBg = display.newImage( "images/PickPlayBtn.png" )
local gsPassDeepLeftTextTop = display.newText("PASS", 18,14, "Interstate", 15)
local gsPassDeepLeftTextMiddle = display.newText("DEEP", 18,30, "Interstate", 15)
local gsPassDeepLeftTextBottom = display.newText("LEFT", 18,46, "Interstate", 15)
local gsPassDeepLeftText = display.newGroup()

gsPassDeepLeftText:insert ( gsPassDeepLeftTextTop )
gsPassDeepLeftText:insert ( gsPassDeepLeftTextMiddle )
gsPassDeepLeftText:insert ( gsPassDeepLeftTextBottom )

local gsPassDeepLeftBtn = display.newGroup()
gsPassDeepLeftBtn.x, gsPassDeepLeftBtn.y = 14, 177

gsPassDeepLeftBtn:insert ( gsPassDeepLeftBg )
gsPassDeepLeftBtn:insert ( gsPassDeepLeftText )

local gsPassDeepMiddleBg = display.newImage( "images/PickPlayBtn.png" )
local gsPassDeepMiddleTextTop = display.newText("PASS", 18,14, "Interstate", 15)
local gsPassDeepMiddleTextMiddle = display.newText("DEEP", 18,30, "Interstate", 15)
local gsPassDeepMiddleTextBottom = display.newText("MIDDLE", 9,46, "Interstate", 15)
local gsPassDeepMiddleText = display.newGroup()

gsPassDeepMiddleText:insert ( gsPassDeepMiddleTextTop )
gsPassDeepMiddleText:insert ( gsPassDeepMiddleTextMiddle )
gsPassDeepMiddleText:insert ( gsPassDeepMiddleTextBottom )

local gsPassDeepMiddleBtn = display.newGroup()
gsPassDeepMiddleBtn.x, gsPassDeepMiddleBtn.y = 103, 177

gsPassDeepMiddleBtn:insert ( gsPassDeepMiddleBg )
gsPassDeepMiddleBtn:insert ( gsPassDeepMiddleText )

local gsPassDeepRightBg = display.newImage( "images/PickPlayBtn.png" )
local gsPassDeepRightTextTop = display.newText("PASS", 18,14, "Interstate", 15)
local gsPassDeepRightTextMiddle = display.newText("DEEP", 18,30, "Interstate", 15)
local gsPassDeepRightTextBottom = display.newText("RIGHT", 14,46, "Interstate", 15)
local gsPassDeepRightText = display.newGroup()

gsPassDeepRightText:insert ( gsPassDeepRightTextTop )
gsPassDeepRightText:insert ( gsPassDeepRightTextMiddle )
gsPassDeepRightText:insert ( gsPassDeepRightTextBottom )

local gsPassDeepRightBtn = display.newGroup()
gsPassDeepRightBtn.x, gsPassDeepRightBtn.y = 192, 177

gsPassDeepRightBtn:insert ( gsPassDeepRightBg )
gsPassDeepRightBtn:insert ( gsPassDeepRightText )

local gsPassShortLeftBg = display.newImage( "images/PickPlayBtn.png" )
local gsPassShortLeftTextTop = display.newText("PASS", 18,14, "Interstate", 15)
local gsPassShortLeftTextMiddle = display.newText("SHORT", 12,30, "Interstate", 15)
local gsPassShortLeftTextBottom = display.newText("LEFT", 18,46, "Interstate", 15)
local gsPassShortLeftText = display.newGroup()

gsPassShortLeftText:insert ( gsPassShortLeftTextTop )
gsPassShortLeftText:insert ( gsPassShortLeftTextMiddle )
gsPassShortLeftText:insert ( gsPassShortLeftTextBottom )

local gsPassShortLeftBtn = display.newGroup()
gsPassShortLeftBtn.x, gsPassShortLeftBtn.y = 14, 267

gsPassShortLeftBtn:insert ( gsPassShortLeftBg )
gsPassShortLeftBtn:insert ( gsPassShortLeftText )

local gsPassShortMiddleBg = display.newImage( "images/PickPlayBtn.png" )
local gsPassShortMiddleTextTop = display.newText("PASS", 18,14, "Interstate", 15)
local gsPassShortMiddleTextMiddle = display.newText("SHORT", 12,30, "Interstate", 15)
local gsPassShortMiddleTextBottom = display.newText("MIDDLE", 9,46, "Interstate", 15)
local gsPassShortMiddleText = display.newGroup()

gsPassShortMiddleText:insert ( gsPassShortMiddleTextTop )
gsPassShortMiddleText:insert ( gsPassShortMiddleTextMiddle )
gsPassShortMiddleText:insert ( gsPassShortMiddleTextBottom )

local gsPassShortMiddleBtn = display.newGroup()
gsPassShortMiddleBtn.x, gsPassShortMiddleBtn.y = 103, 267

gsPassShortMiddleBtn:insert ( gsPassShortMiddleBg )
gsPassShortMiddleBtn:insert ( gsPassShortMiddleText )

local gsPassShortRightBg = display.newImage( "images/PickPlayBtn.png" )
local gsPassShortRightTextTop = display.newText("PASS", 18,14, "Interstate", 15)
local gsPassShortRightTextMiddle = display.newText("SHORT", 12,30, "Interstate", 15)
local gsPassShortRightTextBottom = display.newText("RIGHT", 14,46, "Interstate", 15)
local gsPassShortRightText = display.newGroup()

gsPassShortRightText:insert ( gsPassShortRightTextTop )
gsPassShortRightText:insert ( gsPassShortRightTextMiddle )
gsPassShortRightText:insert ( gsPassShortRightTextBottom )

local gsPassShortRightBtn = display.newGroup()
gsPassShortRightBtn.x, gsPassShortRightBtn.y = 192, 267

gsPassShortRightBtn:insert ( gsPassShortRightBg )
gsPassShortRightBtn:insert ( gsPassShortRightText )

local gsRunLeftBg = display.newImage( "images/PickPlayBtn.png" )
local gsRunLeftTextTop = display.newText("RUN", 21,21, "Interstate", 15)
local gsRunLeftTextBottom = display.newText("LEFT", 18,39, "Interstate", 15)
local gsRunLeftText = display.newGroup()

gsRunLeftText:insert ( gsRunLeftTextTop )
gsRunLeftText:insert ( gsRunLeftTextBottom )

local gsRunLeftBtn = display.newGroup()
gsRunLeftBtn.x, gsRunLeftBtn.y = 14, 357

gsRunLeftBtn:insert ( gsRunLeftBg )
gsRunLeftBtn:insert ( gsRunLeftText )

local gsRunMiddleBg = display.newImage( "images/PickPlayBtn.png" )
local gsRunMiddleTextTop = display.newText("RUN", 21,21, "Interstate", 15)
local gsRunMiddleTextBottom = display.newText("MIDDLE", 9,39, "Interstate", 15)
local gsRunMiddleText = display.newGroup()

gsRunMiddleText:insert ( gsRunMiddleTextTop )
gsRunMiddleText:insert ( gsRunMiddleTextBottom )

local gsRunMiddleBtn = display.newGroup()
gsRunMiddleBtn.x, gsRunMiddleBtn.y = 103, 357

gsRunMiddleBtn:insert ( gsRunMiddleBg )
gsRunMiddleBtn:insert ( gsRunMiddleText )

local gsRunRightBg = display.newImage( "images/PickPlayBtn.png" )
local gsRunRightTextTop = display.newText("RUN", 21,21, "Interstate", 15)
local gsRunRightTextBottom = display.newText("RIGHT", 14,39, "Interstate", 15)
local gsRunRightText = display.newGroup()

gsRunRightText:insert ( gsRunRightTextTop )
gsRunRightText:insert ( gsRunRightTextBottom )

local gsRunRightBtn = display.newGroup()
gsRunRightBtn.x, gsRunRightBtn.y = 192, 357

gsRunRightBtn:insert ( gsRunRightBg )
gsRunRightBtn:insert ( gsRunRightText )

local gsPowerMeterBg = display.newImage ( "images/PowerMeter.png" )
gsPowerMeterBg:setReferencePoint( display.TopLeftReferencePoint )
gsPowerMeterBg.x, gsPowerMeterBg.y = 283, 177

local gsChoosePlaysFullGroup = display.newGroup()
gsChoosePlaysFullGroup.x, gsChoosePlaysFullGroup.y = 648, 136

gsChoosePlaysFullGroup:insert ( gsChoosePlaysMessageBox )
gsChoosePlaysFullGroup:insert ( gsChoosePlaysOuterBg )
gsChoosePlaysFullGroup:insert ( gsChoosePlaysDownSlotOneBox )
gsChoosePlaysFullGroup:insert ( gsChoosePlaysDownSlotTwoBox )
gsChoosePlaysFullGroup:insert ( gsChoosePlaysDownSlotThreeBox )
gsChoosePlaysFullGroup:insert ( gsPassDeepLeftBtn )
gsChoosePlaysFullGroup:insert ( gsPassDeepMiddleBtn )
gsChoosePlaysFullGroup:insert ( gsPassDeepRightBtn )
gsChoosePlaysFullGroup:insert ( gsPassShortLeftBtn )
gsChoosePlaysFullGroup:insert ( gsPassShortMiddleBtn )
gsChoosePlaysFullGroup:insert ( gsPassShortRightBtn )
gsChoosePlaysFullGroup:insert ( gsRunLeftBtn )
gsChoosePlaysFullGroup:insert ( gsRunMiddleBtn )
gsChoosePlaysFullGroup:insert ( gsRunRightBtn )
gsChoosePlaysFullGroup:insert ( gsPowerMeterBg )

--GameScreen Bottom Blue Buttons

local gsCallTOBg = display.newImage( "images/CallTimeOutBtn.png" )
local gsCallTOText = display.newText("CALL TIMEOUT", 66,13, "Interstate", 26)
local gsCallTOBtn = display.newGroup()
gsCallTOBtn.x, gsCallTOBtn.y = 649, 603

gsCallTOBtn:insert ( gsCallTOBg )
gsCallTOBtn:insert ( gsCallTOText )

local gsDrivesBg = display.newImage( "images/DrivesBtn.png" )
local gsDrivesText = display.newText("DRIVES", 33,13, "Interstate", 26)
local gsDrivesBtn = display.newGroup()
gsDrivesBtn.x, gsDrivesBtn.y = 649, 671

gsDrivesBtn:insert ( gsDrivesBg )
gsDrivesBtn:insert ( gsDrivesText )

local gsStatsBg = display.newImage( "images/DrivesBtn.png" )
local gsStatsText = display.newText("STATS", 38,13, "Interstate", 26)
local gsStatsBtn = display.newGroup()
gsStatsBtn.x, gsStatsBtn.y = 822, 671

gsStatsBtn:insert ( gsStatsBg )
gsStatsBtn:insert ( gsStatsText )

--GameScreen Field Area

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
