if not ArcCWInstalled then return end
if CLIENT then
    SWEP.WepSelectIcon = surface.GetTextureID("arccw/weaponicons/arccw_bo2_raygunmk2")
    killicon.Add("arccw_horde_raygun_mk2", "arccw/weaponicons/arccw_bo2_raygunmk2", Color(0, 0, 0, 255))
end

if SERVER then
    PrecacheParticleSystem("rgmk2_flash")
    PrecacheParticleSystem("rgmk2_pap_flash")
    PrecacheParticleSystem("rgmk2_impact_glow")
    PrecacheParticleSystem("rgmk2_pap_impact_glow")
    game.AddParticles( "particles/bo1/raygunmk2.pcf" )
end

SWEP.Base = "arccw_base"
SWEP.Spawnable = true -- this obviously has to be set to true
SWEP.Category = "ArcCW - Horde (Custom)" -- edit this if you like
SWEP.AdminOnly = false

SWEP.PrintName = "Ray Gun Mark II"
SWEP.Trivia_Class = "Wonder Weapon"
SWEP.Trivia_Desc = "Second iteration of the classic Ray Gun, now in the format of a first fire SMG."
SWEP.Trivia_Manufacturer = "Group 935"
SWEP.Trivia_Calibre = " Atomic Cold Cells"
SWEP.Trivia_Mechanism = "Unknown"
SWEP.Trivia_Country = "Unknown"
SWEP.Trivia_Year = "Unknown"

SWEP.Slot = 1

SWEP.UseHands = true

SWEP.ViewModel = "models/horde/weapons/arccw/c_bo2_raygunmk2.mdl"
SWEP.WorldModel = "models/horde/weapons/arccw/w_bo2_raygunmk2.mdl"
SWEP.MirrorWorldModel = "models/horde/weapons/arccw/w_bo2_raygunmk2.mdl"
SWEP.MirrorVMWM = true
SWEP.WorldModelOffset = {
    scale = 1.1,
    pos        =    Vector(-12, 6.2, -6),
    ang        =    Angle(-6, 0, 180),
    bone    =    "ValveBiped.Bip01_R_Hand",
}
SWEP.ViewModelFOV = 60

SWEP.Damage = 80
SWEP.DamageMin = 60 -- damage done at maximum range
SWEP.Range = 200 -- in METRES
SWEP.Penetration = 10
SWEP.DamageType = DMG_SHOCK
SWEP.MuzzleVelocity = 10000 -- projectile or phys bullet muzzle velocity
-- IN M/S

SWEP.CanFireUnderwater = false

SWEP.Tracer = "ToolTracer"
SWEP.TracerNum = 1 -- tracer every X
SWEP.TracerCol = Color(75, 255, 25)
SWEP.TracerWidth = 10

SWEP.ChamberSize = 0 -- how many rounds can be chambered.
SWEP.Primary.ClipSize = 21 -- DefaultClip is automatically set.
SWEP.ExtendedClipSize = 42

SWEP.Recoil = 0.2
SWEP.RecoilSide = 0.2
SWEP.RecoilRise = 0.2
SWEP.RecoilPunch = 0

SWEP.Delay = 60 / 500 -- 60 / RPM.
SWEP.Num = 1 -- number of shots per trigger pull.
SWEP.Firemodes = {
    {
        Mode = -3,
        RunawayBurst = true,
        PostBurstDelay = 0.2,
    },
    {
        Mode = 0
    }
}

SWEP.NPCWeaponType = {"weapon_pistol", "weapon_357"}
SWEP.NPCWeight = 0

SWEP.AccuracyMOA = 0 -- accuracy in Minutes of Angle. There are 60 MOA in a degree.
SWEP.HipDispersion = 200 -- inaccuracy added by hip firing.
SWEP.MoveDispersion = 100

SWEP.ShootWhileSprint = false

SWEP.Primary.Ammo = "RPG_Round" -- what ammo type the gun uses
SWEP.MagID = "raygun" -- the magazine pool this gun draws from

SWEP.ShootVol = 75 -- volume of shoot sound
SWEP.ShootPitch = 100 -- pitch of shoot sound

SWEP.ShootSound = "ArcCW_BO2.RGMK2_Fire"

--SWEPHook_PostFireBullets = function(wep)
--end

SWEP.MuzzleEffect = "rgmk2_flash"
SWEP.ImpactEffect = "rgmk2_impact_glow"
SWEP.GMMuzzleEffect = false
SWEP.ShellModel = ""
SWEP.ShellScale = 1.5
SWEP.ShellPitch = 90

SWEP.MuzzleEffectAttachment = 1 -- which attachment to put the muzzle on
SWEP.CaseEffectAttachment = 0 -- which attachment to put the case effect on

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
    Pos = Vector(-5.325, 3, 0.7),
    Ang = Angle(0.1, 0, 0),
    Magnification = 1.1,
    CrosshairInSights = false,
    SwitchToSound = "", -- sound that plays when switching to this sight
}

SWEP.HoldtypeHolstered = "normal"
SWEP.HoldtypeActive = "ar2"
SWEP.HoldtypeSights = "ar2"

SWEP.AnimShoot = ACT_HL2MP_GESTURE_RANGE_ATTACK_AR2

SWEP.ActivePos = Vector(0, 1, 0)
SWEP.ActiveAng = Angle(0, 0, 0)

SWEP.SprintPos = Vector(0, 1, 0)
SWEP.SprintAng = Angle(0, 0, 0)

SWEP.CustomizePos = Vector(15, 2, 0)
SWEP.CustomizeAng = Angle(15, 40, 30)

SWEP.HolsterPos = Vector(0, -1, 1)
SWEP.HolsterAng = Angle(-15, 23, 0)

SWEP.BarrelOffsetSighted = Vector(0, 0, -1)
SWEP.BarrelOffsetHip = Vector(2, 0, -2)

SWEP.AttachmentElements = {
    ["papraygun"] = {
        NamePriority = 10,
        TrueNameChange = "Porter's Mark II Ray Gun",
    },
}

SWEP.ExtraSightDist = 2

SWEP.RejectAttachments = {
    ["tac_bo2_anpeq"] = true,
}

SWEP.Attachments = {
    { --1
        PrintName = "Tactical",
        Slot = "tac",
        Bone = "tag_weapon",
        VMScale = Vector(0.75, 0.75, 0.75),
        WMScale = Vector(0.75, 0.75, 0.75),
        Offset = {
            vpos = Vector(3.5, 0, 0),
            vang = Angle(0, 0, 0),
        },
    },
    { --2
        PrintName = "Ammo Type",
        Slot = {"go_ammo"}
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
            vpos = Vector(-2.5, -1.35, 3),
            vang = Angle(0, 0, 10),
        },
    },
}

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
        Time = 0.75,
        LHIK = true,
        LHIKIn = 0.2,
        LHIKOut = 0.25,
    },
    ["ready"] = {
        Source = "first_draw",
        Time = 1.46,
        SoundTable = {
            {s = "ArcCW_BO2.RGMK2_Raise", t = 1 / 30},
            {s = "ArcCW_BO1.RayGun_Obtain", t = 1 / 30},
        }
    },
    ["fire"] = {
        Source = {"fire"},
        Time = 12 / 30,
    },
    ["fire_iron"] = {
        Source = "fire_ads",
        Time = 12 / 30,
    },
    ["reload"] = {
        Source = "reload",
        Time = 3.5,
        TPAnim = ACT_HL2MP_GESTURE_RELOAD_PISTOL,
        LHIK = true,
        LHIKIn = 0.2,
        LHIKOut = 0.2,
        SoundTable = {
            {s = "ArcCW_BO2.RGMK2_Switch", t = 11 / 30},
            {s = "ArcCW_BO2.RGMK2_Out", t = 25 / 30},
            {s = "ArcCW_BO2.RGMK2_In", t = 70 / 30},
        },
    },

    ["enter_sprint"] = {
        Source = "sprint_in",
        Time = 10 / 30
    },
    ["idle_sprint"] = {
        Source = "sprint_loop",
        Time = 30 / 40
    },
    ["exit_sprint"] = {
        Source = "sprint_out",
        Time = 10 / 30
    },
}

sound.Add({
    name = "ArcCW_BO2.RGMK2_Fire",
    channel = CHAN_STATIC,
    level = 100,
    sound = {
        "^weapons/arccw/bo2_raygunmk2/fire1.wav",
        "^weapons/arccw/bo2_raygunmk2/fire2.wav",
        "^weapons/arccw/bo2_raygunmk2/fire3.wav",
    }
})
sound.Add({
    name = "ArcCW_BO2.RGMK2_In",
    channel = CHAN_ITEM,
    level = 70,
    sound = "^weapons/arccw/bo2_raygunmk2/in.wav"
})
sound.Add({
    name = "ArcCW_BO2.RGMK2_Out",
    channel = CHAN_ITEM,
    level = 70,
    sound = "^weapons/arccw/bo2_raygunmk2/out.wav"
})
sound.Add({
    name = "ArcCW_BO2.RGMK2_Raise",
    channel = CHAN_ITEM,
    level = 70,
    sound = "^weapons/arccw/bo2_raygunmk2/raise.wav"
})
sound.Add({
    name = "ArcCW_BO2.RGMK2_Switch",
    channel = CHAN_ITEM,
    level = 70,
    sound = "^weapons/arccw/bo2_raygunmk2/switch.wav"
})

sound.Add({
    name = "ArcCW_BO2.RGMK2_Impact",
    channel = CHAN_USER_BASE + 1,
    level = 70,
    sound = {
        "^weapons/arccw/bo2_raygunmk2/imp1.wav",
        "^weapons/arccw/bo2_raygunmk2/imp2.wav",
        "^weapons/arccw/bo2_raygunmk2/imp3.wav"
    }
})
