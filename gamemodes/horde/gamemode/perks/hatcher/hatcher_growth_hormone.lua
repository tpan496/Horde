PERK.PrintName = "Growth Hormone"
PERK.Description =
[[{1} increased Antlion evolve rate.
{2} increased Antlion evolving rate when they are healed.]]
PERK.Icon = "materials/perks/hatcher/growth_hormone.png"
PERK.Params = {
    [1] = {value = 0.5, percent = true},
    [2] = {value = 1, percent = true},
}

PERK.Hooks = {}

PERK.Hooks.Horde_OnAntlionHeal = function(npc, healinfo)
    local healer = healinfo:GetHealer()
    if healer:IsPlayer() and healer:Horde_GetPerk("hatcher_growth_hormone") then
        healinfo:SetHealAmount(healinfo:GetHealAmount() * 2)
    end
end

PERK.Hooks.Horde_OnAntlionSelfEvolve = function(ply, npc, bonus)
    if not ply:Horde_GetPerk("hatcher_growth_hormone") then return end
    bonus.increase = 1.5
end