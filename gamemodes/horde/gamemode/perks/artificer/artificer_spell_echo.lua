PERK.PrintName = "Spell Echo"
PERK.Description =
[[{1} chance to cause your spells to activate twice.]]
PERK.Icon = "materials/perks/artificer/spell_echo.png"
PERK.Params = {
    [1] = {value = 0.25, percent = true},
    [2] = {value = 0.25, percent = true},
}
PERK.Hooks = {}
PERK.Hooks.Horde_OnSpellFire = function (ply, wpn, stage, spell)
    if ply:Horde_GetPerk("artificer_spell_echo") then
        local p = math.random()
        if p <= 0.25 then
            timer.Simple(0.2, function() if !IsValid(ply) then return end spell.Fire(ply,wpn,stage) end)
        end
    end
end