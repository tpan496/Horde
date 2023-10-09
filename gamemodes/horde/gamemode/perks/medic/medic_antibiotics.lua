PERK.PrintName = "Antibiotics"
PERK.Description = "Your healing is amplified by {1}."
PERK.Icon = "materials/perks/antibiotics.png"
PERK.Params = {
    [1] = {value = 0.20, percent = true},
}

PERK.Hooks = {}
PERK.Hooks.Horde_OnPlayerHeal = function(ply, healinfo)
    local healer = healinfo:GetHealer()
    if healer:IsPlayer() and healer:Horde_GetPerk("medic_antibiotics") then
        healinfo:SetHealAmount(healinfo:GetHealAmount() * 1.20)
    end
end
