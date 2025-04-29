if not ArcCWInstalled then return end
if CLIENT then
    SWEP.WepSelectIcon = surface.GetTextureID("arccw/weaponicons/arccw_go_nova")
    killicon.Add("arccw_horde_nova", "arccw/weaponicons/arccw_go_nova", Color(0, 0, 0, 255))
end
SWEP.Base = "arccw_base"
SWEP.Spawnable = true -- this obviously has to be set to true
SWEP.Category = "Horde - Shotguns" -- edit this if you like
SWEP.AdminOnly = false

SWEP.PrintName = "SuperNova"
SWEP.Trivia_Class = "Shotgun"
SWEP.Trivia_Desc = "Pump-action shotgun designed for hunting and tactical use. The SuperNova improves over the Nova with a mercury-based recoil reduction system, drillings for a picatinny rail, and improved, tighter slide."
SWEP.Trivia_Manufacturer = "Benelli Armi SpA"
SWEP.Trivia_Calibre = "12 Gauge"
SWEP.Trivia_Mechanism = "Pump-Action"
SWEP.Trivia_Country = "Italy"
SWEP.Trivia_Year = 2006

SWEP.Slot = 2

SWEP.UseHands = true

SWEP.ViewModel = "models/weapons/arccw_go/v_shot_nova.mdl"
SWEP.WorldModel = "models/weapons/arccw_go/v_shot_nova.mdl"
SWEP.ViewModelFOV = 60

SWEP.DefaultBodygroups = "000000000000"

--SWEP.Horde_Locational_DMG = true
SWEP.BodyDamageMults = {
    [HITGROUP_HEAD] = 2,
    [HITGROUP_CHEST] = 1,
    [HITGROUP_STOMACH] = 1,
    [HITGROUP_LEFTARM] = 0.75,
    [HITGROUP_RIGHTARM] = 0.75,
    [HITGROUP_LEFTLEG] = 0.5,
    [HITGROUP_RIGHTLEG] = 0.5,
}

SWEP.Damage = 14
SWEP.DamageMin = 7 -- damage done at maximum range
SWEP.Num = 8
SWEP.Range = 60 -- in METRES
SWEP.RangeMin = 10 -- GAME UNITS * 0.025 = METRES
SWEP.Penetration = 1
SWEP.DamageType = DMG_BUCKSHOT
SWEP.ShootEntity = nil -- entity to fire, if any
SWEP.ChamberSize = 1 -- how many rounds can be chambered.
SWEP.Primary.ClipSize = 4 -- DefaultClip is automatically set.

SWEP.PhysBulletMuzzleVelocity = 350

SWEP.Recoil = 3
SWEP.RecoilSide = 1.5
SWEP.RecoilRise = 0.1
--SWEP.RecoilPunch = 2.5

SWEP.ManualAction = true
SWEP.ShotgunReload = true
SWEP.Delay = 60 / 300 -- 60 / RPM.
SWEP.Firemodes = {
    {
        Mode = 1,
        PrintName = "PUMP"
    },
    {
        Mode = 0
    }
}

SWEP.NPCWeaponType = "weapon_shotgun"
SWEP.NPCWeight = 100

SWEP.AccuracyMOA = 25 -- accuracy in Minutes of Angle. There are 60 MOA in a degree.
SWEP.HipDispersion = 75 -- inaccuracy added by hip firing.
SWEP.MoveDispersion = 25

SWEP.Primary.Ammo = "buckshot" -- what ammo type the gun uses

SWEP.ShootVol = 120 -- volume of shoot sound
SWEP.ShootPitch = 100 -- pitch of shoot sound

SWEP.ShootSound = "arccw_go/nova/nova-1.wav"
SWEP.ShootSoundSilenced = "arccw_go/m590_suppressed_fp.wav"
SWEP.DistantShootSound = "arccw_go/nova/nova-1-distant.wav"

SWEP.MeleeSwingSound = "arccw_go/m249/m249_draw.wav"
SWEP.MeleeMissSound = "weapons/iceaxe/iceaxe_swing1.wav"
SWEP.MeleeHitSound = "arccw_go/knife/knife_hitwall1.wav"
SWEP.MeleeHitNPCSound = "physics/body/body_medium_break2.wav"

SWEP.MuzzleEffect = "muzzleflash_shotgun"
SWEP.ShellModel = "models/shells/shell_12gauge.mdl"
SWEP.ShellPitch = 100
SWEP.ShellSounds = ArcCW.ShotgunShellSoundsTable
SWEP.ShellScale = 1.5
SWEP.ShellRotateAngle = Angle(0, 180, 0)

SWEP.MuzzleEffectAttachment = 1 -- which attachment to put the muzzle on
SWEP.CaseEffectAttachment = 2 -- which attachment to put the case effect on

SWEP.SpeedMult = 0.95
SWEP.SightedSpeedMult = 0.75
SWEP.SightTime = 0.25

SWEP.IronSightStruct = {
    Pos = Vector(-4.28, -5, 2.7),
    Ang = Angle(0, 0, 0),
    Magnification = 1.1,
    SwitchToSound = "", -- sound that plays when switching to this sight
    CrosshairInSights = false
}

SWEP.HoldtypeHolstered = "passive"
SWEP.HoldtypeActive = "shotgun"
SWEP.HoldtypeSights = "ar2"

SWEP.AnimShoot = ACT_HL2MP_GESTURE_RANGE_ATTACK_RPG

SWEP.ActivePos = Vector(-1, 0, -1)
SWEP.ActiveAng = Angle(0, 0, 0)

SWEP.CrouchPos = Vector(-4, 0, -1)
SWEP.CrouchAng = Angle(0, 0, -10)

SWEP.HolsterPos = Vector(3, 3, 0)
SWEP.HolsterAng = Angle(-7.036, 30.016, 0)

SWEP.BarrelOffsetSighted = Vector(0, 0, -1)
SWEP.BarrelOffsetHip = Vector(2, 0, -2)

SWEP.CustomizePos = Vector(8, 0, 1)
SWEP.CustomizeAng = Angle(5, 30, 30)

SWEP.BarrelLength = 24

SWEP.AttachmentElements = {
    ["rail"] = {
        VMBodygroups = {{ind = 4, bg = 1}},
    },
    ["ubrms"] = {
        VMBodygroups = {{ind = 5, bg = 1}},
    },
    ["tacms"] = {
        VMBodygroups = {{ind = 6, bg = 1}},
    },
    ["go_nova_barrel_short"] = {
        VMBodygroups = {{ind = 1, bg = 1}},
        AttPosMods = {
            [5] = {
                vpos = Vector(0, -1.7, 22.5),
            }
        }
    },
    ["go_nova_barrel_long"] = {
        VMBodygroups = {{ind = 1, bg = 2}},
        AttPosMods = {
            [5] = {
                vpos = Vector(0, -1.7, 33.5),
            }
        }
    },
    ["go_nova_mag_8"] = {
        VMBodygroups = {{ind = 2, bg = 1}},
    },
    ["horde_go_nova_mag_8"] = {
        VMBodygroups = {{ind = 2, bg = 1}},
    },
    ["go_nova_stock_pistol"] = {
        VMBodygroups = {{ind = 3, bg = 1}},
        VMPoseParams = {["grip"] = 1}
    },
    ["go_nova_stock_sport"] = {
        VMBodygroups = {{ind = 3, bg = 2}},
        VMPoseParams = {["grip"] = 1}
    },
    ["go_nova_stock_folded"] = {
        VMBodygroups = {{ind = 3, bg = 1}},
        VMPoseParams = {["grip"] = 1}
    },
    ["go_stock"] = {
        VMBodygroups = {
            {ind = 3, bg = 1},
        },
        VMElements = {
            {
                Model = "models/weapons/arccw_go/atts/stock_buftube_lp.mdl",
                Bone = "v_weapon.NOVA_PARENT",
                Offset = {
                    pos = Vector(0, -0.25, 1),
                    ang = Angle(90, 0, -90),
                },
            }
        },
        VMPoseParams = {["grip"] = 1}
    },
}

SWEP.ExtraSightDist = 10
SWEP.GuaranteeLaser = true

SWEP.WorldModelOffset = {
    pos = Vector(-11.5, 6, -4),
    ang = Angle(-10, 0, 180)
}

SWEP.MirrorVMWM = true

SWEP.DefaultPoseParams = {["grip"] = 0}

SWEP.Attachments = {
    {
        PrintName = "Optic",
        Slot = "optic",
        Bone = "v_weapon.NOVA_PARENT",
        DefaultAttName = "Iron Sights",
        Offset = {
            vpos = Vector(0, -2.6, 8),
            vang = Angle(90, 0, -90),
        },
        CorrectiveAng = Angle(0, 0, 0),
        InstalledEles = {"rail", "nors"},
    },
    {
        PrintName = "Underbarrel",
        Slot = "foregrip",
        Bone = "v_weapon.NOVA_PUMP",
        Offset = {
            vpos = Vector(0, 1.3, 1.75),
            vang = Angle(90, 0, -90),
        },
        InstalledEles = {"ubrms"},
    },
    {
        PrintName = "Tactical",
        Slot = "tac",
        Bone = "v_weapon.NOVA_PUMP",
        Offset = {
            vpos = Vector(0.75, -0.65, 7.5),
            vang = Angle(90, 0, 0),
        },
        InstalledEles = {"tacms"},
    },
    {
        PrintName = "Barrel",
        Slot = "go_nova_barrel",
        DefaultAttName = "450mm Standard Barrel"
    },
    {
        PrintName = "Muzzle",
        DefaultAttName = "Standard Muzzle",
        Slot = "muzzle",
        Bone = "v_weapon.NOVA_PARENT",
        Offset = {
            vpos = Vector(0, -1.7, 28),
            vang = Angle(90, 0, -90),
        },
        InstalledEles = {"no_fh"}
    },
    {
        PrintName = "Magazine",
        Slot = "horde_go_nova_mag",
        DefaultAttName = "4-Round 12-Gauge Tube"
    },
    {
        PrintName = "Stock",
        Slot = {"go_nova_stock", "go_stock"},
        DefaultAttName = "Standard Stock",
        Bone = "v_weapon.NOVA_PARENT",
        Offset = {
            vpos = Vector(0, -0.25, 1),
            vang = Angle(90, 0, -90),
        },
    },
    {
        PrintName = "Ammo Type",
        Slot = "horde_go_shotgun_ammo", --go_ammo
        DefaultAttName = "Buckshot Shells"
    },
    {
        PrintName = "Perk",
        Slot = "go_perk"
    },
    {
        PrintName = "Charm",
        Slot = "charm",
        FreeSlot = true,
        Bone = "v_weapon.NOVA_PARENT", -- relevant bone any attachments will be mostly referring to
        Offset = {
            vpos = Vector(0.5, -0.5, 4), -- offset that the attachment will be relative to the bone
            vang = Angle(90, 0, -90),
        },
    },
}

function SWEP:Hook_TranslateAnimation(anim)
    if anim == "fire_iron" then
        if self:GetBuff_Override("NoStock") then return "fire" end
    elseif anim == "fire_iron_empty" then
        if self:GetBuff_Override("NoStock") then return "fire_empty" end
    end
end

SWEP.Animations = {
    ["idle"] = {
        Source = "idle"
    },
    ["draw"] = {
        Source = "draw",
        LHIK = true,
        LHIKIn = 0,
        LHIKOut = 0.5,
    },
    ["ready"] = {
        Source = "ready",
        LHIK = true,
        LHIKIn = 0,
        LHIKOut = 0.5,
    },
    ["fire"] = {
        Source = "shoot",
        Time = 0.5,
    },
    ["fire_iron"] = {
        Source = "idle",
        Time = 0.5,
    },
    ["cycle"] = {
        Source = "cycle",
        ShellEjectAt = 0.25,
        TPAnim = ACT_HL2MP_GESTURE_RANGE_ATTACK_SHOTGUN,
    },
    ["sgreload_start"] = {
        Source = "start_reload",
        TPAnim = ACT_HL2MP_GESTURE_RELOAD_SHOTGUN,
        LHIK = true,
        LHIKIn = 0.5,
        LHIKOut = 0,
        --Time = 0.2, --0.3
    },
    ["sgreload_insert"] = {
        Source = "insert",
        TPAnim = ACT_HL2MP_GESTURE_RELOAD_SHOTGUN,
        TPAnimStartTime = 0.3,
        LHIK = true,
        LHIKIn = 0,
        LHIKOut = 0,
        --Time = 0.3, --0.4
    },
    ["sgreload_finish"] = {
        Source = "end_reload",
        LHIK = true,
        LHIKIn = 0,
        LHIKOut = 1,
        --Time = 0.35, --0.5
    },
    ["sgreload_finish_empty"] = {
        Source = "end_reload_empty",
        LHIK = true,
        LHIKIn = 0,
        LHIKOut = 1,
    },
}

sound.Add({
    name = "ARCCW_GO_NOVA.Draw",
    channel = 16,
    volume = 1.0,
    sound = "arccw_go/nova/nova_draw.wav"
})

sound.Add({
    name = "ARCCW_GO_NOVA.Insertshell",
    channel = 16,
    volume = 1.0,
    sound = {
        "arccw_go/nova/nova_insertshell.wav",
        "arccw_go/nova/nova_insertshell_01.wav",
        "arccw_go/nova/nova_insertshell_02.wav",
        "arccw_go/nova/nova_insertshell_03.wav",
        "arccw_go/nova/nova_insertshell_04.wav"}
})

sound.Add({
    name = "ARCCW_GO_NOVA.Pump",
    channel = 16,
    volume = 1.0,
    sound = "arccw_go/nova/nova_pump.wav"
})