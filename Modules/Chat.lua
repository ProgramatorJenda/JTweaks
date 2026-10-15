local addonName, addonTable = ...

local chatReplacements = {
    ["%[%d+%. General.-%]"] = "|cff00ff00[G]|r",
    ["%[%d+%. Trade.-%]"] = "|cffff8000[T]|r",
    ["%[%d+%. LocalDefense.-%]"] = "|cffa335ee[LD]|r",
    ["%[%d+%. LookingForGroup.-%]"] = "|cffffd100[LFG]|r"
}

local function ShortenChatChannels(self, event, msg, author, ...)
    if TweaksDB and not TweaksDB.ShortenChatChannels then
        return false, msg, author, ...
    end

    if msg then
        for pattern, replacement in pairs(chatReplacements) do
            msg = string.gsub(msg, pattern, replacement)
        end
    end
    return false, msg, author, ...
end

local chatEvents = {
    "CHAT_MSG_CHANNEL",
    "CHAT_MSG_SAY",
    "CHAT_MSG_YELL",
    "CHAT_MSG_GUILD",
    "CHAT_MSG_PARTY",
    "CHAT_MSG_RAID",
}

for _, event in ipairs(chatEvents) do
    ChatFrame_AddMessageEventFilter(event, ShortenChatChannels)
end