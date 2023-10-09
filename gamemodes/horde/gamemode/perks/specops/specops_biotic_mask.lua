PERK.PrintName = "Biotic Mask"
PERK.Description = [[
While in Tactical Mode:
  Recover 2% health per second.
  {1} reduced Bleeding, Break and Necrosis buildups.]]
  PERK.Icon = "materials/perks/specops/biotic_mask.png"
PERK.Params = {
    [1] = {value = 0.75, percent = true},
}

PERK.Hooks = {}

PERK.Hooks.Horde_OnPlayerDebuffApply = function (ply, debuff, bonus, inflictor)
    if not ply:Horde_GetPerk("specops_biotic_mask")  then return end
    if debuff == HORDE.Status_Bleeding or debuff == HORDE.Status_Break or debuff == HORDE.Status_Necrosis then
        bonus.less = bonus.less * 0.25
    end
end

PERK.Hooks.Horde_OnUnsetPerk = function(ply, perk)
    if SERVER and perk == "specops_biotic_mask" then
        ply:Horde_SetHealthRegenPercentage(0)
    end
end