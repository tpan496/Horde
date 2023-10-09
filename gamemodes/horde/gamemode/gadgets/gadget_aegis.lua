GADGET.PrintName = "Aegis"
GADGET.Description = [[Target a player, providing damage and status immunity for {1} seconds.
Targets yourself if no player is targeted.
(Not affected by Accelerated Healing Factor perk.)]]
GADGET.Icon = "items/gadgets/aegis.png"
GADGET.Duration = 0
GADGET.Cooldown = 15
GADGET.Active = true
GADGET.Params = {
    [1] = {value = 2},
}
GADGET.Hooks = {}

GADGET.Hooks.Horde_UseActiveGadget = function (ply)
    if CLIENT then return end
    if ply:Horde_GetGadget() ~= "gadget_aegis" then return end

    local tr = util.TraceHull({
        start = ply:GetShootPos(),
        endpos = ply:GetShootPos() + ply:GetAimVector() * 5000,
        filter = {ply},
        mins = Vector(-16, -16, -8),
        maxs = Vector(16, 16, 8),
        mask = MASK_SHOT_HULL
    })

    local ent = tr.Entity

    if ent:IsValid() and ent:IsPlayer() then
        ent:Horde_SyncStatus(HORDE.Status_Aegis, 1)
        ent:EmitSound("horde/gadgets/aegis.ogg")
        local id = ent:SteamID()
        ent.Horde_Aegis = true
        timer.Remove("Horde_RemoveAegis" .. id)
        timer.Create("Horde_RemoveAegis" .. id, 2, 1, function ()
            ent:Horde_SyncStatus(HORDE.Status_Aegis, 0)
            ent.Horde_Aegis = nil
        end)

        local ed = EffectData()
        ed:SetOrigin(ent:GetPos() + Vector(0,0,50))
        util.Effect("horde_aegis_apply", ed, true, true)
    else
        ply:Horde_SyncStatus(HORDE.Status_Aegis, 1)
        ply:EmitSound("horde/gadgets/aegis.ogg")
        local id = ply:SteamID()
        ply.Horde_Aegis = true
        timer.Remove("Horde_RemoveAegis" .. id)
        timer.Create("Horde_RemoveAegis" .. id, 2, 1, function ()
            ply:Horde_SyncStatus(HORDE.Status_Aegis, 0)
            ply.Horde_Aegis = nil
        end)
        local ed = EffectData()
        ed:SetOrigin(ply:GetPos() + Vector(0,0,50) + ply:GetForward() * 50)
        util.Effect("horde_aegis_apply", ed, true, true)
    end
end

GADGET.Hooks.Horde_OnPlayerDamageTaken = function (ply, dmg, bonus)
    if ply.Horde_Aegis then
        dmg:SetDamage(0)
        return true
    end
end

GADGET.Hooks.Horde_OnPlayerDebuffApply = function (ply, debuff, bonus)
    if ply.Horde_Aegis then
        bonus.apply = 0
        return true
    end
end