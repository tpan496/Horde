if not ArcCWInstalled then return end
if CLIENT then
    SWEP.WepSelectIcon = surface.GetTextureID("arccw/weaponicons/arccw_go_nade_molotov")
    killicon.Add("arccw_horde_fire", "arccw/weaponicons/arccw_go_nade_molotov", Color(0, 0, 0, 255))
end
SWEP.Base = "arccw_horde_base_nade"
SWEP.Spawnable = true -- this obviously has to be set to true
SWEP.Category = "ArcCW - Horde" -- edit this if you like
SWEP.AdminOnly = false

SWEP.PrintName = "Molotov Cocktail"
SWEP.Trivia_Class = "Hand Grenade"
SWEP.Trivia_Desc = "Improvised hand grenade created with a bottle of fuel and a rag, lit on fire and thrown. The Molotov Cocktail earned its name from Soviet foreign minister Vyacheslav Molotov, who claimed that Soviet bombing raids were humanitarian aid packages. Sarcastically, the Finns dubbed the bombs 'Molotov's Breadbaskets', and when they developed the fuel bomb to fight Soviet tanks, named them 'Molotov's Cocktails', to go with his food parcels."
SWEP.Trivia_Manufacturer = "The People"
SWEP.Trivia_Calibre = "N/A"
SWEP.Trivia_Mechanism = "Gasoline + Dish Soap"
SWEP.Trivia_Country = "Finland"
SWEP.Trivia_Year = 1939
SWEP.Primary.MaxAmmo = 9
SWEP.ForceDefaultAmmo = 0

SWEP.Slot = 4

SWEP.NotForNPCs = true

SWEP.UseHands = true

SWEP.ViewModel = "models/weapons/arccw_go/v_eq_molotov.mdl"
SWEP.WorldModel = "models/weapons/arccw_go/w_eq_molotov_thrown.mdl"
SWEP.ViewModelFOV = 60

SWEP.WorldModelOffset = {
    pos = Vector(3, 2, -1),
    ang = Angle(-10, 0, 180)
}

SWEP.ProceduralViewBobIntensity = 0

SWEP.FuseTime = false

SWEP.FuseTime = false

SWEP.Throwing = true

SWEP.Primary.ClipSize = 1


SWEP.MuzzleVelocity = 1000
SWEP.ShootEntity = "arccw_thr_horde_molotov"

SWEP.TTTWeaponType = "weapon_zm_molotov"
SWEP.NPCWeaponType = "weapon_grenade"
SWEP.NPCWeight = 50

SWEP.PullPinTime = 1

SWEP.Animations = {
    ["draw"] = {
        Source = "deploy",
        Time = 0.25,
    },
    ["pre_throw"] = {
        Source = "pullpin",
        SoundTable = {
            {
                t = 0,
                s = "arccw_go/molotov/fire_idle_loop_1.wav",
                c = CHAN_WEAPON
            }
        }
    },
    ["throw"] = {
        Source = "throw",
        TPAnim = ACT_HL2MP_GESTURE_RANGE_ATTACK_GRENADE,
        SoundTable = {
            {
                t = 0,
                s = "arccw_go/molotov/grenade_throw.wav",
                c = CHAN_WEAPON
            }
        }
    }
}

sound.Add({
    name = "ARCCW_GO_MOLOTOV.Draw",
    channel = 16,
    volume = 1.0,
    sound = "arccw_go/molotov/molotov_draw.wav"
})