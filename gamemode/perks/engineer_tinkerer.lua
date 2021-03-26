PERK.PrintName = "Tinkerer"
PERK.Description = "Minions have 25% more health."
PERK.Icon = "materials/perks/tinkerer.png"

PERK.Hooks = {}

PERK.Hooks.OnEntityCreated = function (ent)
    if not ent:IsValid() then return end
    timer.Simple(0.1, function()
        local ply = ent:GetNWEntity("HordeOwner")
        if ply:IsValid() and ply:Horde_GetPerk("engineer_tinkerer") and ent:IsNPC() then
            ent:SetMaxHealth(ent:GetMaxHealth() * 1.25)
            ent:SetHealth(ent:GetMaxHealth())
        end
    end)
end