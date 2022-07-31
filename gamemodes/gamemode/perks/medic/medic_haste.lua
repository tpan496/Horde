PERK.PrintName = "Haste"
PERK.Description = "Players you heal have Haste for {1} seconds.\n{2} increased movement speed while you have Haste."
PERK.Icon = "materials/perks/haste.png"
PERK.Params = {
    [1] = {value = 5},
    [2] = {value = 0.15, percent = true},
}

PERK.Hooks = {}
PERK.Hooks.Horde_OnPlayerHeal = function(ply, healinfo)
    local healer = healinfo:GetHealer()
    if healer:IsPlayer() and healer:Horde_GetPerk("medic_haste") then
        ply:Horde_AddHaste(healer:Horde_GetApplyBuffDuration())
    end
end
