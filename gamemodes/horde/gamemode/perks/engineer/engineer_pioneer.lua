PERK.PrintName = "Pioneer"
PERK.Description = "{1} increased minion damage."
PERK.Icon = "materials/perks/pioneer.png"
PERK.Params = {
    [1] = {value = 0.20, percent = true},
}

PERK.Hooks = {}

PERK.Hooks.Horde_OnPlayerMinionDamage = function (ply, npc, bonus, dmginfo)
    if ply:Horde_GetPerk("engineer_pioneer") then
        bonus.increase = bonus.increase + 0.20
    end
end