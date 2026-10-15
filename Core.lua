local addonName, addonTable = ...


addonTable.defaultSettings = {
    shortenChat = true,
    zoneNodes = false,
    junkHighlight = false
}

local frame = CreateFrame("Frame")
frame:RegisterEvent("ADDON_LOADED")
frame:SetScript("OnEvent", function(self, event, loadedAddon)
    if loadedAddon ~= addonName then return end

    if not TweaksDB then
        TweaksDB = {}
    end

    for key, value in pairs(addonTable.defaultSettings) do
        if TweaksDB[key] == nil then
            TweaksDB[key] = value
        end
    end

    addonTable.DB = TweaksDB
    self:UnregisterEvent("ADDON_LOADED")

end)