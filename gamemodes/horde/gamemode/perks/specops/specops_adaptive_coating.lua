PERK.PrintName = "Adaptive Coating"
PERK.Description = [[
While in Tactical Mode:
  {1} increased Global damage resistance.
  {2} reduced Fire, Cold and Lightning damage taken.]]
PERK.Icon = "materials/perks/specops/adaptive_coating.png"
PERK.Params = {
    [1] = {value = 0.25, percent = true},
    [2] = {value = 0.25, percent = true},
}

PERK.Hooks = {}

PERK.Hooks.Horde_OnPlayerDamageTaken = function(ply, dmginfo, bonus)
    if not ply:Horde_GetPerk("specops_adaptive_coating")  then return end
    if ply.Horde_In_Tactical_Mode then
        bonus.resistance = bonus.resistance + 0.25
        if HORDE:IsFireDamage(dmginfo) or HORDE:IsLightningDamage(dmginfo) or HORDE:IsColdDamage(dmginfo) then
            bonus.less = bonus.less * 0.75
        end
    end
end
--[[
PERK.Hooks.Horde_OnPlayerDebuffApply = function (ply, debuff, bonus, inflictor)
    if not ply:Horde_GetPerk("specops_adaptive_coating")  then return end
    if ply.Horde_In_Tactical_Mode then
        if debuff == HORDE.Status_Ignite or debuff == HORDE.Status_Frostbite or debuff == HORDE.Status_Shock then
            bonus.less = bonus.less * 0.25
        end
    end
end]]--