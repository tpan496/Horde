PERK.PrintName = "Demon Strike"
PERK.Description =
[[{1} increased Bleeding buildup.
30% increased Melee damage against Bleeding enemies.
Leech 100% Melee damage dealt during Quickstep.]]
PERK.Icon = "materials/perks/samurai/demon_strike.png"
PERK.Params = {
    [1] = {value = 0.20, percent = true},
}
PERK.Hooks = {}

PERK.Hooks.Horde_OnEnemyDebuffApply = function (npc, debuff, bonus, inflictor)
    if debuff == HORDE.Status_Bleeding and inflictor:Horde_GetPerk("samurai_blood_sanctum") then
        bonus.increase = bonus.increase + 0.2
    end
end

PERK.Hooks.Horde_OnPlayerDamage = function (ply, npc, bonus, hitgroup, dmginfo)
    if not ply:Horde_GetPerk("samurai_blood_sanctum") then return end
    if HORDE:IsMeleeDamage(dmginfo) and npc:Horde_HasDebuff(HORDE.Status_Bleeding) then
        bonus.increase = bonus.increase + 0.3
        if not ply.Horde_In_Quickstep then return end
        HORDE:SelfHeal(ply, dmginfo:GetDamage())
    end
end