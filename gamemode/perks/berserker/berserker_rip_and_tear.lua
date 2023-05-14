PERK.PrintName = "Rip and Tear"
PERK.Description = "{1} more melee damage.\nYour melee attack can splash.\n Splash damage is {2} of your melee damage."
PERK.Icon = "materials/perks/rip_and_tear.png"
PERK.Params = {
    [1] = {value = 0.20, percent = true},
    [2] = {value = 0.50, percent = true},
}

PERK.Hooks = {}
PERK.Hooks.Horde_OnPlayerDamage = function (ply, npc, bonus, hitgroup, dmginfo)
    if not ply:Horde_GetPerk("berserker_rip_and_tear") then return end
    if HORDE:IsMeleeDamage(dmginfo) then
        bonus.more = bonus.more * 1.25
    end
end

PERK.Hooks.Horde_OnPlayerDamagePost = function (ply, npc, bonus, hitgroup, dmginfo)
    if ply:Horde_GetPerk("berserker_rip_and_tear") and HORDE:IsMeleeDamage(dmginfo) and not ply.Horde_In_Flash then
        --local e = EffectData()
        --e:SetOrigin(ent:GetPos())
        --util.Effect("Explosion", e)
        --util.BlastDamage(victim, killer, victim:GetPos(), rad, dmg)
        local dmg = DamageInfo()
        dmg:SetAttacker(ply)
        dmg:SetInflictor(npc)
        dmg:SetDamageType(dmginfo:GetDamageType())
        dmg:SetDamage(dmginfo:GetDamage() / 2)
        dmg:SetDamageForce(Vector(0,0,0))
        dmg:SetDamageCustom(HORDE.DMG_SPLASH)
        util.BlastDamageInfo(dmg, npc:GetPos(), 140)
    end
end