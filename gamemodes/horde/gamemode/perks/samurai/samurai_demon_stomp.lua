PERK.PrintName = "Demon Stomp"
PERK.Description =
[[Adds 1 charge to Quickstep.
Activating Quickstep releases a shockwave that deals {1} Physical damage.
Recover {2} health for each enemy hit by the shockwave.]]
PERK.Icon = "materials/perks/samurai/demon_stomp.png"
PERK.Params = {
    [1] = {value = 50},
    [2] = {value = 5},
}
PERK.Hooks = {}

PERK.Hooks.Horde_OnSetPerk = function(ply, perk)
    if SERVER and perk == "samurai_demon_stomp" then
        HORDE:CheckDemonStompCharges(ply)
    end
end

PERK.Hooks.Horde_OnUnsetPerk = function(ply, perk)
    if SERVER and perk == "samurai_demon_stomp" then
        HORDE:CheckDemonStompCharges(ply)
    end
end