if not ArcCWInstalled then return end
if CLIENT then
    SWEP.WepSelectIcon = surface.GetTextureID("arccw/weaponicons/arccw_go_g3")
    killicon.Add("arccw_horde_g3", "arccw/weaponicons/arccw_go_g3", Color(0, 0, 0, 255))
end
SWEP.Base = "arccw_go_g3"
SWEP.Spawnable = true -- this obviously has to be set to true
SWEP.Category = "ArcCW - Horde" -- edit this if you like
SWEP.AdminOnly = false

SWEP.PrintName = "G3 (Horde)"
SWEP.Slot = 2

SWEP.ViewModel = "models/weapons/arccw_go/v_rif_g3.mdl"
SWEP.WorldModel = "models/weapons/arccw_go/v_rif_g3.mdl"

SWEP.Damage = 91
SWEP.DamageMin = 75 -- damage done at maximum range
SWEP.VisualRecoilMult = 0

SWEP.RecoilPunch = 0.2

SWEP.Delay = 0.13 -- 60 / RPM.
SWEP.HipDispersion = 300 -- inaccuracy added by hip firing.
SWEP.MoveDispersion = 150

SWEP.ShootVol = 75 -- volume of shoot sound

SWEP.SpeedMult = 0.95

SWEP.SightTime = 0.25

SWEP.Hook_ModifyBodygroups = function(wep, data)
    local vm = data.vm
    local eles = data.eles

    local barrel = false
    local tacms = false
    local ubrms = false

    for i, k in pairs(eles or {}) do
        if k == "go_g3_barrel_sd" then
            barrel = true
        elseif k == "ubrms" then
            ubrms = true
        elseif k == "tacms" then
            tacms = true
        end
    end

    if not IsValid(vm) then return end

    if tacms then
        if barrel then
            vm:SetBodygroup(8, 2)
        else
            vm:SetBodygroup(8, 1)
        end
    end

    if ubrms then
        if barrel then
            vm:SetBodygroup(7, 2)
        else
            vm:SetBodygroup(7, 1)
        end
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
        ShellEjectAt = 0,
    },
    ["fire_iron"] = {
        Source = "idle",
        Time = 0.5,
        ShellEjectAt = 0,
    },
    ["reload"] = {
        Source = "reload",
        TPAnim = ACT_HL2MP_GESTURE_RELOAD_AR2,
        Checkpoints = {16, 30},
        FrameRate = 30,
        LHIK = true,
        LHIKIn = 0.7,
        LHIKOut = 0.9,
        LHIKEaseOut = 0.7,
        Time = 2.5
    },
    ["reload_empty"] = {
        Source = "reload_empty",
        TPAnim = ACT_HL2MP_GESTURE_RELOAD_AR2,
        Checkpoints = {16, 30, 55},
        FrameRate = 30,
        LHIK = true,
        LHIKIn = 0.7,
        LHIKOut = 0.9,
        LHIKEaseOut = 0.7,
        Time = 2.5
    },
    ["enter_inspect"] = false,
    ["idle_inspect"] = false,
    ["exit_inspect"] = false,
}

