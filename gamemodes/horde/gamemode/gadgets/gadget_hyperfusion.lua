GADGET.PrintName = "Hyperfusion"
GADGET.Description =
[[Each weapon infusion now grants an active ability:
- Hemo: 
- Flaming: Gain a burning aura that deals Fire damage around you.
- Arctic: Deals Cold damage to enemies that attack you.
- Galvanizing: Enemies explode on death, dealing Lightning damage based on their health.
- Septic:
- ]]
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
    util.Effect("horde_heal_mist", effectdata)
    ply:EmitSound("arccw_go/smokegrenade/smoke_emit.wav", 90, 100, 1, CHAN_AUTO)

    for _, ent in pairs(ents.FindInSphere(ply:GetPos(), 200)) do
        if ent:IsPlayer() then
            local healinfo = HealInfo:New({amount=20, healer=ply})
            HORDE:OnPlayerHeal(ent, healinfo)
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