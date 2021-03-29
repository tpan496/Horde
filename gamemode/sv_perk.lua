util.AddNetworkString("Horde_Perk")
util.AddNetworkString("Horde_PerkChoice")

local plymeta = FindMetaTable("Player")

function plymeta:Horde_ApplyPerksForClass()
    if GetConVar("horde_enable_perk"):GetInt() ~= 1 then return end
    local class = self:Horde_GetClass().name

    self:Horde_ClearPerks()
    self:Horde_SetPerk(self:Horde_GetClass().base_perk)

    self.Horde_PerkChoices = self.Horde_PerkChoices or {}
    self.Horde_PerkChoices[class] = self.Horde_PerkChoices[class] or {}

    for perk_level, v in pairs(HORDE.classes[class].perks) do
        if HORDE.current_wave < Horde_GetWaveForPerk(perk_level) then goto cont end
        local choice = v.choices[self.Horde_PerkChoices[class][perk_level] or 1]
        if not choice then error("Invalid choice in perk level " .. perk_level .. " for " .. class .. "!") return end
        if self:Horde_GetPerk(choice) then goto cont end
        self:Horde_SetPerk(choice)
        ::cont::
    end
end

net.Receive("Horde_PerkChoice", function(len, ply)
    if GetConVar("horde_enable_perk"):GetInt() ~= 1 then return end
    local class = net.ReadString()
    ply.Horde_PerkChoices = ply.Horde_PerkChoices or {}
    local level = net.ReadUInt(4)
    if level == 0 then
        -- All perks.
        ply.Horde_PerkChoices[class] = {}
        for perk_level, choices in SortedPairs(HORDE.classes[class].perks) do
            ply.Horde_PerkChoices[class][perk_level] = net.ReadUInt(4)
        end
        ply:Horde_ApplyPerksForClass()
    else
        ply.Horde_PerkChoices[class] = ply.Horde_PerkChoices[class] or {}
        ply.Horde_PerkChoices[class][level] = net.ReadUInt(4)
    end

    if HORDE.current_break_time > 0 and level > 0 and (class == ply:Horde_GetClass().name) then
        -- Set the current perk choice and unset all others
        -- Only apply perk changes if the current class is correct
        for c, perk in pairs(HORDE.classes[class].perks[level].choices) do
            if c == ply.Horde_PerkChoices[class][level] then
                ply:Horde_SetPerk(perk)
            else
                ply:Horde_UnsetPerk(perk)
            end
        end
    end
end)