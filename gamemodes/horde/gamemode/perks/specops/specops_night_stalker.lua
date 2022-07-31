PERK.PrintName = "Night Stalker"
PERK.Description = [[
While in Tactical Mode:
  {1} increased movement speed.
  {2} increased headshot damage.]]
PERK.Icon = "materials/perks/specops/night_stalker.png"
PERK.Params = {
    [1] = {value = 0.20, percent = true},
    [2] = {value = 0.25, percent = true},
}

PERK.Hooks = {}

PERK.Hooks.Horde_OnPlayerDamage = function (ply, npc, bonus, hitgroup, dmginfo)
    if not ply:Horde_GetPerk("specops_night_stalker") then return end
    if ply.Horde_In_Tactical_Mode and hitgroup == HITGROUP_HEAD then
        bonus.increase = bonus.increase + 0.25
    end
end