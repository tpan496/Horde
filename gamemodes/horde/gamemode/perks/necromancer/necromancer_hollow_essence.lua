PERK.PrintName = "Hollow Essence"
PERK.Description =
[[+{1} to maximum Spectres alive.]]
PERK.Icon = "materials/perks/necromancer/hollow_essence.png"

PERK.Params = {
    [1] = { value = 1 }
}
PERK.Hooks = {}

PERK.Hooks.Horde_OnSetPerk = function(ply, perk)
    if CLIENT then return end
    if perk == "necromancer_hollow_essence" then
        UpdateSpectreMaxCount(ply)
    end
end

PERK.Hooks.Horde_OnUnsetPerk = function(ply, perk)
    if CLIENT then return end
    if perk == "necromancer_hollow_essence" then
        HORDE:RemoveSpectres(ply)
        UpdateSpectreMaxCount(ply)
    end
end