GADGET.PrintName = "Aegis"
GADGET.Description = [[Provides damage and status immunity for {1} seconds in an area.]]
GADGET.Icon = "items/gadgets/aegis.png"
GADGET.Duration = 0
GADGET.Cooldown = 30
GADGET.Active = true
GADGET.Params = {
    [1] = {value = 3},
}
GADGET.Hooks = {}

GADGET.Hooks.Horde_UseActiveGadget = function (ply)
    if CLIENT or ply:Horde_GetGadget() ~= "gadget_aegis" then return end

    -- Emit sound and create visual effect at the player's position
    ply:EmitSound("horde/gadgets/aegis.ogg")
    local effectdata = EffectData()
    effectdata:SetOrigin(ply:GetPos())
    effectdata:SetRadius(225)
    util.Effect("horde_aegis_apply", effectdata)

    -- Apply Aegis buff to nearby players
    for _, ent in pairs(ents.FindInSphere(ply:GetPos(), 200)) do
        if ent:IsPlayer() then
            ent:Horde_SyncStatus(HORDE.Status_Aegis, 1)
            local id = ent:SteamID()
            ent.Horde_Aegis = true

            -- Remove the Aegis buff after 2 seconds
            timer.Remove("Horde_RemoveAegis" .. id)
            timer.Create("Horde_RemoveAegis" .. id, 3, 1, function ()
                if IsValid(ent) then
                    ent:Horde_SyncStatus(HORDE.Status_Aegis, 0)
                    ent.Horde_Aegis = nil
                end
            end)
        end
    end
end