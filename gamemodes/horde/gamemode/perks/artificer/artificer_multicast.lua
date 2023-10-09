PERK.PrintName = "Multicast"
PERK.Description =
[[Allows you to cast other spells while charging.
You can only multicast spells that do not require charging.]]
PERK.Icon = "materials/perks/artificer/multicast.png"
PERK.Params = {}
PERK.Hooks = {}
PERK.Hooks.Horde_PreSpellCharge = function (ply, spell, wpn, charging)
    if ply:Horde_GetPerk("artificer_multicast") and charging == true then
        if spell.ChargeTime[1] > 0 then return true end
        if ply:Horde_GetMind() < spell.Mind[1] then return true end
        if spell.Slot == HORDE.Spell_Slot_LMB then
            wpn:PrimarySpellFire(1)
        elseif spell.Slot == HORDE.Spell_Slot_RMB then
            wpn:SecondarySpellFire(1)
        elseif spell.Slot == HORDE.Spell_Slot_Utility then
            wpn:UtilitySpellFire(1)
        elseif spell.Slot == HORDE.Spell_Slot_Reload then
            wpn:UltimateSpellFire(1)
        end
        return true
    end
end