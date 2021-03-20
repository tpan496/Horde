PERK.PrintName = "Coup De Grace"
PERK.Description = "Instantly kills enemies with less than 20% health."

PERK.Parameters = {}

PERK.Hooks = {}

hook.Add("ScaleNPCDamage", "Horde_CoupDeGraceDamage", function(npc, hitgroup, dmg)
    local attacker = dmg:GetAttacker()
    if not attacker:IsValid() or not attacker:IsPlayer() then return end
    if not attacker:Horde_GetPerk("ghost_coup")  then return end
    if npc:Health() <= 0.2 * npc:GetMaxHealth() then
        dmg:SetDamage(0.2 * npc:GetMaxHealth() + 1)
        return true
    end
end)