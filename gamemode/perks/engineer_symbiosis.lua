PERK.PrintName = "Symbiosis"
PERK.Description = "Minions have 25% more health.\n5% less damage taken for each minion alive."
PERK.Icon = "materials/perks/symbiosis.png"

PERK.Hooks = {}
PERK.Hooks.OnEntityCreated = function (ent)
    if not ent:IsValid() then return end
    timer.Simple(0.1, function()
        local ply = ent:GetNWEntity("HordeOwner")
        if ply:IsValid() and ply:Horde_GetPerk("engineer_symbiosis") and ent:IsNPC() then
            ent:SetMaxHealth(ent:GetMaxHealth() * 1.25)
            ent:SetHealth(ent:GetMaxHealth())
        end
    end)
end

PERK.Hooks.EntityTakeDamage = function (target, dmg)
    if target:IsPlayer() and target:Horde_GetPerk("engineer_symbiosis") then
        local drop
    end
end