util.AddNetworkString("Horde_Perk")
util.AddNetworkString("Horde_PerkChoice")

local plymeta = FindMetaTable("Player")

function plymeta:Horde_ApplyPerksForClass()
    local class = self:Horde_GetClass().name
    -- Apply class base perks
    self:Horde_SetPerk(string.lower(class) .. "_base", {})

    --print(self, "Horde_ApplyPerksForClass", class)

    -- Only do this *after* we receive good perks from client
    -- If we don't have them yet, ask for it
    if not self.Horde_ChoiceReceived then
        net.Start("Horde_PerkChoice")
        net.Send(self)
        return
    end
    self.Horde_ChoiceReceived = false

    self:Horde_ClearPerks()
    -- Apply class base perks
    self:Horde_SetPerk(string.lower(class) .. "_base", {})

    self.Horde_PerkChoices = self.Horde_PerkChoices or {}
    self.Horde_PerkChoices[class] = self.Horde_PerkChoices[class] or {}

    for perk_level, v in pairs(HORDE.classes[class].perks) do
        if HORDE.current_wave < Horde_GetWaveForPerk(perk_level) then goto cont end
        local choice = v.choices[self.Horde_PerkChoices[class][perk_level] or 1]
        if not choice then error("Invalid choice in perk level " .. perk_level .. " for " .. class .. "!") return end
        for perk, _ in pairs(choice.perks) do
            if self:Horde_GetPerk(perk) then goto cont end
            self:Horde_SetPerk(perk)
        end
        ::cont::
    end
end

net.Receive("Horde_PerkChoice", function(len, ply)
    ply.Horde_ChoiceReceived = true
    local class = net.ReadString()
    ply.Horde_PerkChoices = ply.Horde_PerkChoices or {}
    local level = net.ReadUInt(4)
    if level == 0 then
        ply.Horde_PerkChoices[class] = {}
        for perk_level, choices in SortedPairs(HORDE.classes[class].perks) do
            ply.Horde_PerkChoices[class][perk_level] = net.ReadUInt(4)
        end
        ply:Horde_ApplyPerksForClass()
    else
        ply.Horde_PerkChoices[class] = ply.Horde_PerkChoices[class] or {}
        ply.Horde_PerkChoices[class][level] = net.ReadUInt(4)
    end
    if HORDE.current_break_time > 0 then
        -- Set the current perk choice and unset all others
        for c, v in pairs(HORDE.classes[class].perks[level].choices) do
            if c == ply.Horde_PerkChoices[class][level] then
                for perk, _ in pairs(v.perks) do ply:Horde_SetPerk(perk) end
            else
                for perk, _ in pairs(v.perks) do ply:Horde_UnsetPerk(perk) end
            end
        end
    end
end)