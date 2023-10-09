GADGET.PrintName = "Bio Diffuser"
GADGET.Description = "Triggers a pulse that heals nearby players.\nHeals 20 health."
GADGET.Icon = "items/gadgets/life_diffuser.png"
GADGET.Duration = 0
GADGET.Cooldown = 8
GADGET.Active = true
GADGET.Params = {
}
GADGET.Hooks = {}

GADGET.Hooks.Horde_UseActiveGadget = function (ply)
    if CLIENT then return end
    if ply:Horde_GetGadget() ~= "gadget_life_diffuser" then return end
    local effectdata = EffectData()
    effectdata:SetOrigin(ply:GetPos())
    effectdata:SetRadius(225)
    util.Effect("horde_life_diffuser", effectdata)
    ply:EmitSound("horde/player/life_diffuser.ogg", 100, 100, 1, CHAN_AUTO)

    for _, ent in pairs(ents.FindInSphere(ply:GetPos(), 200)) do
        if ent:IsPlayer() then
            local healinfo = HealInfo:New({amount=20, healer=ply})
            HORDE:OnPlayerHeal(ent, healinfo)
        elseif ent:GetClass() == "npc_vj_horde_antlion" then
            local healinfo = HealInfo:New({amount=20, healer=ply})
            HORDE:OnAntlionHeal(ent, healinfo)
        elseif ent:IsNPC() then
            local dmg = DamageInfo()
            dmg:SetDamage(65)
            dmg:SetDamageType(DMG_NERVEGAS)
            dmg:SetAttacker(ply)
            dmg:SetInflictor(ply)
            dmg:SetDamagePosition(ply:GetPos())
            ent:TakeDamageInfo(dmg)
        end
    end
end