PERK.PrintName = "Pressurized Warhead"
PERK.Description = "{1} increased Blast damage against elites.\nExplosions deal {2} of an enemy's current health as extra Blast damage."
PERK.Icon = "materials/perks/pressurized_warhead.png"
PERK.Params = {
    [1] = {value = 0.25, percent = true},
    [2] = {value = 0.06, percent = true}
}

PERK.Hooks = {}
PERK.Hooks.Horde_OnPlayerDamage = function (ply, npc, bonus, hitgroup, dmginfo)
    if not ply:Horde_GetPerk("demolition_pressurized_warhead") then return end
    if HORDE:IsBlastDamage(dmginfo) then
        if npc:GetVar("is_elite") then
            bonus.increase = bonus.increase + 0.25
        end
        bonus.post_add = npc:Health() * 0.06
    end
end
