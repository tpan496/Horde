HORDE:CreateClass(
    "Demolition",
    "75% less explosive damage taken.\n\nRegenerate 1 frag grenade every 30 seconds, if you do not have one.\n\n",
    "Have full access to Explosive weapons.",
    100,
    GetConVar("horde_base_walkspeed"):GetInt(),
    GetConVar("horde_base_runspeed"):GetInt(),
    {
        [1] = {title = "Grenade", choices = {
            {name = "Impact Detonation", perks = {["demolition_frag_impact"] = {}}},
            {name = "Cluster Bombs", perks = {["demolition_frag_cluster"] = {}}},
        }},
        [2] = {title = "Incendiary Loadout", choices = {
            {name = "Professional Package", perks = {["loadout_wave_grenade"] = {weapon = "arccw_go_nade_incendiary", ammotype = "arccw_go_nade_incendiary"}}},
            {name = "Beer Party", perks = {["loadout_wave_grenade"] = {weapon = "arccw_go_nade_molotov", ammotype = "arccw_go_nade_molotov"}}},
        }},
        [3] = {title = "Payload", choices = {
            {name = "Pressure Blast", perks = {["frag_double"] = {}}},
            {name = "Cluster Bombs", perks = {["frag_cluster"] = {}}},
        }},
    }
)