PERK.PrintName = "Demon Strike"
PERK.Description =
[[{1} increased Bleeding buildup.
{2} increased Melee damage against Bleeding enemies.
Leech {3} Melee damage dealt during Quickstep.]]
PERK.Icon = "materials/perks/samurai/demon_strike.png"
PERK.Params = {
    [1] = {value = 0.20, percent = true},
    [2] = {value = 0.30, percent = true},
    [3] = {value = 0.25, percent = true},
}
PERK.Hooks = {}

PERK.Hooks.Horde_OnEnemyDebuffApply = function (npc, debuff, bonus, inflictor)
    if debuff == HORDE.Status_Bleeding and inflictor:Horde_GetPerk("samurai_demon_strike") then
        bonus.increase = bonus.increase + 0.2
    end
end

PERK.Hooks.Horde_OnPlayerDamage = function (ply, npc, bonus, hitgroup, dmginfo)
    if not ply:Horde_GetPerk("samurai_demon_strike") then return end
    if HORDE:IsMeleeDamage(dmginfo) and npc:Horde_HasDebuff(HORDE.Status_Bleeding) then
        bonus.increase = bonus.increase + 0.3
    end
end

PERK.Hooks.Horde_OnPlayerDamagePost = function (ply, npc, bonus, hitgroup, dmginfo)
    if not ply.Horde_In_Quickstep then return end
    if ply:Horde_GetPerk("samurai_demon_strike") then
        if HORDE:IsMeleeDamage(dmginfo) then
            HORDE:SelfHeal(ply, dmginfo:GetDamage() * 0.25)
        end
    end
end