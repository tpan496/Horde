PERK.PrintName = "Pressurized Warhead"
PERK.Description = "{1} increased Blast damage against elites."
PERK.Icon = "materials/perks/pressurized_warhead.png"
PERK.Params = {
    [1] = {value = 0.25, percent = true},
}

PERK.Hooks = {}
PERK.Hooks.Horde_OnPlayerDamage = function (ply, npc, bonus, hitgroup, dmginfo)
    if not npc:GetVar("is_elite") then return end
    if not ply:Horde_GetPerk("demolition_pressurized_warhead") then return end
    if dmginfo:GetDamageType() == DMG_BLAST or dmginfo:IsExplosionDamage() then
        bonus.increase = bonus.increase + 0.25
    end
end
