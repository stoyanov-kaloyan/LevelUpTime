local LevelUpTimeFrame = CreateFrame("Frame")

local startTime = 0
local LevelUpTimeText = UIParent:CreateFontString(nil, "OVERLAY", "GameFontNormal")
LevelUpTimeText:SetPoint("BOTTOM", UIParent, "BOTTOM", 0, 100)
LevelUpTimeText:SetFont("Fonts\\FRIZQT__.TTF", 12)
LevelUpTimeText:SetTextColor(1, 1, 1)

LevelUpTimeFrame:RegisterEvent("PLAYER_LOGIN")
LevelUpTimeFrame:RegisterEvent("PLAYER_XP_UPDATE")

local function OnAddonLoaded()
    print("LevelUpTime addon loaded.")
    startTime = GetTime()
end

LevelUpTimeFrame:RegisterEvent("ADDON_LOADED")
LevelUpTimeFrame:SetScript("OnEvent", function(self, event, addon)
    if addon == "LevelUpTime" then
        OnAddonLoaded()
    end
    if event == "PLAYER_XP_UPDATE" and UnitLevel("player") < MAX_PLAYER_LEVEL then
        local currentTime = GetTime()
        local playerXP = UnitXP("player")
        local playerXPMax = UnitXPMax("player")
        local elapsed = currentTime - startTime
        local playerXPPerSec = playerXP / elapsed
        
        local remainingXP = playerXPMax - playerXP
        local remainingTime = remainingXP / playerXPPerSec
        
        local hours = math.floor(remainingTime / 3600)
        local minutes = math.floor((remainingTime % 3600) / 60)
        local seconds = math.floor(remainingTime % 60)
        
        LevelUpTimeText:SetText("Time to level up: " .. string.format("%02d:%02d:%02d", hours, minutes, seconds))
    end
end)
