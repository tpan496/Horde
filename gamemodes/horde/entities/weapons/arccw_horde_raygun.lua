if not ArcCWInstalled then return end
if CLIENT then
    SWEP.WepSelectIcon = surface.GetTextureID("arccw/weaponicons/arccw_bo1_raygun")
    killicon.Add("arccw_horde_raygun", "arccw/weaponicons/arccw_bo1_raygun", Color(0, 0, 0, 255))
    killicon.Add("horde_projectile_raygun_bolt", "arccw/weaponicons/arccw_bo1_raygun", Color(0, 0, 0, 255))
end

SWEP.Base = "arccw_base"
SWEP.Spawnable = true -- this obviously has to be set to true
SWEP.Category = "ArcCW - Horde (Custom)" -- edit this if you like
SWEP.AdminOnly = false

SWEP.PrintName = "Ray Gun"
SWEP.Trivia_Class = "Wonder Weapon"
SWEP.Trivia_Desc = "An experimental Nazi Wonder Weapon. Fires green bolts of plasma which explode on impact. Careful not to kill yourself with it."
SWEP.Trivia_Manufacturer = "Group 935"
SWEP.Trivia_Calibre = " Atomic Cold Cells"
SWEP.Trivia_Mechanism = "Unknown"
SWEP.Trivia_Country = "Nazi Germany"
SWEP.Trivia_Year = 1942

SWEP.Slot = 1

SWEP.UseHands = true

SWEP.ViewModel = "models/horde/weapons/arccw/c_bo1_raygun.mdl"
SWEP.WorldModel = "models/hordde/weapons/arccw/c_bo1_raygun.mdl"
SWEP.MirrorVMWM = true
SWEP.WorldModelOffset = {
    scale = 1.1,
    pos        =    Vector(-20, 5, -5.5),
    ang        =    Angle(-6, -2.5, 180),
    bone    =    "ValveBiped.Bip01_R_Hand",
}
SWEP.ViewModelFOV = 60

SWEP.Damage = 200
SWEP.DamageMin = 200 -- damage done at maximum range
SWEP.Range = 200 -- in METRES
SWEP.Penetration = 0
SWEP.DamageType = DMG_SHOCK
SWEP.ShootEntity = "horde_projectile_raygun_bolt"
SWEP.MuzzleVelocity = 10000 -- projectile or phys bullet muzzle velocity
-- IN M/S

SWEP.CanFireUnderwater = false

--SWEP.Tracer = "bo1_raygun_tracer"
SWEP.TracerNum = 1 -- tracer every X
--SWEP.TracerCol = Color(75, 255, 25)
SWEP.TracerWidth = 10

SWEP.ChamberSize = 0 -- how many rounds can be chambered.
SWEP.Primary.ClipSize = 20 -- DefaultClip is automatically set.
SWEP.ExtendedClipSize = 40

SWEP.Recoil = 0
SWEP.RecoilSide = 0
SWEP.RecoilRise = 0
SWEP.RecoilPunch = 0

SWEP.Delay = 60 / 181 -- 60 / RPM.
SWEP.Num = 1 -- number of shots per trigger pull.
SWEP.Firemodes = {
    {
        Mode = 2,
    },
    {
        Mode = 0
    }
}

SWEP.NPCWeaponType = {"weapon_pistol", "weapon_357"}
SWEP.NPCWeight = 0

SWEP.AccuracyMOA = 0 -- accuracy in Minutes of Angle. There are 60 MOA in a degree.
SWEP.HipDispersion = 0 -- inaccuracy added by hip firing.
SWEP.MoveDispersion = 0

SWEP.ShootWhileSprint = false

SWEP.Primary.Ammo = "RPG_Round" -- what ammo type the gun uses
SWEP.MagID = "raygun" -- the magazine pool this gun draws from

SWEP.ShootVol = 115 -- volume of shoot sound
SWEP.ShootPitch = 100 -- pitch of shoot sound

SWEP.ShootSound = "ArcCW_BO1.RayGun_Fire"

--SWEPHook_PostFireBullets = function(wep)
--end

SWEP.MuzzleEffect = "raygun_flash"
SWEP.GMMuzzleEffect = false
SWEP.ShellModel = ""
SWEP.ShellScale = 1.5
SWEP.ShellPitch = 90

SWEP.MuzzleEffectAttachment = 1 -- which attachment to put the muzzle on
SWEP.CaseEffectAttachment = 0 -- which attachment to put the case effect on
SWEP.ProceduralViewBobAttachment = 1
SWEP.CamAttachment = 3

SWEP.SightTime = 0.175

SWEP.SpeedMult = 1
SWEP.SightedSpeedMult = 0.75

SWEP.BarrelLength = 12

SWEP.BulletBones = { -- the bone that represents bullets in gun/mag
    -- [0] = "bulletchamber",
    -- [1] = "bullet1"
}

SWEP.ProceduralRegularFire = false
SWEP.ProceduralIronFire = false

SWEP.CaseBones = {}

SWEP.IronSightStruct = {
    Pos = Vector(-5, 0, 1.75),
    Ang = Angle(-0.6, -0.125, 0),
    Magnification = 1.1,
    CrosshairInSights = false,
    SwitchToSound = "", -- sound that plays when switching to this sight
}

SWEP.HoldtypeHolstered = "normal"
SWEP.HoldtypeActive = "pistol"
SWEP.HoldtypeSights = "revolver"

SWEP.AnimShoot = ACT_HL2MP_GESTURE_RANGE_ATTACK_PISTOL

SWEP.ActivePos = Vector(0, -2, 1)
SWEP.ActiveAng = Angle(0, 0, 0)

SWEP.SprintPos = Vector(0, -2, -6)
SWEP.SprintAng = Angle(5, 0, 0)

SWEP.CustomizePos = Vector(13, -8, 0)
SWEP.CustomizeAng = Angle(15, 40, 20)

SWEP.HolsterPos = Vector(0, -1, 1)
SWEP.HolsterAng = Angle(-15, 23, 0)

SWEP.BarrelOffsetSighted = Vector(0, 0, -1)
SWEP.BarrelOffsetHip = Vector(2, 0, -2)

SWEP.ExtraSightDist = 2

SWEP.RejectAttachments = {
    ["tac_bo2_anpeq"] = true,
}

SWEP.Attachments = {
    {
        PrintName = "Ammo",
        Slot = "horde_ammo"
    },
    { --3
        PrintName = "Perk",
        Slot = "go_perk"
    },
    { --4
        PrintName = "Charm",
        Slot = "charm",
        Bone = "tag_weapon",
        Offset = {
            vpos = Vector(-0.5, -1.6, 1.9),
            vang = Angle(0, 0, 0),
            wpos = Vector(7.25, 2.5, -3.8),
            wang = Angle(-5, -2, 177.5)
        },
    },
}

SWEP.Hook_TranslateAnimation = function(wep, anim, data)
    if wep:Clip1() == 0 then
        return anim .. "_empty"
    end
end

SWEP.Animations = {
    ["idle"] = {
        Source = "idle",
        Time = 1 / 30,
    },
    ["draw"] = {
        Source = "draw",
        Time = 1,
    },
    ["holster"] = {
        Source = "holster",
        Time = 0.666,
        LHIK = true,
        LHIKIn = 0.2,
        LHIKOut = 0.25,
    },
    ["ready"] = {
        Source = "first_draw",
        Time = 65 / 30,
        SoundTable = {
            {s = "ArcCW_BO1.RayGun_Obtain", t = 1 / 30},
        }
    },
    ["fire"] = {
        Source = {"fire"},
        Time = 12 / 30,
    },
    ["fire_iron"] = {
        Source = "fire",
        Time = 12 / 30,
    },
    ["reload"] = {
        Source = "reload",
        Time = 120 / 30,
        TPAnim = ACT_HL2MP_GESTURE_RELOAD_PISTOL,
        LHIK = true,
        LHIKIn = 0.2,
        LHIKOut = 0.2,
        SoundTable = {
            {s = "ArcCW_BO1.RayGun_Open", t = 11 / 30},
            {s = "ArcCW_BO1.RayGun_Out", t = 38 / 30},
            {s = "ArcCW_BO1.RayGun_In", t = 71 / 30},
            {s = "ArcCW_BO1.RayGun_Close", t = 95 / 30},
        },
    },
    ["reload_empty"] = {
        Source = "reload",
        Time = 120 / 30,
        TPAnim = ACT_HL2MP_GESTURE_RELOAD_PISTOL,
        LHIK = true,
        LHIKIn = 0.2,
        LHIKOut = 0.2,
        SoundTable = {
            {s = "ArcCW_BO1.RayGun_Open", t = 11 / 30},
            {s = "ArcCW_BO1.RayGun_Out", t = 38 / 30},
            {s = "ArcCW_BO1.RayGun_In", t = 71 / 30},
            {s = "ArcCW_BO1.RayGun_Close", t = 95 / 30},
        },
    },
}

sound.Add({
    name = "ArcCW_BO1.RayGun_Fire",
    channel = CHAN_USER_BASE,
    volume = 1.0,
    level = 100,
    --pitch = {95, 110},
    sound = "^weapons/arccw/bo1_raygun/fire.wav"
})
sound.Add({
    name = "ArcCW_BO1.RayGun_In",
    channel = CHAN_ITEM,
    level = 70,
    sound = "^weapons/arccw/bo1_raygun/in.wav"
})

sound.Add({
    name = "ArcCW_BO1.RayGun_Out",
    channel = CHAN_ITEM,
    level = 70,
    sound = "^weapons/arccw/bo1_raygun/out.wav"
})

sound.Add({
    name = "ArcCW_BO1.RayGun_Open",
    channel = CHAN_ITEM,
    level = 70,
    sound = "^weapons/arccw/bo1_raygun/open.wav"
})

sound.Add({
    name = "ArcCW_BO1.RayGun_Close",
    channel = CHAN_ITEM,
    level = 70,
    sound = "^weapons/arccw/bo1_raygun/close.wav"
})

sound.Add({
    name = "ArcCW_BO1.RayGun_Obtain",
    channel = CHAN_USER_BASE + 1,
    level = 100,
    sound = "^weapons/arccw/bo1_raygun/obtain.wav"
})

sound.Add({
    name = "ArcCW_BO1.RayGun_Splash",
    channel = CHAN_USER_BASE + 1,
    level = 70,
    sound = "^weapons/arccw/bo1_raygun/splash.wav"
})
