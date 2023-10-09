PERK.PrintName = "Phantom Reload"
PERK.Description = [[
While Phantom Reload is active, switching Pistol weapons instantly reloads the weapon.
Using Phantom Reload discards the entire magazine.
Phantom Reload has a cooldown of {1} seconds.]]
PERK.Icon = "materials/perks/gunslinger/phantom_reload.png"
PERK.Params = {
    [1] = {value = 3},
}
PERK.Hooks = {}

PERK.Hooks.Horde_OnSetPerk = function(ply, perk)
    if SERVER and perk == "gunslinger_phantom_reload" then
        net.Start("Horde_SyncStatus")
            net.WriteUInt(HORDE.Status_Phantom_Reload, 8)
            net.WriteUInt(1, 3)
        net.Send(ply)
        ply.Horde_Has_Phantom_Reload = true
    end
end

PERK.Hooks.Horde_OnUnsetPerk = function(ply, perk)
    if SERVER and perk == "gunslinger_phantom_reload" then
        net.Start("Horde_SyncStatus")
            net.WriteUInt(HORDE.Status_Phantom_Reload, 8)
            net.WriteUInt(0, 3)
        net.Send(ply)
        ply.Horde_Has_Phantom_Reload = nil
    end
end

PERK.Hooks.PlayerSwitchWeapon = function(ply, old_wpn, new_wpn)
    if CLIENT then return end
    if not ply:Horde_GetPerk("gunslinger_phantom_reload") then return end
    if old_wpn == new_wpn then return end
    if new_wpn:IsValid() and HORDE:IsPistolItem(new_wpn:GetClass()) then
        if not ply.Horde_Has_Phantom_Reload then
           return
        end
        if new_wpn:GetMaxClip1() == new_wpn:Clip1() and new_wpn:GetMaxClip2() == new_wpn:Clip2() then return end
        sound.Play("weapons/357/357_spin1.wav", ply:GetPos())
        local count1 = ply:GetAmmoCount(new_wpn:GetPrimaryAmmoType())
        local count2 = ply:GetAmmoCount(new_wpn:GetSecondaryAmmoType())
        local give1 = math.min(count1, new_wpn:GetMaxClip1())
        local give2 = math.min(count2, new_wpn:GetMaxClip2())
        ply:RemoveAmmo(give1, new_wpn:GetPrimaryAmmoType())
        ply:RemoveAmmo(give2, new_wpn:GetSecondaryAmmoType())
        new_wpn:SetClip1(give1)
        new_wpn:SetClip2(give2)
        ply.Horde_Has_Phantom_Reload = nil
        net.Start("Horde_SyncStatus")
            net.WriteUInt(HORDE.Status_Phantom_Reload, 8)
            net.WriteUInt(0, 8)
        net.Send(ply)
        timer.Simple(3, function ()
            if ply:IsValid() then
                net.Start("Horde_SyncStatus")
                    net.WriteUInt(HORDE.Status_Phantom_Reload, 8)
                    net.WriteUInt(1, 8)
                net.Send(ply)
                ply.Horde_Has_Phantom_Reload = true
            end
        end)
    end
end