
local addonName, _ = ...

local a = {}
local t = 0
local prefix 
_G.BINDING_NAME_FPS_TOGGLE = "Show / Hide"

local clientRegion = GetLocale()
if clientRegion == "zhCN" then
    prefix = "每秒帧数"
elseif clientRegion == "zhTW" then
    prefix = "每秒幀數"
else
    prefix = "FPS"
end






local function MainDriveOnEvent(self, e, args)
    if e == "ADDON_LOADED" and args == addonName then
        if not fpsdb then 
            fpsdb = {
                ["height"] = -180
            }
        end
        a.drive.text:SetPoint("CENTER", 'UIParent', "CENTER", 0, fpsdb.height)
    end
end

a.drive = CreateFrame("frame")
a.drive:RegisterEvent("ADDON_LOADED");
a.drive:SetScript("OnEvent", MainDriveOnEvent);



a.drive.text = a.drive:CreateFontString(nil, "OVERLAY")
-- a.drive.text:SetFont(STANDARD_TEXT_FONT, 14, "OUTLINE")
a.drive.text:SetFont(STANDARD_TEXT_FONT, 14, nil)
a.drive.text:SetShadowColor(0,0,0,1)
a.drive.text:SetShadowOffset(1,-0.5)
-- a.drive.text:SetPoint("CENTER", 'UIParent', "CENTER", 0, -180)
a.drive.text:SetText('')
a.drive.text:Show()


local function MoveFramerate(y)
    local point, relativeTo, relativePoint, xOfs, yOfs = a.drive.text:GetPoint()
    a.drive.text:SetPoint(point, relativeTo, relativePoint, xOfs, yOfs + y)
    fpsdb.height = yOfs + y
end

local function SwitchDisplay()
    if a.drive.text:IsShown() then
        a.drive.text:Hide()
    else
        a.drive.text:Show()
    end
end

local function SetFramerate()
    a.drive.text:SetText(string.format("%s : %.1f", prefix, GetFramerate()))
end

if not a.ticker then
    a.ticker = C_Timer.NewTicker(0.3, SetFramerate)
end


local function fpsconfig(msg)
    if msg == "u" or msg == "U" then
        MoveFramerate(20)
    elseif msg == "d" or msg == "D" then 
        MoveFramerate(-20)
    elseif msg == "help" then
        -- print("|cffFFD700[ /fps d ]|r: set fps lower")
        -- print("|cffFFD700[ /fps u ]|r: set fps higher")
        -- print("|cffFFD700[ /fps ]|r: switch show/hide fps")
        -- print("|cffFFD700[ Bug Report ]|r: www.curseforge.com")
    elseif msg == "" then
        SwitchDisplay()
    end
end

SLASH_FPS1 = "/fps"
SlashCmdList.FPS = fpsconfig















local frame = CreateFrame("Frame")

frame.Title = frame:CreateFontString(nil, "OVERLAY")
frame.Title:SetFont(STANDARD_TEXT_FONT, 20, nil)
frame.Title:SetPoint("TOPLEFT", frame, "TOPLEFT", 15, -15)
frame.Title:SetJustifyH("LEFT")
frame.Title:Show()
frame.Title:SetText("|cffBBBBBBClassical FPS|r\n\n|cffFFD700[ /fps d ]|r: set fps position lower\n\n|cffFFD700[ /fps u ]|r: set fps position higher\n\n|cffFFD700[ /fps ]|r or |cffFFD700Set Keyblindings|r: toggle show/hide fps")

local category = Settings.RegisterCanvasLayoutCategory(frame, "Classical FPS")
Settings.RegisterAddOnCategory(category)