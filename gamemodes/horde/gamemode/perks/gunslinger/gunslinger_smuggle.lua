PERK.PrintName = "Smuggle"
PERK.Description = [[
You gain extra cash when enemies are killed under Hunter's Mark.
Allows you to open the shop at anytime and anywhere.
Has a 60 seconds cooldown once you opened the smuggler's shop.]]
PERK.Icon = "materials/perks/gunslinger/smuggle.png"
PERK.Params = {
}
PERK.Hooks = {}

PERK.Hooks.Horde_OnGivePlayerReward = function(victim, killer, reward)
    if not IsValid(victim.Horde_Has_Hunter_Mark) then return end
    if not victim.Horde_Has_Hunter_Mark:Horde_GetPerk("gunslinger_smuggle") then return end
    victim.Horde_Has_Hunter_Mark:Horde_AddMoney(HORDE:Round2(reward / 4))
end

PERK.Hooks.Horde_OnSetPerk = function(ply, perk)
    if SERVER and perk == "gunslinger_smuggle" then
        net.Start("Horde_SyncActivePerk")
            net.WriteUInt(HORDE.Status_Smuggle, 8)
            net.WriteUInt(1, 3)
        net.Send(ply)
        ply.Horde_Smuggle_Active = true
    end
end

PERK.Hooks.Horde_OnUnsetPerk = function(ply, perk)
    if SERVER and perk == "gunslinger_smuggle" then
        net.Start("Horde_SyncActivePerk")
            net.WriteUInt(HORDE.Status_Smuggle, 8)
            net.WriteUInt(0, 3)
        net.Send(ply)
        ply.Horde_Smuggle_Active = nil
    end
end

PERK.Hooks.Horde_OnPlayerOpenShop = function (ply)
    if ply:Horde_GetPerk("gunslinger_smuggle") and ply.Horde_Smuggle_Active then
        if HORDE.has_buy_zone and ply:Horde_GetInBuyZone() then
            return
        end
        if HORDE.current_break_time > 0 then
            return
        end
        ply.Horde_Smuggle_Active = nil
        net.Start("Horde_SyncActivePerk")
            net.WriteUInt(HORDE.Status_Smuggle, 8)
            net.WriteUInt(0, 3)
        net.Send(ply)
        timer.Simple(60, function ()
            if ply:IsValid() then
                ply.Horde_Smuggle_Active = true
                net.Start("Horde_SyncActivePerk")
                    net.WriteUInt(HORDE.Status_Smuggle, 8)
                    net.WriteUInt(1, 3)
                net.Send(ply)
            end
        end)
        return true
    end
end