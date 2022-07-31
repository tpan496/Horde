MUTATION.PrintName = "Giant"
MUTATION.Description = "25% increased character size.\n25% more damage.\n25% increased health."

MUTATION.Hooks = {}

MUTATION.Hooks.Horde_OnSetMutation = function(ent, mutation)
    if mutation == "giant" then
        if SERVER then
            ent:SetModelScale(math.min(2.5, math.max(1, ent:GetModelScale()) * 1.25))
            ent:SetMaxHealth(ent:GetMaxHealth() * 1.25)
            ent:SetHealth(ent:GetMaxHealth() * 1.25)
        end
    end
end

MUTATION.Hooks.EntityTakeDamage = function(ply, dmg)
    if dmg:GetAttacker():IsNPC() and dmg:GetAttacker():Horde_HasMutation("giant") then
        dmg:ScaleDamage(1.25)
    end
end

MUTATION.Hooks.Horde_OnUnsetMutation = function (ent, mutation)
    if not ent:IsValid() or mutation ~= "giant" then return end
    if SERVER then
        ent:SetMaxHealth(ent:GetMaxHealth() / 1.25)
    end
end