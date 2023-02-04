PERK.PrintName = "Chain Reaction"
PERK.Description = [[Enemies you kill have {1} chance to explode,
dealing {2} of their health as Blast damage.]]
PERK.Icon = "materials/perks/chain_reaction.png"
PERK.Params = {
    [1] = {value = 0.30, percent = true},
    [2] = {value = 0.50, percent = true},
}

PERK.Hooks = {}
PERK.Hooks.Horde_OnEnemyKilled = function(victim, killer, inflictor)
    if not victim:IsValid() or not victim:IsNPC() or not killer:IsPlayer() then return end
    if not killer:Horde_GetPerk("demolition_chain_reaction") then return end
    if inflictor:IsNPC() then return end -- Prevent infinite chains
    local p = math.random()
    if p <= 0.30 then
        local dmg = victim:GetMaxHealth() * 0.50
        local rad = 150
        local e = EffectData()
        e:SetOrigin(victim:GetPos())
        util.Effect("Explosion", e)
        util.BlastDamage(victim, killer, victim:GetPos(), rad, dmg)
    end
end