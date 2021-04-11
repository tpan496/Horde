PERK.PrintName = "Symbiosis"
PERK.Description = "Minions have {1} more health on spawn.\n6% less damage taken for each minion alive."
PERK.Icon = "materials/perks/symbiosis.png"
PERK.Params = {
    [1] = {value = 0.25, percent = true},
    [2] = {value = 0.06, percent = true},
}

PERK.Hooks = {}
PERK.Hooks.OnEntityCreated = function (ent)
    if not ent:IsValid() then return end
    timer.Simple(0.1, function()
        local ply = ent:GetNWEntity("HordeOwner")
        if ply:IsValid() and ply:Horde_GetPerk("engineer_symbiosis") and ent:IsNPC() and ent.SetMaxHealth then
            ent:SetMaxHealth(ent:GetMaxHealth() * 1.25)
            ent:SetHealth(ent:GetMaxHealth())
        end
    end)
end

PERK.Hooks.Horde_OnPlayerDamageTaken = function (ply, dmginfo, bonus)
    if not ply:Horde_GetPerk("engineer_symbiosis")  then return end
    bonus.resistance = bonus.resistance + 0.06 * ply:Horde_GetMinionCount()
end