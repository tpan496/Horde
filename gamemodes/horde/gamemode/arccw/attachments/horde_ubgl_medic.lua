if not ArcCWInstalled then return end

AddCSLuaFile()

local att = {}

att.PrintName = "Medic Grenade Launcher"
att.Icon = Material("entities/acwatt_mw2_ubgl_m203.png", "smooth")
att.Description = "Medic grenade launcher."
att.Desc_Pros = {
}
att.Desc_Cons = {
}
att.Desc_Neutrals = {
}
att.AutoStats = true
att.Slot = "medic_ubgl"

att.SortOrder = 1738

att.MountPositionOverride = 0

att.UBGL = true
att.UBGL_BaseAnims = true

att.UBGL_PrintName = "UB (MEDIC)"
att.UBGL_Automatic = false
att.UBGL_MuzzleEffect = "muzzleflash_m79"
att.UBGL_ClipSize = 1
att.UBGL_Ammo = "arccw_nade_medic_ubgl"
att.UBGL_RPM = 1200
att.UBGL_Recoil = 2 -- There's a animation error with your hand, please don't notice it ^-^
att.UBGL_Capacity = 1

att.Hook_ShouldNotSight = function(wep)
    return wep:GetInUBGL()
end

local function Ammo(wep)
    return wep.Owner:GetAmmoCount("arccw_nade_medic_ubgl")
end

att.UBGL_Fire = function(wep, ubgl)
    if wep:Clip2() <= 0 then return end

    wep:PlayAnimation("alt_fire_m203", 1, true, nil, nil, nil, true)

    wep:FireRocket("arccw_ubgl_medicgrenade", 1000)

    if wep.MW2_M203isGP25 then
        wep:EmitSound("weapons/fesiugmw2/fire/gp25.wav", 100)
    else
        wep:EmitSound("weapons/fesiugmw2/fire/m203.wav", 100)
    end

    wep:SetClip2(wep:Clip2() - 1)

    wep:DoEffects()
end

att.UBGL_Reload = function(wep, ubgl)
    if wep:Clip2() >= 1 then return end

    if Ammo(wep) <= 0 then return end

    wep:PlayAnimation("alt_reload_m203", 1, true, nil, nil, nil, true)
    wep:SetReloading(CurTime() + wep:GetAnimKeyTime("alt_reload_m203"))

    local reserve = Ammo(wep)

    reserve = reserve + wep:Clip2()

    local clip = 1

    local load = math.Clamp(clip, 0, reserve)

    wep.Owner:SetAmmo(reserve - load, "arccw_nade_medic_ubgl")

    wep:SetClip2(load)
end

att.Mult_SightTime = 1.25
-- att.Mult_SpeedMult = 0.8
att.Mult_SightedSpeedMult = 0.85

ArcCW.LoadAttachmentType(att, "horde_ubgl_medic")