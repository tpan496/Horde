PERK.PrintName = "Exsanguinate"
PERK.Description =
[[20% increased Bleeding buildup.
Recover 5 health per second while near an enemy with Bleeding.
Immune to Bleeding.]]
PERK.Icon = "materials/perks/samurai/exsanguinate.png"
PERK.Params = {
    [1] = {value = 0.20, percent = true},
}
PERK.Hooks = {}

PERK.Hooks.Horde_OnEnemyDebuffApply = function (npc, debuff, bonus, inflictor)
    if debuff == HORDE.Status_Bleeding and inflictor:Horde_GetPerk("samurai_exsanguinate") then
        bonus.increase = bonus.increase + 0.2
    end
end

PERK.Hooks.Horde_OnSetPerk = function(ply, perk)
    if SERVER and perk == "samurai_exsanguinate" then
      local id = ply:SteamID()
      timer.Create("Horde_Exsanguinate" .. id, 1, 0, function ()
          if not ply:IsValid() or not ply:Alive() or not ply:Horde_GetPerk("samurai_exsanguinate") then timer.Remove("Horde_Exsanguinate" .. id) return end
          for _, ent in pairs(ents.FindInSphere(ply:GetPos(), 300)) do
              if ent:Horde_HasDebuff(HORDE.Status_Bleeding) then
                HORDE:SelfHeal(ply, 5)
              end
          end
      end)
    end
end

PERK.Hooks.Horde_OnPlayerDebuffApply = function (ply, debuff, bonus)
    if ply:Horde_GetPerk("samurai_exsanguinate") and debuff == HORDE.Status_Bleeding then
        bonus.apply = 0
        return true
    end
end