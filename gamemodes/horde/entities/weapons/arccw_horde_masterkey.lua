if not ArcCWInstalled then return end
if CLIENT then

    local mast = Material( "entities/acwatt_mw2_ubgl_masterkey.png", "smooth" )
    CreateMaterial( "vgui/arccw_horde_masterkey", "UnlitGeneric", { ["$basetexture"] = mast:GetName(), ["$translucent"] = 1,} )
    SWEP.WepSelectIcon = surface.GetTextureID("!vgui/arccw_horde_masterkey")
    killicon.Add("arccw_horde_masterkey", "!vgui/arccw_horde_masterkey", Color(0, 0, 0, 255))
end
SWEP.Base = "arccw_mw2_masterkey"
SWEP.Spawnable = true -- this obviously has to be set to true
SWEP.Category = "ArcCW - Horde" -- edit this if you like
SWEP.AdminOnly = false

SWEP.PrintName = "Masterkey"
SWEP.Slot = 2
SWEP.ViewModel = "models/weapons/arccw/fesiugmw2/c_mifl_masterkey_1.mdl"
SWEP.MirrorVMWM = true
SWEP.WorldModelOffset = {
    pos = Vector(-4, 3, -6),
    ang = Angle(-10, 0, 180),
    scale = 1.125
}
SWEP.WorldModel = "models/weapons/w_shot_m3super90.mdl"
SWEP.ViewModelFOV = 65
SWEP.Damage = 25
SWEP.DamageMin = 0
SWEP.Range = 1200 * 0.025  -- GAME UNITS * 0.025 = METRES
SWEP.Penetration = 1
SWEP.DamageType = DMG_BULLET
SWEP.ShootEntity = nil -- entity to fire, if any

SWEP.ChamberSize = 1
SWEP.Primary.ClipSize = 3 -- DefaultClip is automatically set.
SWEP.ExtendedClipSize = 5
SWEP.ReducedClipSize = 2

SWEP.VisualRecoilMult = 0
SWEP.Recoil = 2
SWEP.RecoilSide = 2

SWEP.ShotgunReload = true
SWEP.ManualAction = true

SWEP.Delay = 60 / 180 -- 60 / RPM.
SWEP.Num = 8 -- number of shots per trigger pull.
SWEP.AccuracyMOA = 75 -- accuracy in Minutes of Angle. There are 60 MOA in a degree.
SWEP.HipDispersion = 85 -- inaccuracy added by hip firing.
SWEP.MoveDispersion = 75 -- inaccuracy added by moving. Applies in sights as well! Walking speed is considered as "maximum".
SWEP.SightsDispersion = 0 -- dispersion that remains even in sights

SWEP.SpeedMult = 1.15
SWEP.SightedSpeedMult = 0.96
SWEP.SightTime = 0.1
SWEP.Attachments = {
    {
        PrintName = "Optic",
        DefaultAttName = "Iron Sights",
        Slot = {"optic_lp","optic"},
        Bone = "tag_weapon",
        Offset = {
            vpos = Vector(9.5, -0.07, 0.5),
            vang = Angle(0, 0, 0),
            wang = Angle(-9.738, 0, 180)
        },
    },
    {
        PrintName = "Muzzle",
        DefaultAttName = "Standard Muzzle",
        Slot = {"muzzle_shotgun", "muzzle"},
        Bone = "tag_weapon",
        Offset = {
            vpos = Vector(21, -0.075, -0.2),
            vang = Angle(0, 0, 0),
            wpos = Vector(26.648, 0.782, -8.042),
            wang = Angle(-9.79, 0, 180)
        },
    },
    {
        PrintName = "Underbarrel",
        Slot = {"foregrip"},
        Bone = "j_pump_shotgun",
        Offset = {
            vpos = Vector(0, 0, -0.7),
            vang = Angle(0, 0, 0),
            wpos = Vector(14.329, 0.602, -4.453),
            wang = Angle(-10.216, 0, 180)
        },
    },
    {
        PrintName = "Tactical",
        Slot = "tac",
        Bone = "j_pump_shotgun",
        Offset = {
            vpos = Vector(2, 0.5, 0),
            vang = Angle(0, 0, -90),
            wpos = Vector(15.625, -0.253, -6.298),
            wang = Angle(-8.829, -0.556, 90)
        },
        VMScale = Vector(1.25, 1.25, 1.25),
    },
    {
        PrintName = "Ammo Type",
        Slot = {"ammo_shotgun", "go_ammo"}
    },
    {
        PrintName = "Perk",
        Slot = {"perk","go_perk"}
    },
    {
        PrintName = "Charm",
        Slot = "charm",
        FreeSlot = true,
        Bone = "tag_weapon",
        Offset = {
            vpos = Vector(11, -0.4, -0.75),
            vang = Angle(0, 0, 0),
            wpos = Vector(9.625, 1.5, -4),
            wang = Angle(0, 0, 180)
        },
    },
}

SWEP.Animations = {
    ["idle"] = {
        Source = "idle",
        Time = 0.066,
    },
    ["draw"] = {
        Source = "draw",
        Time = 0.316,
        SoundTable = {{s = "MW2Common.Deploy", 		t = 0}},
        LHIK = true,
        LHIKIn = 0,
        LHIKOut = 0.9,
    },
    ["fire"] = {
        Source = "alt_fire",
        Time = 0.5,
    },
    ["fire_iron"] = {
        Source = "alt_fire",
        Time = 0.366,
    },
    ["cycle"] = {
        Source = "alt_cycle",
        Time = 0.5,
        SoundTable = {{s = "weapons/fesiugmw2/foley/wpfoly_winchester_reload_pump_v1.wav", 		t =  0.067}},
        ShellEjectAt =  0.067,
        MinProgress = 0.333, -- how much time in seconds must pass before the animation can be cancelled
    },
    ["sgreload_start"] = {
        Source = "alt_reload_start",
        Time = (35 / 30) * 0.5,
        TPAnim = ACT_HL2MP_GESTURE_RELOAD_SHOTGUN,
        RestoreAmmo = 1,
        SoundTable = {
                        {s = "weapons/fesiugmw2/foley/wpfoly_winchester_reload_lift_v1.wav", 	t = (0 / 30) * 0.5},
                        {s = "weapons/fesiugmw2/foley/wpfoly_winchester_reload_loop_v1.wav", 	t = (26 / 30) * 0.5},
                    },
        LHIK = true,
        LHIKIn = 0.5,
        LHIKOut = 0,
    },
    ["sgreload_insert"] = {
        Source = "alt_reload_loop",
        Time = (33 / 30) * 0.35,
        TPAnim = ACT_HL2MP_GESTURE_RELOAD_SHOTGUN,
        SoundTable = {{s = "weapons/fesiugmw2/foley/wpfoly_winchester_reload_loop_v1.wav", 		t = (23 / 30) * 0.35}},
        TPAnimStartTime = 0.3,
        LHIK = true,
        LHIKIn = 0,
        LHIKOut = 0,
    },
    ["sgreload_finish"] = {
        Source = "alt_reload_finish",
        Time = (50 / 30) * 0.5,
        SoundTable = {{s = "weapons/fesiugmw2/foley/wpfoly_winchester_reload_pump_v1.wav", 		t = (21 / 30) * 0.5}},
        LHIK = true,
        LHIKIn = 0,
        LHIKOut = 0.8,
    },
    ["sgreload_finish_empty"] = {
        Source = "alt_reload_finish",
        Time = (50 / 30) * 0.5, --what the fuck is this number
        SoundTable = {{s = "weapons/fesiugmw2/foley/wpfoly_winchester_reload_pump_v1.wav", 		t = (21 / 30) * 0.5}},
        LHIK = true,
        LHIKIn = 0,
        LHIKOut = 0.8,
    },
}
