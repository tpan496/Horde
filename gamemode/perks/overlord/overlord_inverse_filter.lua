PERK.PrintName = "Inverse Filter"
PERK.Description = [[{1} less debuff buildups received.
{2} less Bleeding buildup received.
Restore health when you receive debuff buildup.]]
PERK.Icon = "materials/perks/overlord/inverse_filter.png"
PERK.Params = {
    [1] = { value = 0.25, percent = true },
    [2] = { value = 0.25, percent = true },
}
PERK.Hooks = {}
PERK.Hooks.Horde_OnPlayerDebuffApply = function(ply, debuff, bonus, inflictor)
    if not ply:Horde_GetPerk("overlord_inverse_filter") then return end
    if debuff == HORDE.Status_Bleeding then
        bonus.less = bonus.less * 0.5
    else
        bonus.less = bonus.less * 0.75
    end
    HORDE:SelfHeal(ply, 2)
end
