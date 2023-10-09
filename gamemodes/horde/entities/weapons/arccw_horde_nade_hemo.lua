if not ArcCWInstalled then return end
if CLIENT then
    SWEP.WepSelectIcon = surface.GetTextureID("arccw/weaponicons/arccw_horde_nade_hemo")
    killicon.Add("arccw_horde_nade_hemo", "arccw/weaponicons/arccw_horde_nade_hemo", Color(0, 0, 0, 255))
    killicon.Add("arccw_thr_hemo", "arccw/weaponicons/arccw_horde_nade_hemo", Color(0, 0, 0, 255))
end
SWEP.Base = "arccw_horde_base_nade"
SWEP.Spawnable = true -- this obviously has to be set to true
SWEP.Category = "ArcCW - Horde" -- edit this if you like
SWEP.AdminOnly = false

SWEP.PrintName = "Hemo Grenade"
SWEP.Trivia_Class = "Hand Grenade"
SWEP.Trivia_Desc = "."
SWEP.Trivia_Manufacturer = "Combine"
SWEP.Trivia_Calibre = "N/A"
SWEP.Trivia_Mechanism = "Condensed Blood Plasma"
SWEP.Trivia_Country = "Combine"
SWEP.Trivia_Year = 2010
SWEP.Primary.MaxAmmo = 9
SWEP.ForceDefaultAmmo = 0

SWEP.Slot = 4

SWEP.NotForNPCs = true

SWEP.UseHands = true

SWEP.ViewModel = "models/weapons/c_grenade.mdl"
SWEP.WorldModel = "models/weapons/w_grenade.mdl"
SWEP.ViewModelFOV = 60

SWEP.WorldModelOffset = {
    pos = Vector(3, 2, -1),
    ang = Angle(-10, 0, 180)
}

SWEP.FuseTime = 2

SWEP.Throwing = true

SWEP.Primary.ClipSize = 1

SWEP.MuzzleVelocity = 1000
SWEP.ShootEntity = "arccw_thr_hemo"

SWEP.TTTWeaponType = "weapon_ttt_confgrenade"
SWEP.NPCWeaponType = "weapon_grenade"
SWEP.NPCWeight = 50

SWEP.PullPinTime = 0.25

SWEP.Animations = {
    ["draw"] = {
        Source = "deploy",
        Time = 0.25,
    },
    ["idle"] = {
        Source = "idle01",
    },
    ["pre_throw"] = {
        Source = "drawbackhigh",
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

function SWEP:Initialize()
    if CLIENT then
        local vm = self.Owner:GetViewModel()
        vm:SetColor(Color(255, 0, 0))
        vm:SetMaterial("Debug/hsv")
    end
end

SWEP.BodyMaterial	 	= 'models/horde/grenade/hemo_grenade_body'

SWEP.VMMaterial = SWEP.BodyMaterial