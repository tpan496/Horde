PERK.PrintName = "Militant"
PERK.Description = [[{1} less debuff buildups received.
{2} increased Ballistic damage to enemeis affected by Fear.]]
PERK.Icon = "materials/perks/overlord/militant.png"
PERK.Params = {
    [1] = { value = 0.2, percent = true },
    [2] = { value = 0.25, percent = true },
}
PERK.Hooks.Horde_OnPlayerDebuffApply = function(ply, debuff, bonus, inflictor)
    if not ply:Horde_GetPerk("overlord_militant") then return end
    bonus.less = bonus.less * 0.8
    HORDE:SelfHeal(ply, 1)
end

PERK.Hooks.Horde_OnPlayerDamage = function(ply, npc, bonus, hitgroup, dmginfo)
    if not ply:Horde_GetPerk("overlord_militant") then return end
    if HORDE:IsBallisticDamage(dmginfo) and npc:Horde_GetFearStack() > 0 then
        bonus.increase = bonus.increase + 0.25
    end
end
