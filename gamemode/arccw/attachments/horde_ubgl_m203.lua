if not ArcCWInstalled then return end

AddCSLuaFile()

local att = {}

att.PrintName = "Grenade Launcher"
att.Icon = Material("entities/acwatt_mw2_ubgl_m203.png", "smooth")
att.Description = "Weapon-exclusive grenade launcher with its own unique animations."
att.Desc_Pros = {
    "pro.ubgl",
}
att.Desc_Cons = {
}
att.Desc_Neutrals = {
    "info.toggleubgl"
}
att.AutoStats = true
att.Slot = "demo_ubgl"

att.SortOrder = 1738

att.MountPositionOverride = 0

att.UBGL = true
att.UBGL_BaseAnims = true

att.UBGL_PrintName = "UB (HE)"
att.UBGL_Automatic = false
att.UBGL_MuzzleEffect = "muzzleflash_m79"
att.UBGL_ClipSize = 1
att.UBGL_Ammo = "smg1_grenade"
att.UBGL_RPM = 1200
att.UBGL_Recoil = 1 -- There's a animation error with your hand, please don't notice it ^-^
att.UBGL_Capacity = 1
att.Free = true

att.AddSuffix = " Grenadier"

att.Hook_ShouldNotSight = function(wep)
    return wep:GetInUBGL()
end

local function Ammo(wep)
    return wep.Owner:GetAmmoCount("smg1_grenade")
end

att.UBGL_Fire = function(wep, ubgl)
    if wep:Clip2() <= 0 then return end

    wep:PlayAnimation("alt_fire_m203", 1, true, nil, nil, nil, true)

    wep:FireRocket("horde_projectile_he_round", 5000)

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

    wep.Owner:SetAmmo(reserve - load, "smg1_grenade")

    wep:SetClip2(load)
end

att.Mult_SightTime = 1.25
-- att.Mult_SpeedMult = 0.8
att.Mult_SightedSpeedMult = 0.85

ArcCW.LoadAttachmentType(att, "horde_ubgl_m203")
