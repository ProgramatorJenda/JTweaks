local addonName, addonTable = ...

local panel = CreateFrame("Frame", "TweaksOptionsPanel", UIParent)
panel.name = "JTweaks"

local title = CreateFrame(nil, "ARTWORK", "GameFontNormalLarge")
title:SetPoint("TOPLEFT", 16, -16)
title:SetText("JTweaks Configuration")

local function CreateCheckBox(parent, label, key, relativoTo, offsetY)
    local check = CreateFrame("CheckButton", nil, parent, "InterfaceOptionsCheckButtonTemplate")
    check:SetPoint("TOPLEFT", relativoTo, "BOTTOMLEFT", 0, offsetY)
    check.Text:SetText(label)

    check:SetScript("OnShow", function(self)
        self:SetChecked(TweaksDB and TweaksDB[key] or false)
    end)

    check:SetScript("OnClick", function(self)
        TweaksDB[key] = self:GetChecked()
    end)

    return check
end

local chatCheck = CreateCheckBox(panel, "Enable Chat Channel Abbreviations", "shortenChat", title, -20)
local mineNodeCheck = CreateCheckBox(panel, "Enable Mining Resource Map Hover", "zoneResourceHover", chatCheck, -10)
local herbNodeCheck = CreateCheckBox(panel, "Enable Herbalism Resource Map Hover", "zoneResourceHover", mineNodeCheck, -10)
local junkCheck = CreateCheckBox(panel, "Highlight Lowest Value Item When Bags Full", "highlightJunk", herbNodeCheck, -10)

if Settings and Settings.RegisterCanvasLayoutCategory then
    local category = Settings.RegisterCanvasLayoutCategory(panel, panel.name)
    Settings.RegisterAddOnCategory(category)
    addonTable.optionCategory = category
end

-- Slash Commands
SLASH_JTWEAKS1 = "/jtweaks"
SLASH_JTWEAKS2 = "/jt"
SlashCmdList["JTWEAKS"] = function()
    if Settings and Settings.OpenToCategory and addonTable.optionCategory then
        Settings.OpenToCategory(addonTable.optionCategory:GetID())
    end
end