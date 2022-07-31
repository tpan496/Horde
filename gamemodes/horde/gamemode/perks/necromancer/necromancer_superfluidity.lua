PERK.PrintName = "Superfluidity"
PERK.Description =
[[20% increased Frostbite buildup.
Void Projector recovers energy while inactive.]]
PERK.Icon = "materials/perks/necromancer/superfluidity.png"
PERK.Params = {
    [1] = {value = 0.20, percent = true},
}
PERK.Hooks = {}

PERK.Hooks.Horde_OnEnemyDebuffApply = function (npc, debuff, bonus, inflictor)
    if debuff == HORDE.Status_Frostbite and inflictor:Horde_GetPerk("necromancer_superfluidity") then
        bonus.increase = bonus.increase + 0.2
    end
end

PERK.Hooks.Horde_OnSetPerk = function(ply, perk)
  if SERVER and perk == "necromancer_superfluidity" then
    local id = ply:SteamID()
    timer.Create("Horde_Superfluidity" .. id, 1, 0, function ()
        if not ply:IsValid() or not ply:Alive() or not ply:Horde_GetPerk("necromancer_superfluidity") then timer.Remove("Horde_Superfluidity" .. id) return end
        local wpn = ply:GetActiveWeapon()
        if wpn:GetClass() ~= "horde_void_projector" then
            local void_projector = ply:GetWeapon("horde_void_projector")
            if void_projector:IsValid() then
                void_projector:RecoverEnergy(6)
            end
        end
    end)
  end
end