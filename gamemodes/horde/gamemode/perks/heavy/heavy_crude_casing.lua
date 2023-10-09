PERK.PrintName = "Crude Casing"
PERK.Description = "Enemies you hit with Ballistic damage are Weakened.\nWeakened enemies receive {1} increased Physical damage."
PERK.Icon = "materials/perks/crude_casing.png"
PERK.Params = {
    [1] = {value = 0.15, percent = true},
}

PERK.Hooks = {}
PERK.Hooks.Horde_OnPlayerDamage = function(ply, npc, bonus, hitgroup, dmg)
    if not ply:Horde_GetPerk("heavy_crude_casing") then return end
    if HORDE:IsBallisticDamage(dmg) then
        npc:Horde_AddWeaken(ply, ply:Horde_GetApplyDebuffDuration(), ply:Horde_GetApplyDebuffMore())
    end
end