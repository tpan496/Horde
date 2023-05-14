PERK.PrintName = "Chain Reaction"
PERK.Description = [[Explosions deals up to {1} of an enemy's current health as extra Blast damage.
Damage increase is capped at {2}.]]
PERK.Icon = "materials/perks/chain_reaction.png"
PERK.Params = {
    [1] = {value = 0.08, percent = true},
    [2] = {value = 5000}
}

PERK.Hooks = {}

PERK.Hooks.Horde_OnPlayerDamage = function (ply, npc, bonus, hitgroup, dmginfo)
    if not ply:Horde_GetPerk("demolition_chain_reaction") then return end
    if HORDE:IsBlastDamage(dmginfo) then
        bonus.post_add = math.min(5000, npc:Health() * math.min(0.08, dmginfo:GetDamage() / 5000))
    end
end
