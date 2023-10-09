PERK.PrintName = "Twin Heart"
PERK.Description =
[[{1} increased maximum health.
Toggle R to recover your health from a synthetic heart.
The heart stores health over time, up to {2} of your maximum health.]]
PERK.Icon = "materials/perks/carcass/twin_heart.png"
PERK.Params = {
    [1] = {value = 0.25, percent = true},
    [2] = {value = 0.3, percent = true},
    --[3] = {value = 30},
}
PERK.Hooks = {}

PERK.Hooks.Horde_OnSetMaxHealth = function(ply, bonus)
    if SERVER and ply:Horde_GetPerk("carcass_twin_heart") then
        bonus.increase = bonus.increase + 0.25
    end
end

PERK.Hooks.Horde_OnSetPerk = function(ply, perk)
    if SERVER and perk == "carcass_twin_heart" then
        ply:Horde_SetPerkCooldown(1)
        ply.Horde_TwinHeartStack = 0
        local id = ply:SteamID()
        timer.Create("Horde_TwinHeartStacking" .. id, 1, 0, function ()
            if !ply:IsValid() then
                timer.Remove("Horde_TwinHeartStacking" .. id)
                return
            end

            if ply.TwinHeartToggleOn == true then return end

            if ply.Horde_TwinHeartStack >= ply:GetMaxHealth() * 0.3 then return end
            
            ply.Horde_TwinHeartStack = math.min(ply:GetMaxHealth() * 0.3, ply.Horde_TwinHeartStack + 1)
            net.Start("Horde_SyncStatus")
                net.WriteUInt(HORDE.Status_Twin_Heart, 8)
                net.WriteUInt(ply.Horde_TwinHeartStack, 8)
            net.Send(ply)
        end)
        ply.TwinHeartToggleOn = false
    end
end

PERK.Hooks.Horde_OnUnsetPerk = function(ply, perk)
    if SERVER and perk == "carcass_twin_heart" then
        net.Start("Horde_SyncStatus")
            net.WriteUInt(HORDE.Status_Twin_Heart, 8)
            net.WriteUInt(0, 8)
        net.Send(ply)
        local id = ply:SteamID()
        timer.Remove("Horde_TwinHeartStacking" .. id)
        ply.Horde_TwinHeartStack = 0
        ply.TwinHeartToggleOn = nil
    end
end

PERK.Hooks.Horde_UseActivePerk = function (ply)
    if not ply:Horde_GetPerk("carcass_twin_heart") then return end
    local active_weapon = ply:GetActiveWeapon()
    if not active_weapon:IsValid() or not active_weapon:GetClass() == "horde_carcass" then return false end
    local res = active_weapon:TwinHeart()
    if res then return true end
end