GADGET.PrintName = "Emergency Reload"
GADGET.Description = [[Active Gadget:
Instantly reloads your held weapon to maximum magazine capacity.
Also instantly reloads any secondary attachments to maximum magazine capacity.]]
GADGET.Icon = "materials/perks/overlord/emergency_reload.png"
GADGET.Duration = 0
GADGET.Cooldown = 30
GADGET.Active = true
GADGET.Params = {
    [1] = {value = 0.66, percent = true},
}
GADGET.Hooks = {}

GADGET.Hooks.Horde_UseActiveGadget = function (ply)
    if CLIENT then return end
    if ply:Horde_GetGadget() ~= "gadget_emergency_reload" then return end
    local wpn = HORDE:GetCurrentWeapon(ply)
    local count1 = ply:GetAmmoCount(wpn:GetPrimaryAmmoType())
    local count2 = ply:GetAmmoCount(wpn:GetSecondaryAmmoType())
    if not wpn:IsValid() then return true end
    if (wpn:Clip1() >= wpn:GetMaxClip1() or count1 <= 0) and (wpn:Clip2() >= wpn:GetMaxClip2() or wpn:GetSecondaryAmmoType() == -1 or count2 <= 0) then return true end
    if wpn:Clip1() < wpn:GetMaxClip1() then
        local give1 = math.min(count1, wpn:GetMaxClip1() - wpn:Clip1())
        ply:RemoveAmmo(give1, wpn:GetPrimaryAmmoType())
        wpn:SetClip1(wpn:Clip1() + give1)
    end
    
    if wpn:Clip2() < wpn:GetMaxClip2() then
        local give2 = math.min(count2, wpn:GetMaxClip2() - wpn:Clip2())
        ply:RemoveAmmo(give2, wpn:GetSecondaryAmmoType())
        wpn:SetClip2(wpn:Clip2() + give2)
    end
    sound.Play("weapons/shotgun/shotgun_cock.wav", ply:GetPos())
end
