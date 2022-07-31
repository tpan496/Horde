PERK.PrintName = "Warmth"
PERK.Description =
[[Charged Solar Orbs heal players.]]
PERK.Icon = "materials/perks/artificer/warmth.png"
PERK.Params = {
    [1] = {value = 0.20, percent = true},
}
PERK.Hooks = {}

PERK.Hooks.Horde_OnSolarSealLaunch = function (ply, properties)
    if ply:Horde_GetPerk("artificer_warmth") then
        properties.warmth = true
    end
end