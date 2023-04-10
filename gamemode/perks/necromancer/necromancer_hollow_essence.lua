PERK.PrintName = "Hollow Essence"
PERK.Description =
[[+{1} to maximum Spectres alive.]]
PERK.Icon = "materials/perks/necromancer/hollow_essence.png"
PERK.Params = {
    [1] = {value = 1},
    [2] = {value = 0.25, percent = true},
}
PERK.Hooks = {}

PERK.Hooks.Horde_OnSetPerk = function (ply, perk)
    if CLIENT then return end
    if perk == "necromancer_hollow_essence" then
        if not ply.Horde_Spectre_Max_Count then ply.Horde_Spectre_Max_Count = 0 end
        ply.Horde_Spectre_Max_Count = ply.Horde_Spectre_Max_Count + 1
    end
end

PERK.Hooks.Horde_OnUnsetPerk = function (ply, perk)
    if CLIENT then return end
    if perk == "necromancer_hollow_essence" then
        ply.Horde_Spectre_Max_Count = ply.Horde_Spectre_Max_Count - 1

        HORDE:RemoveSpectres(ply)
    end
end