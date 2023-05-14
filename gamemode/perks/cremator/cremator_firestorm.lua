PERK.PrintName = "Firestorm"
PERK.Description = "Fire damage increases Burst buildup in enemies.\nCreates an explosion when Burst buildup is full.\nExplosion deals {1} Blast damage."
PERK.Icon = "materials/perks/firestorm.png"
PERK.Params = {
    [1] = {value = 25},
}

PERK.Hooks = {}
PERK.Hooks.Horde_OnPlayerDamagePost = function (ply, npc, bonus, hitgroup, dmginfo)
    if ply:Horde_GetPerk("cremator_firestorm") and HORDE:IsFireDamage(dmginfo) then
        npc:Horde_AddBurst(dmginfo:GetDamage(), npc, ply)
    end
end