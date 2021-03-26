PERK.PrintName = "Fortify"
PERK.Description = "Players you heal have Fortify for 5 seconds.\n15% less damage taken while you have Fortify."
PERK.Icon = "materials/perks/fortify.png"

PERK.Parameters = {}

PERK.Hooks = {}

PERK.Hooks.Horde_ApplyHeal = function(ply, healinfo)
    local healer = healinfo:GetHealer()
    if healer:IsPlayer() and healer:Horde_GetPerk("medic_fortify") then
        ply:Horde_AddFortify(healer:Horde_GetApplyBuffDuration())
    end
end
