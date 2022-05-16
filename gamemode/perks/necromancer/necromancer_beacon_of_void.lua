PERK.PrintName = "Beacon of Void"
PERK.Description =
[[Cold damage ignores enemy Cold damage resistance.
Unlocks Void Cascade for Void Projector ({1} energy, R button).
Perk bonuses to Void Spear also applies to Void Cascade.]]
PERK.Icon = "materials/perks/necromancer/void_cascade.png"
PERK.Params = {
    [1] = {value = 30},
}
PERK.Hooks = {}

PERK.Hooks.Horde_OnPlayerDamagePost = function (ply, npc, bonus, hitgroup, dmginfo)
    if not ply:Horde_GetPerk("necromancer_beacon_of_void")  then return end
    dmginfo:SetDamageType(DMG_DIRECT)
end

--[[PERK.Hooks.Horde_OnPlayerDamage = function (ply, npc, bonus, hitgroup, dmginfo)
    if not ply:Horde_GetPerk("necromancer_beacon_of_void")  then return end
    if HORDE:IsColdDamage(dmginfo) then
        bonus.increase = bonus.increase + 0.2
    end
end


PERK.Hooks.Horde_OnEnemyDebuffApply = function (npc, debuff, bonus, inflictor)
    if debuff == HORDE.Status_Frostbite and inflictor and inflictor:IsValid() and inflictor:Horde_GetPerk("necromancer_beacon_of_void") then
        bonus.increase = bonus.increase + 0.2
    end
end]]--

PERK.Hooks.Horde_OnSetPerk = function(ply, perk)
    if SERVER and perk == "necromancer_beacon_of_void" then
        ply:Horde_SetPerkCooldown(10)
        net.Start("Horde_SyncActivePerk")
            net.WriteUInt(HORDE.Status_Void_Cascade, 8)
            net.WriteUInt(1, 3)
        net.Send(ply)
    end
end

PERK.Hooks.Horde_OnUnsetPerk = function(ply, perk)
    if SERVER and perk == "necromancer_beacon_of_void" then
        net.Start("Horde_SyncActivePerk")
            net.WriteUInt(HORDE.Status_Void_Cascade, 8)
            net.WriteUInt(0, 3)
        net.Send(ply)
    end
end


PERK.Hooks.Horde_UseActivePerk = function (ply)
    if not ply:Horde_GetPerk("necromancer_beacon_of_void") then return end
    local active_weapon = ply:GetActiveWeapon()
    if not active_weapon:IsValid() or not active_weapon:GetClass() == "horde_void_projector" then return false end
    local res = active_weapon:VoidCascade()
    if res then return true end
end