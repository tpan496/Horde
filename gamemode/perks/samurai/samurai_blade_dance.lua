PERK.PrintName = "Blade Dance"
PERK.Description =
[[Adds 1 charge to Quickstep.
Killing enemies adds 2 Quickstep charges.
Extends effect duration of Quickstep.]]
PERK.Icon = "materials/perks/samurai/blade_dance.png"
PERK.Params = {
    [1] = {value = 0.20, percent = true},
}
PERK.Hooks = {}

PERK.Hooks.Horde_OnEnemyKilled = function(victim, killer, wpn)
    if not killer:Horde_GetPerk("samurai_blade_dance") then return end
    HORDE:RefreshPerkCooldown(killer)
    local max_charges = 1
    if killer:Horde_GetPerk("samurai_focus_slash") then
        max_charges = max_charges + 1
    end
    if killer:Horde_GetPerk("samurai_demon_stomp") then
        max_charges = max_charges + 1
    end
    if killer:Horde_GetPerk("samurai_blade_dance") then
        max_charges = max_charges + 1
    end
    if killer:Horde_GetPerk("samurai_foresight") then
        max_charges = max_charges + 1
    end
    killer:Horde_SetPerkCharges(math.min(max_charges, killer:Horde_GetPerkCharges() + 2))
end

PERK.Hooks.Horde_OnSetPerk = function(ply, perk)
    if SERVER and perk == "samurai_blade_dance" then
        HORDE:CheckDemonStompCharges(ply)
    end
end

PERK.Hooks.Horde_OnUnsetPerk = function(ply, perk)
    if SERVER and perk == "samurai_blade_dance" then
        HORDE:CheckDemonStompCharges(ply)
    end
end