GADGET.PrintName = "Hellfire Tincture"
GADGET.Icon = "items/gadgets/hellfire_tincture.png"
GADGET.Description =
[[Every second:
- Deals {1} of your max health as Direct damage to you.
- Deals {2} of your max health as Fire damage to EVERYTHING around you.]]

GADGET.Active = true
GADGET.Duration = 5
GADGET.Cooldown = 5
GADGET.Droppable = true

GADGET.Params = {
    [1] = { value = 0.05, percent = true },
    [2] = { value = 0.5, percent = true },
}
GADGET.Hooks = {}

GADGET.Hooks.Horde_UseActiveGadget = function ( ply )
    if CLIENT then return end
    if ply:Horde_GetGadget() ~= "gadget_hellfire_tincture" then return end
    ply:EmitSound( "horde/player/drink.ogg" )

    local id = ply:SteamID()

    timer.Create( "Horde_Hellfire_Tincture" .. id, 1, 5, function ()
        if not ply:IsValid() then
            timer.Remove( "Horde_Hellfire_Tincture" .. id ) return end
        local effectdata = EffectData()
        local pos = ply:GetPos()
        pos.z = pos.z + 15
        effectdata:SetOrigin( pos )
        util.Effect( "m2_flame_explosion", effectdata )

        local radius = 180
        local dmg = DamageInfo()
        local areaharm = ply:GetMaxHealth() * 0.5
        local selfharm = ply:GetMaxHealth() * 0.05

        dmg:SetAttacker( ply )
        dmg:SetInflictor( ply )
        dmg:SetDamageType( DMG_BURN )
        dmg:SetDamage( areaharm )
        util.BlastDamageInfo( dmg, pos, radius )

        if ply:Health() > ( ply:GetMaxHealth() * 0.05 ) then
            ply:SetHealth( ply:Health() - selfharm )
        else
            timer.Remove( "Horde_Hellfire_Tincture" .. id )
            ply:Kill()
        end
    end )
end

GADGET.Hooks.Horde_OnUnsetGadget = function ( ply, gadget )
    if CLIENT then return end
    if gadget ~= "Horde_Hellfire_Tincture" then return end
    local id = ply:SteamID()
    timer.Remove( "Horde_Hellfire_Tincture" .. id )
end