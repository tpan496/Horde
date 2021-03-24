PERK.PrintName = "Sticky Compound"
PERK.Description = "Enemies you hit are Slowed.\nSlowed enemies have 15% reduced action speed."

PERK.Parameters = {}

PERK.Hooks = {}

PERK.Hooks.EntityTakeDamage = function(target, dmg)
    local attacker = dmg:GetAttacker()
    if not attacker:IsValid() or not attacker:IsPlayer() then return end
    if not attacker:Horde_GetPerk("heavy_sticky_compound") then return end
    if not target:IsNPC() then return end
    if not target:GetNWEntity("HordeOwner"):IsPlayer() then
        target:Horde_AddSlow(5, target:Horde_GetApplyDebuffMore())
    end
end