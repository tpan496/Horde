-- Status Mapping
-- Please use the variable names instead of the values!

HORDE.Status_Camoflague = 0
HORDE.Status_Adrenaline = 1
HORDE.Status_Headhunter = 2
HORDE.Status_Fortify = 3
HORDE.Status_Berserk = 4
HORDE.Status_ArmorRegen = 5
HORDE.Status_HealthRegen = 6
HORDE.Status_Minion = 7
HORDE.Status_Mindeye = 8
HORDE.Status_WardenAura = 9
HORDE.Status_ExpDisabled = 10
HORDE.Status_EntropyShield = 11
HORDE.Status_CanBuy = 12

HORDE.Status_Icon = {}
HORDE.Status_Icon[HORDE.Status_Camoflague] = "materials/status/camoflague.png"
HORDE.Status_Icon[HORDE.Status_Adrenaline] = "materials/status/adrenaline.png"
HORDE.Status_Icon[HORDE.Status_Headhunter] = "materials/perks/headhunter.png"
HORDE.Status_Icon[HORDE.Status_Fortify] = "materials/perks/fortify.png"
HORDE.Status_Icon[HORDE.Status_Berserk] = "materials/perks/berserk.png"
HORDE.Status_Icon[HORDE.Status_ArmorRegen] = "materials/status/armorregen.png"
HORDE.Status_Icon[HORDE.Status_HealthRegen] = "materials/status/healthregen.png"
HORDE.Status_Icon[HORDE.Status_Minion] = "materials/status/minion.png"
HORDE.Status_Icon[HORDE.Status_Mindeye] = "materials/perks/mindeye.png"
HORDE.Status_Icon[HORDE.Status_WardenAura] = "materials/warden.png"
HORDE.Status_Icon[HORDE.Status_ExpDisabled] = "materials/status/exp_disabled.png"
HORDE.Status_Icon[HORDE.Status_EntropyShield] = "materials/perks/entropy_shield.png"
HORDE.Status_Icon[HORDE.Status_CanBuy] = "materials/status/canbuy.png"

function HORDE:IsStatusStackable(status)
    if status == HORDE.Status_Adrenaline or status == HORDE.Status_Headhunter or status == HORDE.Status_Minion or status == HORDE.Status_Mindeye then return true end
    return false
end