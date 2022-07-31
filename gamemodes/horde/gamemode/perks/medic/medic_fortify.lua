PERK.PrintName = "Fortify"
PERK.Description = "Players you heal have Fortify for {1} seconds.\n{2} less damage taken while you have Fortify."
PERK.Icon = "materials/perks/fortify.png"
PERK.Params = {
    [1] = {value = 5},
    [2] = {value = 0.20, percent = true},
}

PERK.Hooks = {}
PERK.Hooks.Horde_OnPlayerHeal = function(ply, healinfo)
    local healer = healinfo:GetHealer()
    if healer:IsPlayer() and healer:Horde_GetPerk("medic_fortify") then
        ply:Horde_AddFortify(healer:Horde_GetApplyBuffDuration())
    end
end
