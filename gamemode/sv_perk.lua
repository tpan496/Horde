util.AddNetworkString("Horde_Perk")
util.AddNetworkString("Horde_PerkChoice")

local plymeta = FindMetaTable("Player")

function plymeta:Horde_ApplyPerksForClass()
    local class = self:GetHordeClass().name

    --print(self, "Horde_ApplyPerksForClass", class)

    self:Horde_ClearPerks()

    self.Horde_PerkChoices = self.Horde_PerkChoices or {}
    self.Horde_PerkChoices[class] = self.Horde_PerkChoices[class] or {}

    for perk_level, v in pairs(HORDE.classes[class].perks) do
        if HORDE.current_wave < Horde_GetWaveForPerk(perk_level) then continue end
        local choice = v.choices[self.Horde_PerkChoices[class][perk_level] or 1] -- TODO get and respect player's choice in perks
        if not choice then error("Invalid choice in perk level " .. perk_level .. " for " .. class .. "!") return end
        for perk, params in pairs(choice.perks) do
            if self:Horde_GetPerk(perk) then continue end
            self:Horde_SetPerk(perk, params)
        end
    end

    self.Horde_PerksSet = true
end

net.Receive("Horde_PerkChoice", function(len, ply)
    local class = net.ReadString()
    ply.Horde_PerkChoices = ply.Horde_PerkChoices or {}
    ply.Horde_PerkChoices[class] = {}
    local level = net.ReadUInt(4)
    if level == 0 then
        for perk_level, choices in pairs(HORDE.classes[class].perks) do
            ply.Horde_PerkChoices[class][perk_level] = net.ReadUInt(4)
        end
    else
        ply.Horde_PerkChoices[class][level] = net.ReadUInt(4)
    end
    if HORDE.current_break_time > 0 then
        -- Set the current perk choice and unset all others
        for c, v in pairs(HORDE.classes[class].perks[level].choices) do
            if c == ply.Horde_PerkChoices[class][level] then
                for perk, param in pairs(v.perks) do ply:Horde_SetPerk(perk, param) end
            else
                for perk, param in pairs(v.perks) do ply:Horde_UnsetPerk(perk) end
            end
        end
    end
end)