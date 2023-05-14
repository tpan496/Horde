if not ArcCWInstalled then return end
-- Referenced From GSO
SWEP.Base = "arccw_base_nade"
SWEP.Spawnable = true -- this obviously has to be set to true
SWEP.Category = "ArcCW - Horde" -- edit this if you like
SWEP.AdminOnly = false

SWEP.PrintName = "Medic Grenade"
SWEP.Trivia_Class = "Hand Grenade"
SWEP.Trivia_Desc = "A grenade that releases detoxification clouds."
SWEP.Trivia_Manufacturer = "Horzine Biotech"
SWEP.Trivia_Calibre = "N/A"
SWEP.Trivia_Mechanism = "Medic Grenade MKI"
SWEP.Trivia_Country = "Britain"
SWEP.Trivia_Year = 2000
SWEP.Primary.MaxAmmo = 9
SWEP.ForceDefaultAmmo = 0

SWEP.Slot = 4

SWEP.NotForNPCs = true

SWEP.UseHands = true

SWEP.ViewModel = "models/weapons/arccw_go/v_eq_smokegrenade.mdl"
SWEP.WorldModel = "models/weapons/arccw_go/w_eq_smokegrenade_thrown.mdl"
SWEP.ViewModelFOV = 60

SWEP.WorldModelOffset = {
    pos = Vector(3, 2, -1),
    ang = Angle(-10, 0, 180)
}

SWEP.FuseTime = 2

SWEP.Throwing = true

SWEP.Primary.ClipSize = 1


SWEP.MuzzleVelocity = 1000
SWEP.ShootEntity = "arccw_thr_medicgrenade"

SWEP.TTTWeaponType = "weapon_ttt_medicgrenade"
SWEP.NPCWeaponType = "weapon_grenade"
SWEP.NPCWeight = 50

SWEP.PullPinTime = 0.25

SWEP.Animations = {
    ["draw"] = {
        Source = "deploy",
        Time = 0.25,
    },
    ["pre_throw"] = {
        Source = "pullpin",
        Time = 0.25,
    },
    ["throw"] = {
        Source = "throw",
        TPAnim = ACT_HL2MP_GESTURE_RANGE_ATTACK_GRENADE,
        SoundTable = {
            {
                s = "arccw_go/hegrenade/grenade_throw.wav",
                t = 0
            }
        }
    }
}

sound.Add({
    name = "ARCCW_GO_GRENADE.PullPin_Grenade_Start",
    channel = 16,
    volume = 1.0,
    sound = "arccw_go/hegrenade/pinpull_start.wav"
})

sound.Add({
    name = "ARCCW_GO_GRENADE.PullPin_Grenade",
    channel = 16,
    volume = 1.0,
    sound = "arccw_go/hegrenade/pinpull.wav"
})