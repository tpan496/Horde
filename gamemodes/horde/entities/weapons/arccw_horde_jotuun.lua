if not ArcCWInstalled then return end
if CLIENT then
    SWEP.WepSelectIcon = surface.GetTextureID("vgui/hud/arccw_horde_serpent")
    SWEP.DrawWeaponInfoBox	= false
    SWEP.BounceWeaponIcon = false
    killicon.Add("arccw_horde_jotuun", "vgui/hud/arccw_horde_serpent", Color(0, 0, 0, 255))
end

SWEP.Base = "arccw_horde_base_melee"
SWEP.Spawnable = true -- this obviously has to be set to true
SWEP.Category = "ArcCW - Horde" -- edit this if you like
SWEP.AdminOnly = false

SWEP.PrintName = "Jötunn"
SWEP.Trivia_Class = "Melee Weapon"
SWEP.Trivia_Desc = "Spiked mace with ice-related abilities."
SWEP.Trivia_Manufacturer = "Jötunn"
SWEP.Trivia_Calibre = "N/A"
SWEP.Trivia_Mechanism = "Blunt Weapon"
SWEP.Trivia_Country = "???"
SWEP.Trivia_Year = 0

SWEP.Slot = 0

SWEP.NotForNPCs = true

SWEP.UseHands = true

SWEP.ViewModel = "models/horde/weapons/c_mace.mdl"
SWEP.WorldModel = "models/horde/weapons/c_mace.mdl"
SWEP.ViewModelFOV = 40
SWEP.WorldModelOffset = {
    pos = Vector(-4, 10, -5),
    ang = Angle(90, 0, 180),
    scale = 2
}

SWEP.DefaultSkin = 0
SWEP.DefaultWMSkin = 0

SWEP.MeleeDamage = 120
SWEP.Melee2Damage = 100

SWEP.PrimaryBash = true
SWEP.CanBash = true
SWEP.MeleeDamageType = DMG_CLUB
SWEP.MeleeRange = 75
SWEP.MeleeAttackTime = 0.5
SWEP.MeleeTime = 0.75
SWEP.MeleeGesture = ACT_HL2MP_GESTURE_RANGE_ATTACK_MELEE

SWEP.Melee2 = true
SWEP.Melee2Range = 75
SWEP.Melee2AttackTime = 0.5
SWEP.Melee2Time = 1.25
SWEP.Melee2Gesture = ACT_HL2MP_GESTURE_RANGE_ATTACK_MELEE2

SWEP.MeleeSwingSound = {
    "horde/weapons/jotuun/attack.ogg",
}
SWEP.MeleeMissSound = {
    "horde/weapons/jotuun/attack.ogg",
}
SWEP.MeleeHitSound = {
    "horde/weapons/jotuun/strike.ogg",
}
SWEP.MeleeHitNPCSound = {
    "horde/weapons/jotuun/hit0.ogg",
    "horde/weapons/jotuun/hit1.ogg",
}

SWEP.NotForNPCs = true

SWEP.Firemodes = {
    {
        Mode = 1,
        PrintName = "MELEE"
    },
}

function SWEP:GetCurrentFiremode()
    return {Mode = 1, PrintName = "MELEE"}
end

SWEP.HoldtypeHolstered = "normal"
SWEP.HoldtypeActive = "melee2"

SWEP.Primary.ClipSize = -1

SWEP.AttachmentElements = {
}

SWEP.Attachments = {
}

SWEP.Animations = {
    ["idle"] = false,
    ["draw"] = {
        Source = "first_raise",
        Time = 0.8,
    },
    ["bash"] = {
        Source = {"slash1", "slash3"},
        Time = 1.5,
    },
    ["bash2"] = {
        Source = {"slash2"},
        Time = 2,
    },
}

SWEP.IronSightStruct = false

SWEP.ActivePos = Vector(0, 5, 0)
SWEP.ActiveAng = Angle(0, 0, 0)

SWEP.BashPreparePos = Vector(0, 0, 0)
SWEP.BashPrepareAng = Angle(0, 20, 0)

SWEP.BashPos = Vector(0, 0, 0)
SWEP.BashAng = Angle(35, -30, 0)

SWEP.HolsterPos = Vector(0, -3, -2)
SWEP.HolsterAng = Angle(-10, 0, 0)

function SWEP:Hook_PostBash(t)
    local tr = t.tr
    if SERVER and IsValid(tr.Entity) and (tr.Entity:IsNPC() or tr.Entity:IsPlayer() or tr.Entity:Health() > 0) then
        local attacker = self:GetOwner()
        if !IsValid(attacker) then attacker = self end

        local dmginfo = DamageInfo()
        if t.melee2 then
            dmginfo:SetDamage(150)

            for _, ent in pairs(ents.FindInSphere(tr.HitPos, 75)) do
                if (HORDE:IsPlayerOrMinion(ent) == true) then
                elseif ent:IsNPC() and ent ~= tr.Entity then
                    local dmg = DamageInfo()
                    dmg:SetDamage(75)
                    dmg:SetDamageType(DMG_REMOVENORAGDOLL)
                    dmg:SetAttacker(self.Owner)
                    dmg:SetInflictor(self)
                    dmg:SetDamagePosition(ent:GetPos() + ent:OBBCenter())
                    ent:TakeDamageInfo(dmg)
                end
            end

            local e = EffectData()
            e:SetOrigin(tr.HitPos)
            util.Effect("horde_jotuun_ice_explosion", e)

            self.Owner:Horde_AddDebuffBuildup(HORDE.Status_Frostbite, 15)
        else
            dmginfo:SetDamage(35)
            self.Owner:Horde_AddDebuffBuildup(HORDE.Status_Frostbite, 1)
        end

        dmginfo:SetAttacker(self:GetOwner())
        dmginfo:SetInflictor(self)
        dmginfo:SetDamageForce(self:GetOwner():GetRight() * -4912 + self:GetOwner():GetForward() * 9989)
        dmginfo:SetDamageType(DMG_REMOVENORAGDOLL)
        dmginfo:SetDamagePosition(tr.HitPos)
        tr.Entity:TakeDamageInfo(dmginfo)
    end
end