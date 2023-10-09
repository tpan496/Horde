PERK.PrintName = "Sticky Compound"
PERK.Description = "Enemies you hit with Ballistic damage are Hindered.\nHindered enemies deal {1} reduced Physical damage."
PERK.Icon = "materials/perks/sticky_compound.png"
PERK.Params = {
    [1] = {value = 0.15, percent = true},
}

PERK.Hooks = {}
PERK.Hooks.Horde_OnPlayerDamage = function(ply, npc, bonus, hitgroup, dmg)
    if not ply:Horde_GetPerk("heavy_sticky_compound") then return end
    if HORDE:IsBallisticDamage(dmg) then
        npc:Horde_AddHinder(ply, ply:Horde_GetApplyDebuffDuration(), ply:Horde_GetApplyDebuffMore())
    end
end