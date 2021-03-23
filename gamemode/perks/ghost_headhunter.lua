PERK.PrintName = "Headhunter"
PERK.Description = "Headshot damage stacks up to 5 times.\nEach stack increases 8% headshot damage."

PERK.Parameters = {}

PERK.Hooks = {}

PERK.Hooks.Horde_OnSetPerk = function(ply, perk, params)
    if SERVER and perk == "ghost_headhunter" then
        ply:Horde_SetHeadHunterEnabled(true)
    end
end

PERK.Hooks.Horde_OnUnsetPerk = function(ply, perk, params)
    if SERVER and perk == "ghost_headhunter" then
        ply:Horde_SetHeadHunterEnabled(nil)
    end
end