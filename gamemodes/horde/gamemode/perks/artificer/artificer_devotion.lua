PERK.PrintName = "Devotion"
PERK.Icon = "materials/perks/artificer/devotion.png"
PERK.Description =
[[{1} increased mind regeneration
{2} resistance against Fire and Lightning damage
Grants immunity to Ignite and Shock debuff]]

PERK.Params = {
    [1] = { value = 0.25, percent = true },
    [2] = { value = 0.5, percent = true }
}
PERK.Hooks = {}

PERK.Hooks.Horde_MindRegeneration = function ( ply, bonus )
    if ply:Horde_GetPerk( "artificer_devotion" ) then
        bonus.increase = bonus.increase + 0.25
    end
end

PERK.Hooks.Horde_OnPlayerDamageTaken = function ( ply, dmginfo, bonus )
    if not ply:Horde_GetPerk( "artificer_devotion" ) then return end
    if HORDE:IsFireDamage( dmginfo ) or HORDE:IsLightningDamage( dmginfo ) then
        bonus.resistance = bonus.resistance + 0.5
    end
end

PERK.Hooks.Horde_OnPlayerDebuffApply = function ( ply, debuff, bonus )
    if not ply:Horde_GetPerk( "artificer_devotion" ) then return end
    if debuff == HORDE.Status_Ignite or debuff == HORDE.Status_Shock then
        bonus.apply = 0
        return true
    end
end