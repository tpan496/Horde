PERK.PrintName = "Chain Reaction"
PERK.Description = "Enemies you kill have 20% chance to explode,\ndealing 25% of their health as blast damage."

PERK.Parameters = {}

PERK.Hooks = {}

hook.Add("OnNPCKilled", "Horde_ChainReactionKill", function(victim, killer, inflictor)
    if not victim:IsValid() or not victim:IsNPC() or not killer:IsPlayer() then return end
    if not killer:Horde_GetPerk("demolition_chain_reaction")  then return end
    if inflictor:IsNPC() then return end -- Prevent infinite chains
    local p = math.random()
    if p <= 0.2 then
        local dmg = victim:GetMaxHealth() * 0.25
        local rad = 140
        local e = EffectData()
        e:SetOrigin(victim:GetPos())
        util.Effect("Explosion", e)
        util.BlastDamage(victim, killer, victim:GetPos(), rad, dmg)
    end
end)