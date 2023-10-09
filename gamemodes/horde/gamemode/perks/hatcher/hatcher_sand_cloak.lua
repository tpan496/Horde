PERK.PrintName = "Sand Cloak"
PERK.Description =
[[Stage II Antlion grants Sand Cloak through Bug Pulse.
Sand Cloak adds {1} evasion.
Sand Cloak lasts for {2} seconds.]]
PERK.Icon = "materials/perks/hatcher/sand_cloak.png"
PERK.Params = {
    [1] = {value = 0.2, percent = true},
    [2] = {value = 5},
}

PERK.Hooks = {}

PERK.Hooks.Horde_OnAntlionPulse = function (owner, antlion, ply)
    if owner:Horde_GetPerk("hatcher_sand_cloak") and antlion:Horde_IsStage(2) then
        ply:Horde_AddSandcloak(5)
    end
end