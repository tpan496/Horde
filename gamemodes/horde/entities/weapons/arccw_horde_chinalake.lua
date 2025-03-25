if not ArcCWInstalled then return end
SWEP.Base = "arccw_horde_gl_base"
SWEP.Spawnable = true -- this obviously has to be set to true
SWEP.Category = "ArcCW - Horde (Custom)" -- edit this if you like
SWEP.AdminOnly = false

SWEP.PrintName = "China Lake"
SWEP.Trivia_Class = "Grenade Launcher"
SWEP.Trivia_Desc = "An experimental pump-action 40mm Grenade Launcher. Not to be confused with the EX-41."
SWEP.Trivia_Manufacturer = "N.A.W.S. China Lake"
SWEP.Trivia_Calibre = "40mm"
SWEP.Trivia_Mechanism = "Pump-Action"
SWEP.Trivia_Country = "United States"
SWEP.Trivia_Year = 1967

SWEP.Slot = 3

SWEP.Spawnable = true


SWEP.UseHands = true

SWEP.ViewModel = "models/horde/weapons/arccw/c_bo1_chinalake.mdl"
SWEP.WorldModel = "models/horde/weapons/arccw/c_bo1_chinalake.mdl"
SWEP.MirrorVMWM = true
SWEP.WorldModelOffset = {
    pos = Vector(2, 5, -6),
    ang = Angle(-16, 0, 180),
    bone = "ValveBiped.Bip01_R_Hand",
    scale = 1
}
SWEP.ViewModelFOV = 60

SWEP.Damage = 35
SWEP.DamageMin = 20 -- damage done at maximum range
SWEP.Range = 50 -- in METRES
SWEP.Penetration = 2
SWEP.DamageType = DMG_BULLET
SWEP.ShootEntity = "horde_projectile_he_round" -- entity to fire, if any
SWEP.MuzzleVelocity = 100000 -- projectile or phys bullet muzzle velocity
-- IN M/S

SWEP.CanFireUnderwater = false

SWEP.TracerNum = 1 -- tracer every X
SWEP.TracerCol = Color(255, 25, 25)
SWEP.TracerWidth = 3

SWEP.ChamberSize = 0 -- how many rounds can be chambered.
SWEP.Primary.ClipSize = 4 -- DefaultClip is automatically set.
SWEP.ExtendedClipSize = 4
SWEP.ReducedClipSize = 4

SWEP.Recoil = 2
SWEP.RecoilSide = 2
SWEP.MaxRecoilBlowback = 2

SWEP.ShotgunReload = true
SWEP.ManualAction = true
SWEP.NoLastCycle = true -- Prevents cycling when empty

-- Function to prevent post-reload cycling
SWEP.Hook_PostReload = function(wep)
    wep.SetNeedCycle(false)
end

-- 

-- SWEP.Delay = 60 / 300 -- 60 / RPM.
SWEP.Num = 1 -- number of shots per trigger pull.
SWEP.Firemodes = {
    {
        PrintName = "fcg.pump",
        Mode = 1,
    },
    {
        Mode = 0
    }
}

SWEP.NPCWeaponType = "weapon_shotgun"
SWEP.NPCWeight = 120

SWEP.AccuracyMOA = 10 -- accuracy in Minutes of Angle. There are 60 MOA in a degree.
SWEP.HipDispersion = 150 -- inaccuracy added by hip firing.
SWEP.MoveDispersion = 250

SWEP.Primary.Ammo = "SMG1_Grenade" -- what ammo type the gun uses

SWEP.ShootVol = 110 -- volume of shoot sound
SWEP.ShootPitch = 100 -- pitch of shoot sound

SWEP.ShootSound = "ArcCW_BO1.CL_Fire"
SWEP.ShootSoundSilenced = nil
SWEP.DistantShootSound = nil

SWEP.MuzzleEffect = "muzzleflash_shotgun"
SWEP.ShellModel = "models/shells/shell_12gauge.mdl"
SWEP.ShellScale = 1.5

SWEP.MuzzleEffectAttachment = 1 -- which attachment to put the muzzle on
SWEP.CaseEffectAttachment = 2 -- which attachment to put the case effect on

SWEP.SightTime = 0.175

SWEP.SpeedMult = 0.95
SWEP.SightedSpeedMult = 0.6

SWEP.BarrelLength = 18

SWEP.ProceduralRegularFire = false
SWEP.ProceduralIronFire = false

SWEP.CaseBones = {}

SWEP.IronSightStruct = {
    Pos = Vector(-3.4, -3, 0.5),
    Ang = Angle(0.1, 0.05, 0),
    Magnification = 1.3
}

SWEP.HoldtypeHolstered = "normal"
SWEP.HoldtypeActive = "shotgun"
SWEP.HoldtypeSights = "ar2"

SWEP.AnimShoot = ACT_HL2MP_GESTURE_RANGE_ATTACK_SHOTGUN

SWEP.ActivePos = Vector(1, 3, 0.25)
SWEP.ActiveAng = Angle(0, 0, 0)

SWEP.SprintPos = Vector(0, 3, 0)
SWEP.SprintAng = Angle(0, 0, 0)

SWEP.CustomizePos = Vector(13, 5, -2)
SWEP.CustomizeAng = Angle(15, 40, 15)

SWEP.HolsterPos = Vector(0.532, -6, 0)
SWEP.HolsterAng = Angle(-7.036, 30.016, 0)

SWEP.BarrelOffsetSighted = Vector(0, 0, -1)
SWEP.BarrelOffsetHip = Vector(2, 0, -2)

SWEP.AttachmentElements = {

}

SWEP.ExtraSightDist = 5

SWEP.RejectAttachments = {["go_homemade_auto"] = true, ["go_perk_burst"] = true}
SWEP.Attachments = {
    {
        PrintName = "Ammo",
        Slot = "horde_ammo"
    },
    {
        PrintName = "Perk",
        Slot = "go_perk"
    },
    {
        PrintName = "Charm",
        Slot = "charm",
        FreeSlot = true,
        Bone = "tag_weapon",
        Offset = {
            vpos = Vector(-2, -1.1, 0.15), -- offset that the attachment will be relative to the bone
            vang = Angle(0, 0, 0),
            wpos = Vector(7, 1.6, -4),
            wang = Angle(-10, 0, 180)
        },
    }, --6
}

SWEP.Animations = {
    ["idle"] = {
        Source = "idle",
        Time = 1 / 30,
    },
    ["draw"] = {
        Source = "draw",
        Time = 1,
        LHIK = true,
        LHIKIn = 0.2,
        LHIKOut = 0.2,
        SoundTable = {
            {s = "ArcCW_BO1.CL_Sight", t = 22 / 50}
        },
    },
    ["holster"] = {
        Source = "holster",
        Time = 1,
        LHIK = true,
        LHIKIn = 0.2,
        LHIKOut = 0.1,
        SoundTable = {
            {s = "ArcCW_BO1.CL_Sight", t = 20 / 40}
        },
    },
    ["ready"] = {
        Source = "first_draw",
        LHIK = true,
        LHIKIn = 0.2,
        LHIKOut = 0.95,
        SoundTable = {
            {s = "ArcCW_BO1.CL_Back", t = 26 / 30},
            {s = "ArcCW_BO1.CL_Fwd", t = 28 / 30}
        },
    },
    ["fire"] = {
        Source = {
            "fire",
        },
        MinProgress = 0.5
    },
    ["fire_iron"] = {
        Source = {
            "fire",
        },
        MinProgress = 0.5
    },
    ["cycle"] = {
        Source = {
            "pump",
        },
        Time = 69 / 50,
        SoundTable = {
            {s = "ArcCW_BO1.CL_Back", t = 25 / 50},
            {s = "ArcCW_BO1.CL_Fwd", t = 37 / 50}
        },
    },
    ["cycle_iron"] = {
        Source = {
            "pump",
        },
        Time = 69 / 50,
        SoundTable = {
            {s = "ArcCW_BO1.CL_Back", t = 26 / 50},
            {s = "ArcCW_BO1.CL_Fwd", t = 38 / 50}
        },
    },
    ["sgreload_start"] = {
        Source = "reload_in",
        Time = 30 / 48,
        TPAnim = ACT_HL2MP_GESTURE_RELOAD_SHOTGUN,
        LHIK = true,
        LHIKIn = 0.5,
        LHIKOut = 0,
        SoundTable = {
            {s = "ArcCW_BO1.CL_Back", t = 4 / 48}
        },
    },
    ["sgreload_insert"] = {
        Source = "reload_loop",
        Time = 52 / 48,
        TPAnim = ACT_HL2MP_GESTURE_RELOAD_SHOTGUN,
        TPAnimStartTime = 0.3,
        LHIK = true,
        LHIKIn = 0,
        LHIKOut = 0,
        MinProgress = 17 / 48,
        SoundTable = {
            {s = "ArcCW_BO1.CL_Shell", t = 17 / 48}
        },
    },
    ["sgreload_finish"] = {
        Source = "reload_out",
        Time = 36 / 48,
        LHIK = true,
        LHIKIn = 0,
        LHIKOut = 1,
        SoundTable = {
            {s = "ArcCW_BO1.CL_Fwd", t = 20 / 48}
        },
    },
    ["enter_sprint"] = {
        Source = "sprint_in",
    },
    ["idle_sprint"] = {
        Source = "sprint_loop",
    },
    ["exit_sprint"] = {
        Source = "sprint_out",
    },
}

sound.Add({
    name = "ArcCW_BO1.CL_Fire",
    channel = CHAN_WEAPON,
    volume = 1.0,
    level = 100,
    sound = "^weapons/arccw/bo1_chinalake/fire.wav"
})
sound.Add({
    name = "ArcCW_BO1.CL_Back",
    channel = CHAN_WEAPON,
    volume = 1.0,
    level = 100,
    sound = "^weapons/arccw/bo1_chinalake/back.wav"
})
sound.Add({
    name = "ArcCW_BO1.CL_Fwd",
    channel = CHAN_WEAPON,
    volume = 1.0,
    level = 100,
    sound = "^weapons/arccw/bo1_chinalake/forward.wav"
})
sound.Add({
    name = "ArcCW_BO1.CL_Sight",
    channel = CHAN_WEAPON,
    volume = 1.0,
    level = 100,
    sound = "^weapons/arccw/bo1_chinalake/sight.wav"
})
sound.Add({
    name = "ArcCW_BO1.CL_Shell",
    channel = CHAN_WEAPON,
    volume = 1.0,
    level = 100,
    sound = {
        "^weapons/arccw/bo1_chinalake/load1.wav",
        "^weapons/arccw/bo1_chinalake/load2.wav"
    }
})
