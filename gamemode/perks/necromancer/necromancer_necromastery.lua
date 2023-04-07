PERK.PrintName = "Necromastery"
PERK.Description =
[[+{1} to maximum Spectres alive.
Minion spells have {2} reduced cooldown.]]
PERK.Icon = "materials/perks/necromancer/necromastery.png"
PERK.Params = {
    [1] = {value = 1},
    [2] = {value = 0.5, percent = true},
}
PERK.Hooks = {}

PERK.Hooks.Horde_OnSetPerk = function(ply, perk)
    if SERVER and perk == "necromancer_necromastery" then
        ply.Horde_Spectre_Max_Count = ply.Horde_Spectre_Max_Count + 1
    end
end

PERK.Hooks.Horde_OnUnsetPerk = function(ply, perk)
    if SERVER and perk == "necromancer_necromastery" then
        ply.Horde_Spectre_Max_Count = ply.Horde_Spectre_Max_Count - 1

        HORDE:RemoveSpectres(ply)
    end
end

PERK.Hooks.Horde_OnSpellCooldown = function (ply, bonus, spell)
    if ply:Horde_GetPerk("necromancer_necromastery") and table.HasValue(spell.Type, HORDE.Spell_Type_Minion) then
        bonus.less = bonus.less * 0.5
    end
end