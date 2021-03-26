PERK.PrintName = "Coup De Grace"
PERK.Description = "Instantly kills enemies with less than 20% health."
PERK.Icon = "materials/perks/coup.png"

PERK.Parameters = {}

PERK.Hooks = {}

PERK.Hooks.EntityTakeDamage = function(target, dmg)
    local attacker = dmg:GetAttacker()
    if not attacker:IsValid() or not attacker:IsPlayer() then return end
    if not attacker:Horde_GetPerk("ghost_coup") then return end
    if not target:IsNPC() then return end

    if not target:GetNWEntity("HordeOwner"):IsPlayer() and (target:Health() <= 0.2 * target:GetMaxHealth()) then
        dmg:SetDamage(0.2 * target:GetMaxHealth() + 1)
        dmg:SetDamageType(DMG_DIRECT)
    end
end