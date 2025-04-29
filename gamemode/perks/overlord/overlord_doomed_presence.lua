PERK.PrintName = "Doomed Presence"
PERK.Description = [[Fear duration is infinite.
Enemies you hit gain {1} Fear stack.]]
PERK.Icon = "materials/perks/overlord/doomed_prescence.png"
PERK.Params = {
    [1] = { value = 1 },
}
PERK.Hooks = {}
--Effects are in sv_fear.lua
PERK.Hooks.Horde_OnSetPerk = function(ply, perk)
    if SERVER and perk == "overlord_doomed_presence" then
        ply:Horde_SetMaxFearStack(ply:Horde_GetMaxFearStack() + 1)
    end
end

PERK.Hooks.Horde_OnUnsetPerk = function(ply, perk)
    if SERVER and perk == "overlord_doomed_presence" then
        ply:Horde_SetMaxFearStack(ply:Horde_GetMaxFearStack() - 1)
    end
end

PERK.Hooks.Horde_OnPlayerDamage = function(ply, npc, bonus, hitgroup, dmginfo)
    if not ply:Horde_GetPerk("overlord_doomed_presence") then return end
    npc:Horde_AddFearStack(ply)
end
