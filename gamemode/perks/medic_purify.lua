PERK.PrintName = "Purify"
PERK.Description = "Your healing reduces Bleeding, Break and Stun buildups."
PERK.Icon = "materials/perks/purify.png"
PERK.Params = {
}

PERK.Hooks = {}
PERK.Hooks.Horde_OnPlayerHeal = function(ply, healinfo)
    local healer = healinfo:GetHealer()
    if healer:IsPlayer() and healer:Horde_GetPerk("medic_purify") then
        for debuff, buildup in pairs(ply.Horde_Debuff_Buildup) do
            if debuff == HORDE.Status_Bleeding or debuff == HORDE.Status_Break then
                ply:Horde_ReduceDebuffBuildup(debuff, healinfo:GetHealAmount() * 1.25)
            end
        end
    end
end
