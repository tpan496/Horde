PERK.PrintName = "Painkillers"
PERK.Description = "You can overheal player's health by {1}."
PERK.Icon = "materials/perks/painkillers.png"
PERK.Params = {
    [1] = {value = 0.20, percent = true},
}

PERK.Hooks = {}
PERK.Hooks.Horde_OnPlayerHeal = function(ply, healinfo)
    local healer = healinfo:GetHealer()
    if healer:IsPlayer() and healer:Horde_GetPerk("medic_painkillers") then
        healinfo:SetOverHealPercentage(0.20)
    end
end
