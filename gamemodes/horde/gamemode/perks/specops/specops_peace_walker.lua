PERK.PrintName = "Peace Walker"
PERK.Description = [[
{1} reduced Smokescreen/Flare cooldown.
While in Tactical Mode:
  {2} increased Ballistic damage.]]
PERK.Icon = "materials/perks/specops/peace_walker.png"
PERK.Params = {
    [1] = {value = 0.3, percent = true},
    [2] = {value = 0.1, percent = true},
}

PERK.Hooks = {}
PERK.Hooks.Horde_OnSetPerk = function(ply, perk)
    if SERVER and perk == "specops_peace_walker" then
        ply:Horde_SetPerkCooldown(7)
    end
end

PERK.Hooks.Horde_OnPlayerDamage = function (ply, npc, bonus, hitgroup, dmginfo)
    if not ply:Horde_GetPerk("specops_peace_walker") then return end
    if ply.Horde_In_Tactical_Mode and HORDE:IsBallisticDamage(dmginfo) then
        bonus.increase = bonus.increase + 0.1
    end
end