MUTATION.PrintName = "Giant"
MUTATION.Description = "25% increased character size.\n25% increased damage.\n25% increased health."

MUTATION.Hooks = {}

MUTATION.Hooks.Horde_OnSetMutation = function(ent, mutation)
    if mutation == "giant" then
        if SERVER then
            ent:SetModelScale(ent:GetModelScale() * 1.25)
            ent:SetMaxHealth(ent:GetMaxHealth() * 1.25)
            ent:SetHealth(ent:GetMaxHealth() * 1.25)
        end
    end
end

MUTATION.Hooks.Horde_OnPlayerDamageTaken = function(ply, dmg, bonus)
    if dmg:GetAttacker():IsNPC() and dmg:GetAttacker():Horde_GetMutation() == "giant" then
        dmg:ScaleDamage(1.25)
    end
end