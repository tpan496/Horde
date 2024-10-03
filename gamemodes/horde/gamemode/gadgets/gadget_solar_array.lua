GADGET.PrintName = "Solar Array"
GADGET.Description = "Triggers a pulse that gives armor to nearby players.\nRepairs 20 armor."
GADGET.Icon = "items/gadgets/solar_array.png"
GADGET.Duration = 0
GADGET.Cooldown = 10
GADGET.Active = true
GADGET.Params = {
}
GADGET.Hooks = {}


GADGET.Hooks.Horde_UseActiveGadget = function (ply)
    if CLIENT then return end
    if ply:Horde_GetGadget() ~= "gadget_solar_array" then return end
        local effectdata = EffectData()
        effectdata:SetOrigin(ply:GetPos())
        effectdata:SetRadius(225)
        util.Effect("horde_solar_array", effectdata)
        ply:EmitSound("horde/player/life_diffuser.ogg", 100, 100, 1, CHAN_AUTO)

    for _, ent in pairs(ents.FindInSphere(ply:GetPos(), 200)) do
        if ent:IsPlayer() then
            ent:SetArmor(math.min (ent:GetMaxArmor(), ent:Armor() + 20))
        elseif ent:IsNPC() and ent:GetClass() ~= "npc_vj_horde_antlion" then
            local dmg = DamageInfo()
            dmg:SetDamage(65)
            dmg:SetDamageType(DMG_SHOCK)
            dmg:SetAttacker(ply)
            dmg:SetInflictor(ply)
            dmg:SetDamagePosition(ply:GetPos())
            ent:TakeDamageInfo(dmg)
        end
    end
end