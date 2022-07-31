PERK.PrintName = "Pressurized Warhead"
PERK.Description = "{1} increased Blast damage against elites.\nExplosions deal {2} to {3} of an enemy's current health as extra Blast damage."
PERK.Icon = "materials/perks/pressurized_warhead.png"
PERK.Params = {
    [1] = {value = 0.15, percent = true},
    [2] = {value = 0.01, percent = true},
    [3] = {value = 0.08, percent = true}
}

PERK.Hooks = {}
PERK.Hooks.Horde_OnPlayerDamage = function (ply, npc, bonus, hitgroup, dmginfo)
    if not ply:Horde_GetPerk("demolition_pressurized_warhead") then return end
    if HORDE:IsBlastDamage(dmginfo) then
        if npc:GetVar("is_elite") then
            bonus.increase = bonus.increase + 0.15
        end
        bonus.post_add = npc:Health() * math.min(0.08, dmginfo:GetDamage() / 2000)
    end
end
