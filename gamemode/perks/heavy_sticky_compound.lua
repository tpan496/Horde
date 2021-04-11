PERK.PrintName = "Sticky Compound"
PERK.Description = "Enemies you hit with Ballistic damage are Slowed.\nSlowed enemies have {1} reduced action speed."
PERK.Icon = "materials/perks/sticky_compound.png"
PERK.Params = {
    [1] = {value = 0.20, percent = true},
}

PERK.Hooks = {}
PERK.Hooks.EntityTakeDamage = function(target, dmg)
    local attacker = dmg:GetAttacker()
    if not attacker:IsValid() or not attacker:IsPlayer() then return end
    if not attacker:Horde_GetPerk("heavy_sticky_compound") then return end
    if not target:IsNPC() or target:GetNWEntity("HordeOwner"):IsPlayer() then return end
    local dmgtype = dmg:GetDamageType()
    if dmgtype == DMG_BULLET or dmgtype == DMG_BUCKSHOT then
        target:Horde_AddSlow(attacker:Horde_GetApplyDebuffDuration(), attacker:Horde_GetApplyDebuffMore())
    end
end