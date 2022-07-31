PERK.PrintName = "Tactical Visor"
PERK.Description = [[
While in Tactical Mode:
  {1} increased Ballistic damage.
  {2} increased damage to limbs.]]
  PERK.Icon = "materials/perks/specops/tactical_visor.png"
PERK.Params = {
    [1] = {value = 0.25, percent = true},
    [2] = {value = 0.25, percent = true},
}

PERK.Hooks = {}

PERK.Hooks.Horde_OnPlayerDamage = function (ply, npc, bonus, hitgroup, dmginfo)
    if not ply:Horde_GetPerk("specops_tactical_visor") then return end
    if ply.Horde_In_Tactical_Mode then
        if HORDE:IsBallisticDamage(dmginfo) then
            bonus.increase = bonus.increase + 0.25
        end
        if hitgroup >= HITGROUP_LEFTARM and hitgroup <= HITGROUP_RIGHTLEG then
            bonus.increase = bonus.increase + 0.25
        end
    end
end