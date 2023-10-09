PERK.PrintName = "Quickdraw"
PERK.Description = [[
Gain the Quickdraw status while switching weapon.
{1} increased Pistol damage and adds {1} evasion during Quickdraw status.
Quickdraw effect lasts for {2} seconds.]]
PERK.Icon = "materials/perks/gunslinger/quickdraw.png"
PERK.Params = {
    [1] = {value = 0.25, percent = true},
    [2] = {value = 3}, 
}
PERK.Hooks = {}

PERK.Hooks.PlayerSwitchWeapon = function(ply, old_wpn, new_wpn)
    if CLIENT then return end
    if not ply:Horde_GetPerk("gunslinger_quickdraw") then return end
    if old_wpn == new_wpn then return end
    if new_wpn:IsValid() then
        if ply.Horde_In_Quickdraw or ply.Horde_In_Quickdraw_Cooldown then
           return
        end
        ply.Horde_In_Quickdraw = true
        net.Start("Horde_SyncStatus")
            net.WriteUInt(HORDE.Status_Quickdraw, 8)
            net.WriteUInt(1, 8)
        net.Send(ply)
        timer.Simple(3, function ()
            if ply:IsValid() then
                ply.Horde_In_Quickdraw = nil
                net.Start("Horde_SyncStatus")
                    net.WriteUInt(HORDE.Status_Quickdraw, 8)
                    net.WriteUInt(0, 8)
                net.Send(ply)
                ply.Horde_In_Quickdraw_Cooldown = true
                timer.Simple(1, function ()
                    if ply:IsValid() then
                        ply.Horde_In_Quickdraw_Cooldown = nil
                    end
                end)
            end
        end)
    end
end

PERK.Hooks.Horde_OnPlayerDamage = function (ply, npc, bonus, hitgroup, dmginfo)
    if ply.Horde_In_Quickdraw and (HORDE:IsCurrentWeapon(dmginfo, "Pistol") == true) then
        bonus.increase = bonus.increase + 0.25
    end
end

PERK.Hooks.Horde_OnPlayerDamageTaken = function (ply, dmginfo, bonus)
    if ply.Horde_In_Quickdraw then
        bonus.evasion = bonus.evasion + 0.25
    end
end