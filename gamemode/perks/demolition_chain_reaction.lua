PERK.PrintName = "Chain Reaction"
PERK.Description = "Enemies you kill have 25% chance to explode,\ndealing 25% of their health as radiation damage."
PERK.Icon = "materials/perks/chain_reaction.png"

PERK.Hooks = {}
PERK.Hooks.OnNPCKilled = function(victim, killer, inflictor)
    if not victim:IsValid() or not victim:IsNPC() or not killer:IsPlayer() then return end
    if not killer:Horde_GetPerk("demolition_chain_reaction") then return end
    if inflictor:IsNPC() then return end -- Prevent infinite chains
    local p = math.random()
    if p <= 0.25 then
        local dmg = victim:GetMaxHealth() * 0.25
        local rad = 140
        local e = EffectData()
        e:SetOrigin(victim:GetPos())
        util.Effect("Explosion", e)
        util.BlastDamage(victim, killer, victim:GetPos(), rad, dmg)
    end
end