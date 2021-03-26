PERK.PrintName = "Antibiotics"
PERK.Description = "Your healing is amplified by 15%."
PERK.Icon = "materials/perks/antibiotics.png"

 = {}

PERK.Hooks = {}

PERK.Hooks.Horde_ApplyHeal = function(ply, healinfo)
    local healer = healinfo:GetHealer()
    if healer:IsPlayer() and healer:Horde_GetPerk("medic_antibiotics") then
        healinfo:SetHealAmount(healinfo:GetHealAmount() * 1.15)
    end
end
