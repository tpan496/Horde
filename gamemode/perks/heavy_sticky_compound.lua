PERK.PrintName = "Sticky Compound"
PERK.Description = "Enemies you hit with Ballistic damage are Slowed.\nSlowed enemies have 15% reduced action speed."

PERK.Parameters = {}

PERK.Hooks = {}

PERK.Hooks.EntityTakeDamage = function(target, dmg)
    local attacker = dmg:GetAttacker()
    if not attacker:IsValid() or not attacker:IsPlayer() then return end
    if not attacker:Horde_GetPerk("heavy_sticky_compound") then return end
    if not target:IsNPC() or not dmg:GetDamageType() == DMG_BULLET then return end
    if not target:GetNWEntity("HordeOwner"):IsPlayer() then
        target:Horde_AddSlow(attacker:Horde_GetApplyDebuffDuration(), attacker:Horde_GetApplyDebuffMore())
    end
end