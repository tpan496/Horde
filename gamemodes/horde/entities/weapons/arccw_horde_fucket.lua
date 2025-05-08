if not ArcCWInstalled then return end
if CLIENT then
    SWEP.WepSelectIcon = surface.GetTextureID("arccw/weaponicons/arccw_mw2_fucket")
    killicon.Add("arccw_horde_fucket", "arccw/weaponicons/arccw_mw2_fucket", Color(0, 0, 0, 255))
end
SWEP.Base = "arccw_mw2_fucket"
SWEP.Spawnable = false -- this obviously has to be set to true
SWEP.Category = "ArcCW - Horde" -- edit this if you like
SWEP.AdminOnly = false

SWEP.PrintName = "Fucket"
SWEP.Slot = 1

SWEP.ViewModel = "models/weapons/arccw/fesiugmw2/c_musket.mdl"
SWEP.MirrorVMWM = true
SWEP.WorldModelOffset = {
    pos = Vector(-4, 4, -4),
    ang = Angle(-10, 0, 180),
    scale = 1.125
}
SWEP.WorldModel = "models/weapons/w_shotgun.mdl"

SWEP.Damage = 300
SWEP.DamageMin = 150 -- damage done at maximum range
SWEP.Range = 150 -- in METRES
SWEP.Penetration = 22
SWEP.VisualRecoilMult = 0
SWEP.Recoil = 0.5
SWEP.RecoilSide = 0

SWEP.IsShotgun = false

SWEP.Delay = 60 / 400 -- 60 / RPM.

SWEP.AccuracyMOA = 0.06 -- accuracy in Minutes of Angle. There are 60 MOA in a degree.
SWEP.HipDispersion = 800 -- inaccuracy added by hip firing.

SWEP.ShootVol = 75 -- volume of shoot sound

SWEP.SpeedMult = 0.9

SWEP.SightTime = 0.25

SWEP.Firemodes = {
    {
        PrintName = "SNGL",
        Mode = 1,
    },
    {
        Mode = 3,
        PrintName = "Double Shot"
    },
}

SWEP.Attachments = {
    {
        PrintName = "Optic",
        DefaultAttName = "Iron Sights",
        Slot = {"optic_lp", "optic", "optic_sniper"},
        Bone = "Weapon_Break",
        Offset = {
            vpos = Vector(0, -2.2, -5),
            vang = Angle(90, 0, -90),
            wpos = Vector(13.762, 0.832, -6.102),
            wang = Angle(-10.393, 0, 180)
        },
        InstalledEles = {"nors","mount"},
    },
    {
        PrintName = "Muzzle",
        DefaultAttName = "Standard Muzzle",
        Slot = "muzzle",
        Bone = "Weapon_Break",
        Offset = {
            vpos = Vector(0, -1.75, 12),
            vang = Angle(90, 0, -90),
            wpos = Vector(25, 0.825, -7.5),
            wang = Angle(-9.738, -1, 180)
        },
    },
    {
        PrintName = "Underbarrel",
        Slot = {"foregrip", "bipod", "style_pistol"},
        Bone = "Weapon_Break",
        Offset = {
            vpos = Vector(0, -0.25, 3),
            vang = Angle(90, 0, -90),
            wpos = Vector(14.329, 0.602, -4.453),
            wang = Angle(-10.216, 0, 180)
        },
    },
    {
        PrintName = "Tactical",
        Slot = "tac",
        Bone = "Weapon_Break",
        Offset = {
            vpos = Vector(-0.8, -2, 5),
            vang = Angle(90, 0, 180),
            wpos = Vector(19.625, 0.053, -6.298),
            wang = Angle(-8.829, -0.556, 90)
        },
    },
    {
        PrintName = "Fire Group",
        Slot = "fcg",
        DefaultAttName = "Standard FCG"
    },
    {
        PrintName = "Perk",
        Slot = {"perk","go_perk"}
    },
    {
        PrintName = "Ammo Type",
        Slot = {"ammo_shotgun", "go_ammo"}
    },
    {
        PrintName = "Charm",
        Slot = "charm",
        FreeSlot = true,
        Bone = "Weapon_Main",
        Offset = {
            vpos = Vector(0.75, -1.5, 6.5),
            vang = Angle(-90, 180, 90),
            wpos = Vector(9.625, 1.5, -4),
            wang = Angle(0, 0, 180)
        },
    },
}
function SWEP:Hook_ShouldNotFireFirst()
    if self:GetCurrentFiremode().Mode == 3 then
        self.AccuracyMOA = 2
        self.AmmoPerShot = 2
        self.Num = 2 -- number of shots per trigger pull.
    else
        self.AccuracyMOA = 1
        self.AmmoPerShot = 1
        self.Num = 1 -- number of shots per trigger pull.
    end
end
function SWEP:GetIsShotgun()
    if self.TickCache_IsShotgun == nil then
        local shotgun = self:GetBuff_Override("Override_IsShotgun")
        if shotgun != nil then
            self.TickCache_IsShotgun = shotgun
        end

        local num = self.Num
        if self.TickCache_IsShotgun == nil and num > 1 then self.TickCache_IsShotgun = false end
        -- makes it not turn into a "shotgun" when firing more than 1 bullet
        -- as it would switch what attachments are available depending on firemode which is just annoying
    end

    return self.TickCache_IsShotgun
end

function SWEP:Hook_ShouldNotFire()
    if CLIENT then return end
    if self:GetCurrentFiremode().Mode == 3 then
        local ply = self:GetOwner()
        if self:Clip1() >= 2 and not ply:KeyDown(IN_USE) then
            local dir = -ply:GetForward()
            dir:Normalize()
            local vel = dir * 250
            ply:SetLocalVelocity(ply:GetVelocity() + vel)
        end
    end
end