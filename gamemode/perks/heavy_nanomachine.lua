PERK.PrintName = "Nanomachine"
PERK.Description = "100% increased armor regeneration rate.\nYou can now regenerate up to 35 armor."
PERK.Icon = "materials/perks/nanomachine.png"

PERK.Parameters = {}

PERK.Hooks = {}

PERK.Hooks.Horde_OnSetPerk = function(ply, perk, params)
    if SERVER and perk == "heavy_nanomachine" then
        ply:Horde_SetArmorRegenEnabled(true)
        ply:Horde_SetArmorRegenAmount(2)
        ply:Horde_SetArmorRegenMax(35)
    end
end

PERK.Hooks.Horde_OnUnsetPerk = function(ply, perk, params)
    if SERVER and perk == "heavy_nanomachine" then
        ply:Horde_SetArmorRegenEnabled(nil)
        ply:Horde_SetArmorRegenAmount(1)
        ply:Horde_SetArmorRegenMax(25)
        ply:SetArmor(0)
    end
end
