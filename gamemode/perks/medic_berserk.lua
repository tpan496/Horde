PERK.PrintName = "Berserk"
PERK.Description = "Players you heal have Berserk for 5 seconds.\n10% increased damage and speed while you have Berserk."
PERK.Icon = "materials/perks/berserk.png"

 = {}

PERK.Hooks = {}

PERK.Hooks.Horde_ApplyHeal = function(ply, healinfo)
    local healer = healinfo:GetHealer()
    if healer:IsPlayer() and healer:Horde_GetPerk("medic_berserk") then
        ply:Horde_AddBerserk(healer:Horde_GetApplyBuffDuration())
    end
end
