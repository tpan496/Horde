PERK.PrintName = "Puncture"
PERK.Description = [[
{1} increased Hunter's Mark range.
Enemies under Hunter's Mark take {2} increased damage.]]
PERK.Icon = "materials/perks/gunslinger/puncture.png"
PERK.Params = {
    [1] = {value = 1, percent = true},
    [2] = {value = 0.20, percent = true},
}
PERK.Hooks = {}

PERK.Hooks.Horde_OnPlayerDamage = function (ply, npc, bonus, hitgroup, dmginfo)
    if not IsValid(npc.Horde_Has_Hunter_Mark) then return end
    if not npc.Horde_Has_Hunter_Mark:Horde_GetPerk("gunslinger_puncture") then return end

    bonus.increase = bonus.increase + 0.20
end