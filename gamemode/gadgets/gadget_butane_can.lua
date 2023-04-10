GADGET.PrintName = "Butane Can"
GADGET.Description = "Drops a Butane Can that explodes on physical impact.\nExplosion deals 375 Fire damage.\nOnly 1 Butane Can can be spawned at a time."
GADGET.Icon = "items/gadgets/butane_can.png"
GADGET.Duration = 0
GADGET.Cooldown = 20
GADGET.Active = true
GADGET.Params = {
    [1] = {value = 375},
}
GADGET.Hooks = {}

GADGET.Hooks.Horde_UseActiveGadget = function (ply)
    if CLIENT then return end
    if ply:Horde_GetGadget() ~= "gadget_butane_can" then return end
    if ply.Horde_Butane_Can and ply.Horde_Butane_Can:IsValid() then
        ply.Horde_Butane_Can:Remove()
        ply.Horde_Butane_Can = nil
    end
    local ent = ents.Create("prop_physics")
    local pos = ply:EyePos()
    local dir = ply:GetAimVector()
    local drop_pos = pos + dir * 50
    drop_pos.z = pos.z
    ent:SetPos(drop_pos)
    ent:SetAngles(Angle(0, ply:GetAngles().y, 0))
    ent:SetModel("models/props_c17/oildrum001_explosive.mdl")
    ent:Spawn()
    ply.Horde_Butane_Can = ent
end

GADGET.Hooks.Horde_OnPlayerDamage = function (ply, npc, bonus, hitgroup, dmginfo)
    if ply:Horde_GetGadget() ~= "gadget_butane_can" then return end
    if dmginfo:GetInflictor():GetModel() == "models/props_c17/oildrum001_explosive.mdl" then
        bonus.increase = bonus.increase + 10.0
        dmginfo:SetDamageType(DMG_BURN)
    end
end
