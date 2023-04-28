PERK.PrintName = "Bestial Wrath"
PERK.Description = [[
{1} increased Critical Hit damage.
Deals splashing melee damage in Frenzy Mode.
Recover 1 health for each enemy killed in Frenzy Mode.]]
PERK.Icon = "materials/perks/psycho/bestial_wrath.png"
PERK.Params = {
    [1] = {value = 0.25, percent = true},
}
PERK.Hooks = {}

PERK.Hooks.Horde_OnPlayerCritical = function (ply, npc, bonus, hitgroup, dmginfo, crit_bonus)
    if ply:Horde_GetPerk("psycho_bestial_wrath") then
        bonus.increase = bonus.increase + 0.25
    end
end

PERK.Hooks.Horde_OnPlayerDamagePost = function (ply, npc, bonus, hitgroup, dmginfo)
    if ply.Horde_In_Frenzy_Mode and ply:Horde_GetPerk("psycho_bestial_wrath") and HORDE:IsMeleeDamage(dmginfo) then
        local dmg = DamageInfo()
        dmg:SetAttacker(ply)
        dmg:SetInflictor(npc)
        dmg:SetDamageType(dmginfo:GetDamageType())
        dmg:SetDamage(dmginfo:GetDamage() / 2)
        dmg:SetDamageForce(Vector(0,0,0))
        dmg:SetDamageCustom(HORDE.DMG_SPLASH)
        util.BlastDamageInfo(dmg, npc:GetPos(), 150)
    end
end

PERK.Hooks.Horde_OnEnemyKilled = function(victim, killer, wpn)
    if killer.Horde_In_Frenzy_Mode and killer:Horde_GetPerk("psycho_bestial_wrath") then
        HORDE:SelfHeal(killer, 1)
    end
end