HORDE:CreateClass(
    HORDE.Class_Demolition,
    "75% less explosive damage taken.\n\nRegenerate 1 frag grenade every 30 seconds, if you do not have one.\n\n",
    "Have full access to Explosive weapons.",
    100,
    GetConVar("horde_base_walkspeed"):GetInt(),
    GetConVar("horde_base_runspeed"):GetInt(),
    {
        [1] = {title = "Grenade", choices = {"demolition_frag_impact", "demolition_frag_cluster"}},
        [2] = {title = "Approach", choices = {"demolition_fragmentation", "demolition_napalm"}},
        [3] = {title = "Destruction", choices = {"demolition_pressurized_warhead", "demolition_chain_reaction"}},
    },
    4
)