PERK.PrintName = "Flesh Bloom"
PERK.Description =
[[Melee damage applies Bleeding buildup in an area.]]
PERK.Icon = "materials/subclasses/samurai.png"
PERK.Params = {
    [1] = {value = 0.20, percent = true},
}
PERK.Hooks = {}

PERK.Hooks.Horde_OnPlayerDamage = function (ply, npc, bonus, hitgroup, dmginfo)
    if not ply:Horde_GetPerk("samurai_flesh_bloom") then return end
    if HORDE:IsMeleeDamage(dmginfo) then
        local buildup = dmginfo:GetDamage() * 0.3
        HORDE:ApplyDebuffInRadius(HORDE.Status_Bleeding, ply:GetPos(), 150, buildup, ply)
    end
end