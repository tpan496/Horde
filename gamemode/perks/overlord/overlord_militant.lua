PERK.PrintName = "Militant"
PERK.Description = [[{1} increased effectiveness of Agony.]]
PERK.Icon = "materials/perks/overlord/militant.png"
PERK.Params = {
    [1] = { value = 0.5, percent = true },
}
PERK.Hooks = {}
--Effects are in sv_fear.lua
PERK.Hooks.Horde_OnSetPerk = function(ply, perk)
    if SERVER and perk == "overlord_militant" then
        ply:Horde_SetMaxFearStack(ply:Horde_GetMaxFearStack() + 1)
    end
end

PERK.Hooks.Horde_OnUnsetPerk = function(ply, perk)
    if SERVER and perk == "overlord_militant" then
        ply:Horde_SetMaxFearStack(ply:Horde_GetMaxFearStack() - 1)
        if ply:Horde_GetPerk("overlord_base") then
            ply:Horde_AddOverlordPresence()
        else
            ply:Horde_RemoveOverlordPresence()
        end
    end
end
--[[
PERK.Hooks.Horde_OnPlayerDebuffApply = function(ply, debuff, bonus, inflictor)
    if not ply:Horde_GetPerk("overlord_militant") then return end
    bonus.less = bonus.less * 0.8
end

PERK.Hooks.Horde_OnPlayerDamage = function(ply, npc, bonus, hitgroup, dmginfo)
    if not ply:Horde_GetPerk("overlord_militant") then return end
    if HORDE:IsBallisticDamage(dmginfo) and npc:Horde_GetFearStack() > 0 then
        bonus.increase = bonus.increase + 0.25
    end
end
]]
