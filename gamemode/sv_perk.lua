util.AddNetworkString("Horde_Perk")
util.AddNetworkString("Horde_PerkChoice")
util.AddNetworkString("Horde_SyncPerk")

local plymeta = FindMetaTable("Player")

function plymeta:Horde_ApplyPerksForClass()
    if GetConVar("horde_enable_perk"):GetInt() ~= 1 then return end
    local class = HORDE.Class_Survivor
    if self:Horde_GetClass() then
        class = self:Horde_GetClass().name
    end

    local subclass = HORDE.subclasses[self:Horde_GetSubclass(class)]
    local perks = HORDE.classes[class].perks
    if subclass and subclass.ParentClass then
        class = subclass.PrintName
        perks = subclass.Perks
    end

    self:Horde_ClearPerks()

    if subclass and subclass.ParentClass then
        self:Horde_SetPerk(subclass.BasePerk)
    else
        self:Horde_SetPerk(self:Horde_GetClass().base_perk)
    end

    self.Horde_PerkChoices = self.Horde_PerkChoices or {}
    self.Horde_PerkChoices[class] = self.Horde_PerkChoices[class] or {}
    
    for perk_level, v in pairs(perks) do
        if HORDE.current_wave < HORDE:Horde_GetWaveForPerk(perk_level) then goto cont end
        local c = math.min(2, math.max(1, self.Horde_PerkChoices[class][perk_level] or 1))
        local choice = v.choices[c]
        if not choice then error("Invalid choice in perk level " .. perk_level .. " for " .. class .. "!") return end
        if self:Horde_GetPerk(choice) then goto cont end
        self:Horde_SetPerk(choice)
        ::cont::
    end

    self:Horde_SetMaxHealth()
    self:Horde_SetMaxArmor()
    if self:Horde_GetSpellWeapon() then
        self:Horde_RecalcAndSetMaxMind()
    else
        self:Horde_SetMaxMind(0)
        self:Horde_SetMind(0)
    end

    net.Start("Horde_SyncPerk")
        net.WriteEntity(self)
        net.WriteTable(self.Horde_PerkChoices[class])
    net.Broadcast()
end

net.Receive("Horde_PerkChoice", function(len, ply)
    if GetConVar("horde_enable_perk"):GetInt() ~= 1 then return end
    local class = net.ReadString()
    local subclass = HORDE.subclasses[class]
    local subclass_name = subclass.PrintName
    local perks
    if subclass.ParentClass then
        perks = subclass.Perks
    else
        perks = HORDE.classes[class].perks
    end
    ply.Horde_PerkChoices = ply.Horde_PerkChoices or {}
    local level = net.ReadUInt(4)
    if level == 0 then
        -- All perks.
        ply.Horde_PerkChoices[subclass_name] = {}
        for perk_level, choices in SortedPairs(perks) do
            ply.Horde_PerkChoices[subclass_name][perk_level] = net.ReadUInt(4)
        end
    else
        ply.Horde_PerkChoices[subclass_name] = ply.Horde_PerkChoices[subclass_name] or {}
        ply.Horde_PerkChoices[subclass_name][level] = net.ReadUInt(4)
    end

    net.Start("Horde_SyncPerk")
        net.WriteEntity(ply)
        net.WriteTable(ply.Horde_PerkChoices[class])
    net.Broadcast()

    ply:Horde_SetMaxHealth()
    ply:Horde_SetMaxArmor()
    if ply:Horde_GetSpellWeapon() then
        ply:Horde_RecalcAndSetMaxMind()
    else
        ply:Horde_SetMaxMind(0)
        ply:Horde_SetMind(0)
    end
    

    if HORDE.current_wave < HORDE:Horde_GetWaveForPerk(level) then return end

    if HORDE.current_break_time > 0 and level > 0 and (class == ply:Horde_GetSubclass(ply:Horde_GetClass().name)) then
        -- Set the current perk choice and unset all others
        -- Only apply perk changes if the current class is correct
        for c, perk in pairs(perks[level].choices) do
            local has_perk = ply:Horde_GetPerk(perk)
            if c == ply.Horde_PerkChoices[class][level] and (not has_perk)then
                -- We only set the perk if we do not have this perk
                ply:Horde_SetPerk(perk)
            elseif c ~= ply.Horde_PerkChoices[class][level] and has_perk then
                -- We only reset the perk if we have this perk and it is not selected
                ply:Horde_UnsetPerk(perk)
            end
        end
    end
end)