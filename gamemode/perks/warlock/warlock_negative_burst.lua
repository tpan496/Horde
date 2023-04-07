PERK.PrintName = "Negative Burst"
PERK.Description =
[[Activating spells generate a shockwave near you.
Shockwave deals damage based on spell mind cost.]]
PERK.Icon = "materials/perks/warlock/negative_burst.png"
PERK.Params = {}
PERK.Hooks = {}
PERK.Hooks.Horde_OnSpellFire = function (ply, wpn, stage, spell)
    if ply:Horde_GetPerk("warlock_negative_burst") then
        local mind_cost = spell.Mind[stage]
        local dmg = DamageInfo()
        dmg:SetAttacker(ply)
        dmg:SetInflictor(wpn)
        dmg:SetDamageType(DMG_GENERIC)
        dmg:SetDamage(mind_cost * 5)
        dmg:SetDamageCustom(HORDE.DMG_PLAYER_FRIENDLY)
        local r = 125 + mind_cost * 2
        local o = ply:GetPos() + Vector(0,0,24)
        util.BlastDamageInfo(dmg, o, r)

        
        local e = EffectData()
            e:SetOrigin(o)
            e:SetRadius(r)
        util.Effect("horde_negative_burst", e, true, true)
    end
end