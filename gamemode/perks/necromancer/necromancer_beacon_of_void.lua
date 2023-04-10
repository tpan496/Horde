PERK.PrintName = "Beacon of Void"
PERK.Description =
[[{1} more Cold damage.
{2} increased Frostbite duration.
You are immune to Frostbite.]]
PERK.Icon = "materials/perks/necromancer/beacon_of_void.png"
PERK.Params = {
    [1] = {value = 0.2, percent = true},
    [2] = {value = 0.5, percent = true},
}
PERK.Hooks = {}

PERK.Hooks.Horde_OnPlayerDamage = function (ply, npc, bonus, hitgroup, dmginfo)
    if not ply:Horde_GetPerk("necromancer_beacon_of_void")  then return end
    if HORDE:IsColdDamage(dmginfo) then
        bonus.more = bonus.more * 1.2
    end
end


PERK.Hooks.Horde_OnPlayerDebuffApply = function (ply, debuff, bonus)
    if not ply:Horde_GetPerk("necromancer_beacon_of_void")  then return end
    if debuff == HORDE.Status_Frostbite then
        bonus.apply = 0
        return true
    end
end

PERK.Hooks.Horde_OnEnemyFrostbiteApply = function (inflictor, ent, duration_bonus)
    if inflictor and inflictor:IsPlayer() and inflictor:Horde_GetPerk("necromancer_beacon_of_void") then
        duration_bonus.increase = duration_bonus.increase + 0.5
    end
end