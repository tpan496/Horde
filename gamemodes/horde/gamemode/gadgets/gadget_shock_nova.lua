GADGET.PrintName = "Shock Nova"
GADGET.Description =
[[Warden Aura rapidly generates a series of shockwaves.
Each shockwave deals 50 Lightning damage.]]
GADGET.Icon = "items/gadgets/shock_nova.png"
GADGET.Duration = 5
GADGET.Cooldown = 10
GADGET.Active = true
GADGET.Params = {
}
GADGET.Hooks = {}

GADGET.Hooks.Horde_UseActiveGadget = function (ply)
    if CLIENT then return end
    if ply:Horde_GetGadget() ~= "gadget_shock_nova" then return end
    local id = ply:SteamID()
    timer.Create("Horde_Shock_Nova_Effect" .. id, 0.25, 5, function ()
        if not ply:IsValid() then timer.Remove("Horde_Shock_Nova_Effect" .. id) return end
        local effectdata = EffectData()
        local pos = ply:GetPos()
        pos.z = pos.z + 15
        effectdata:SetOrigin(pos)
        util.Effect("explosion_shock", effectdata)
        local radius = ply:Horde_GetWardenAuraRadius()
        local dmg = DamageInfo()
        dmg:SetAttacker(ply)
        dmg:SetInflictor(ply)
        dmg:SetDamageType(DMG_SHOCK)
        dmg:SetDamage(50)
        util.BlastDamageInfo(dmg, pos, radius)
    end)
end

GADGET.Hooks.Horde_OnUnsetGadget = function (ply, gadget)
    if CLIENT then return end
    if gadget ~= "gadget_shock_nova" then return end
    local id = ply:SteamID()
    timer.Remove("Horde_Shock_Nova_Effect" .. id)
end