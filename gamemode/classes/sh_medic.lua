HORDE:CreateClass(
    HORDE.Class_Medic,
    "Regenerate 2% health per second.\n\n",
    "Have acesss to most light weapons and medic grenades.",
    100,
    GetConVar("horde_base_walkspeed"):GetInt(),
    GetConVar("horde_base_runspeed"):GetInt(),
    {
        [1] = {title = "Medicine", choices = {"medic_antibiotics", "medic_painkillers"}},
        [2] = {title = "Bio-Engineering", choices = {"medic_berserk", "medic_fortify"}},
        [3] = {title = "Natural Selection", choices = {"medic_cellular_implosion", "medic_xcele"}},
    },
    3
)