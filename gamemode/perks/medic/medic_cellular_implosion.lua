PERK.PrintName = "Cellular Implosion"
PERK.Description = "Enemies you killed have {1} chance to generate a healing cloud."
PERK.Icon = "materials/perks/cellular_implosion.png"
PERK.Params = {
    [1] = {value = 0.20, percent = true},
}

PERK.Hooks = {}
PERK.Hooks.Horde_OnEnemyKilled = function(victim, killer, inflictor)
    if not killer:Horde_GetPerk("medic_cellular_implosion") then return end
    if inflictor:IsNPC() then return end -- Prevent infinite chains
    local p = math.random()
    if p <= 0.2 then
        local ent = ents.Create("arccw_thr_medicgrenade")
        ent:SetPos(victim:GetPos())
        ent:SetOwner(killer)
        ent.Owner = killer
        ent.Inflictor = victim
        ent:Spawn()
        ent:Activate()
        timer.Simple(0, function()
            if ent:IsValid() then
                ent:Detonate() ent:SetArmed(true)
            end
        end)
        if ent:GetPhysicsObject():IsValid() then
            ent:GetPhysicsObject():EnableMotion(false)
        end
        timer.Simple(3, function() if ent:IsValid() then ent:Remove() end end)
    end
end