-- Status Mapping

HORDE.Status_Camoflague = 0
HORDE.Status_Adrenaline = 1
HORDE.Status_Headhunter = 2
HORDE.Status_Fortify = 3
HORDE.Status_Berserk = 4
HORDE.Status_ArmorRegen = 5
HORDE.Status_HealthRegen = 6

HORDE.Status_Icon = {}
HORDE.Status_Icon[HORDE.Status_Camoflague] = "materials/status/camoflague.png"
HORDE.Status_Icon[HORDE.Status_Adrenaline] = "materials/status/adrenaline.png"
HORDE.Status_Icon[HORDE.Status_Headhunter] = "materials/perks/headhunter.png"
HORDE.Status_Icon[HORDE.Status_Fortify] = "materials/perks/fortify.png"
HORDE.Status_Icon[HORDE.Status_Berserk] = "materials/perks/berserk.png"
HORDE.Status_Icon[HORDE.Status_ArmorRegen] = "materials/status/armorregen.png"
HORDE.Status_Icon[HORDE.Status_HealthRegen] = "materials/status/healthregen.png"

function HORDE:IsStatusStackable(status)
    if status == HORDE.Status_Adrenaline or status == HORDE.Status_Headhunter then return true end
    return false
end