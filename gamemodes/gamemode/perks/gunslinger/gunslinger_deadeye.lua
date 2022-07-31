PERK.PrintName = "Deadeye"
PERK.Description = [[Headshot increases Deadeye stacks up to {1} times.
Each stack increases {2} damage with Pistols.]]
PERK.Icon = "materials/perks/gunslinger/deadeye.png"
PERK.Params = {
    [1] = {value = 5},
    [2] = {value = 0.05, percent = true}
}

PERK.Hooks = {}
PERK.Hooks.Horde_OnSetPerk = function(ply, perk)
    if SERVER and perk == "gunslinger_deadeye" then
        ply:Horde_SetDeadeyeEnabled(true)
    end
end

PERK.Hooks.Horde_OnUnsetPerk = function(ply, perk)
    if SERVER and perk == "gunslinger_deadeye" then
        ply:Horde_SetDeadeyeEnabled(nil)
    end
end