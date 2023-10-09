-- Magic spells for Horde
if SERVER then
util.AddNetworkString("Horde_SetSpell")
util.AddNetworkString("Horde_UnsetSpell")
util.AddNetworkString("Horde_SetSpellUpgrades")
end


HORDE.spells = {}

HORDE.Spell_Slot_LMB = 0
HORDE.Spell_Slot_RMB = 1
HORDE.Spell_Slot_Utility = 2
HORDE.Spell_Slot_Reload = 3

HORDE.Spell_Slots = {
    [HORDE.Spell_Slot_LMB] = "LMB",
    [HORDE.Spell_Slot_RMB] = "RMB",
    [HORDE.Spell_Slot_Utility] = "F",
    [HORDE.Spell_Slot_Reload] = "R",
}

HORDE.Spell_Type_Projectile = 0
HORDE.Spell_Type_Hitscan = 1
HORDE.Spell_Type_AOE = 2
HORDE.Spell_Type_Minion = 3
HORDE.Spell_Type_Guard = 4
HORDE.Spell_Type_Displacement = 5
HORDE.Spell_Type_Utility = 6

HORDE.Spell_Type_Strings = {
    [HORDE.Spell_Type_Projectile] = "Projectile",
    [HORDE.Spell_Type_Hitscan] = "Hitscan",
    [HORDE.Spell_Type_AOE] = "Area of Effect",
    [HORDE.Spell_Type_Minion] = "Minion",
    [HORDE.Spell_Type_Guard] = "Guard",
    [HORDE.Spell_Type_Displacement] = "Displacement",
    [HORDE.Spell_Type_Utility] = "Utility",
}

local prefix = "horde/gamemode/spells/"
local function Horde_LoadSpells()
    local dev = GetConVar("developer"):GetBool()
    for _, f in ipairs(file.Find(prefix .. "*", "LUA")) do
        SPELL = {}
        AddCSLuaFile(prefix .. f)
        include(prefix .. f)
        if SPELL.Ignore then goto cont end
        SPELL.ClassName = string.lower(SPELL.ClassName or string.Explode(".", f)[1])

        hook.Run("Horde_OnLoadSpell", SPELL)

        HORDE.spells[SPELL.ClassName] = SPELL

        for k, v in pairs(SPELL.Hooks or {}) do
            hook.Add(k, "horde_spell_" .. SPELL.ClassName, v)
        end

        if dev then print("[Horde] Loaded spell '" .. SPELL.ClassName .. "'.") end
        ::cont::
    end
    SPELL = nil
end

Horde_LoadSpells()

local plymeta = FindMetaTable("Player")

function plymeta:Horde_HasSpell(spell_name)
    if not self.Horde_PlayerSpells then return false end
    local spell = HORDE.spells[spell_name]
    if not self.Horde_PlayerSpells[spell.Slot] then return end
    return self.Horde_PlayerSpells[spell.Slot].ClassName == spell.ClassName
end

function plymeta:Horde_SetSpell(spell_name)
    if not self.Horde_PlayerSpells then self.Horde_PlayerSpells = {} end
    local spell = HORDE.spells[spell_name]
    self.Horde_PlayerSpells[spell.Slot] = spell
    if self:Horde_GetSpellWeapon() then
        self:Horde_GetSpellWeapon():Horde_SetSpell(spell_name)
    end
    if SERVER then
        self:Horde_GetSpellWeapon():Horde_SetSpell(spell_name)
        net.Start("Horde_SetSpell")
            net.WriteString(spell_name)
        net.Send(self)
    end
end

function plymeta:Horde_UnsetSpell(spell_name)
    if not self.Horde_PlayerSpells then return end
    local spell = HORDE.spells[spell_name]
    self.Horde_PlayerSpells[spell.Slot] = nil
    if SERVER then
        self:Horde_GetSpellWeapon():Horde_UnsetSpell(spell_name)
        net.Start("Horde_UnsetSpell")
            net.WriteString(spell_name)
        net.Send(self)
    end
end

function plymeta:Horde_UnsetSpellWeapon()
    if self.Horde_SpellWeapon and self.Horde_SpellWeapon:IsValid() then
        self.Horde_SpellWeapon:Remove()
        self.Horde_SpellWeapon = nil
    end
end

function plymeta:Horde_GetSpellWeapon()
    if not self.Horde_SpellWeapon then
        for _, wpn in pairs(self:GetWeapons()) do
            if wpn.Base == "horde_spell_weapon_base" then
                self.Horde_SpellWeapon = wpn
                return wpn
            end
        end
        return nil
    else
        if self.Horde_SpellWeapon:IsValid() then
            return self.Horde_SpellWeapon
        else
            self.Horde_SpellWeapon = nil
            return self:Horde_GetSpellWeapon()
        end
    end
end

function plymeta:Horde_GetPrimarySpell()
    if not self.Horde_PlayerSpells then return end
    return self.Horde_PlayerSpells[HORDE.Spell_Slot_LMB]
end

function plymeta:Horde_GetSecondarySpell()
    if not self.Horde_PlayerSpells then return end
    return self.Horde_PlayerSpells[HORDE.Spell_Slot_RMB]
end

function plymeta:Horde_GetUtilitySpell()
    if not self.Horde_PlayerSpells then return end
    return self.Horde_PlayerSpells[HORDE.Spell_Slot_Utility]
end

function plymeta:Horde_GetUltimateSpell()
    if not self.Horde_PlayerSpells then return end
    return self.Horde_PlayerSpells[HORDE.Spell_Slot_Reload]
end

function plymeta:Horde_GetPrimarySpellCooldown()
    if not self.Horde_PlayerSpells then return end
    return self:Horde_GetSpellWeapon():GetNextPrimaryFire() - CurTime()
end

function plymeta:Horde_GetSecondarySpellCooldown()
    if not self.Horde_PlayerSpells then return end
    return self:Horde_GetSpellWeapon():GetNextSecondaryFire() - CurTime()
end

function plymeta:Horde_GetUtilitySpellCooldown()
    if not self.Horde_PlayerSpells then return end
    return self:Horde_GetSpellWeapon():GetNextUtilityFire() - CurTime()
end

function plymeta:Horde_GetUltimateSpellCooldown()
    if not self.Horde_PlayerSpells then return end
    return self:Horde_GetSpellWeapon():GetNextUltimateFire() - CurTime()
end

function plymeta:Horde_GetSpellUpgrade(spell_name)
    if not self.Horde_SpellUpgrades then self.Horde_SpellUpgrades = {} end
    return self.Horde_SpellUpgrades[spell_name] or 0
end

function plymeta:Horde_SetSpellUpgrade(spell_name, level)
    if not self.Horde_SpellUpgrades then self.Horde_SpellUpgrades = {} end
    if SERVER then
        net.Start("Horde_SetSpellUpgrades")
            net.WriteString(spell_name)
            net.WriteUInt(level, 8)
        net.Send(self)
    end
    self.Horde_SpellUpgrades[spell_name] = level
end

if CLIENT then
net.Receive("Horde_SetSpellUpgrades", function(len, ply)
    local spell = net.ReadString()
    local level = net.ReadUInt(8)
    MySelf:Horde_SetSpellUpgrade(spell, level)
end)
end

function HORDE:GetSpellUpgradePrice(spell_name, ply)
    local level = ply:Horde_GetSpellUpgrade(spell_name)
    if HORDE.spells[spell_name].Upgrade_Prices then
        return HORDE.spells[spell_name].Upgrade_Prices(level)
    end
    if HORDE.spells[spell_name].Price then
        return HORDE.spells[spell_name].Price / 2 + 100 * level
    else
        return 1000
    end
end

if CLIENT then
net.Receive("Horde_SetSpell", function ()
    MySelf:Horde_SetSpell(net.ReadString())
end)
net.Receive("Horde_UnsetSpell", function ()
    MySelf:Horde_UnsetSpell(net.ReadString())
end)
end


-- Misc Spells
if SERVER then
net.Receive("Horde_BuySpellUpgrade", function (len, ply)
    if not ply:IsValid() or not ply:Alive() then return end
    local class = net.ReadString()
    if not ply:Horde_HasSpell(class) then
        HORDE:SendNotification("You don't have this spell!")
        return
    end

    if ply:Horde_GetSpellUpgrade(class) >= HORDE.spells[class].Upgrades then return end

    local price = HORDE:GetSpellUpgradePrice(class, ply)
    if ply:Horde_GetMoney() >= price then
        ply:Horde_AddMoney(-price)
        ply:Horde_SetSpellUpgrade(class, ply:Horde_GetSpellUpgrade(class) + 1)
        ply:Horde_SyncEconomy()
        sound.Play("items/battery_pickup.wav", ply:GetPos())
    end
end)

function HORDE:RaiseSpectre(ply, param, p2)
    local level = ply:Horde_GetSpellUpgrade("raise_spectre")
    local p = {level = level}
    hook.Run("Horde_OnRaiseSpectre", ply, p)
    local spectres_count = 0
    if ply.Horde_drop_entities["npc_vj_horde_spectre"] then
        spectres_count = spectres_count + ply.Horde_drop_entities["npc_vj_horde_spectre"]
    end
    if ply.Horde_drop_entities["npc_vj_horde_shadow_hulk"] then
        if param and param.hulk_spectre and ply.Horde_drop_entities["npc_vj_horde_shadow_hulk"] >= 1 then
            return true
        end
        spectres_count = spectres_count + ply.Horde_drop_entities["npc_vj_horde_shadow_hulk"]
    end
    if spectres_count >= ply.Horde_Spectre_Max_Count then
        return true
    end
    ply:EmitSound("horde/spells/raise.ogg")
    local ent
    if param and param.hulk_spectre then
        ent = ents.Create("npc_vj_horde_shadow_hulk")
    else
        ent = ents.Create("npc_vj_horde_spectre")
    end
    ent.properties = p
    local pos = ply:GetPos()
    local dir = (ply:GetEyeTrace().HitPos - pos)
    dir:Normalize()
    local drop_pos = pos + dir * 50
    drop_pos.z = pos.z + 24
    ent:SetPos(drop_pos)
    if p2 then
        ent:SetPos(p2)
    end
    ent:SetAngles(Angle(0, ply:GetAngles().y, 0))
    ply:Horde_AddDropEntity(ent:GetClass(), ent)
    ent:SetNWEntity("HordeOwner", ply)
    ent:Spawn()

    timer.Simple(0.1, function ()
        if param and param.greater_spectre then
            ent:Horde_SetGreaterSpectre()
        end
        ent:AddRelationship("player D_LI 99")
        ent:AddRelationship("ally D_LI 99")
        if HORDE.items["npc_vj_horde_vortigaunt"] then
            ent:AddRelationship("npc_vj_horde_vortigaunt D_LI 99")
        end
        if HORDE.items["npc_vj_horde_combat_bot"] then
            ent:AddRelationship("npc_vj_horde_combat_bot D_LI 99")
        end
        if HORDE.items["npc_turret_floor"] then
            ent:AddRelationship("npc_turret_floor D_LI 99")
        end
        if HORDE.items["npc_manhack"] then
            ent:AddRelationship("npc_manhack D_LI 99")
        end
    end)

    -- Special case for turrets
    local id = ent:GetCreationID()
    ent:SetCollisionGroup(COLLISION_GROUP_PASSABLE_DOOR)

    -- Count Minions
    ply:Horde_SetMinionCount(ply:Horde_GetMinionCount() + 1)

    ent:CallOnRemove("Horde_EntityRemoved", function()
        if ent:IsValid() and ply:IsValid() then
            timer.Remove("Horde_MinionCollision" .. ent:GetCreationID())
            ply:Horde_RemoveDropEntity(ent:GetClass(), ent:GetCreationID())
            ply:Horde_SyncEconomy()
            ply:Horde_SetMinionCount(ply:Horde_GetMinionCount() - 1)
        end
    end)
end

function HORDE:RemoveSpectres(ply)
    if HORDE.player_drop_entities[ply:SteamID()] then
        for id, ent in pairs(HORDE.player_drop_entities[ply:SteamID()]) do
            if ent:IsNPC() and (ent:GetClass() == "npc_vj_horde_spectre" or ent:GetClass() == "npc_vj_horde_shadow_hulk") then
                ent:Remove()
            end
        end
    end
end
end