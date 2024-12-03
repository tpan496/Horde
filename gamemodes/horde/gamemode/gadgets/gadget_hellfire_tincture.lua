GADGET.PrintName = "Hellfire Tincture"
GADGET.Icon = "items/gadgets/hellfire_tincture.png"
GADGET.Description =
[[Every second:
- Deals {1} of your max health as Fire damage to you.
- Deals {2} of your max health as Fire damage to EVERYONE around you.]]

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
    if CLIENT or ply:Horde_GetGadget() ~= "gadget_hellfire_tincture" then return end
    ply:EmitSound( "horde/player/drink.ogg" )

    local id = ply:SteamID()
    local count = 5
    local damage = ply:GetMaxHealth() * 0.5
    local selfdamage = ply:GetMaxHealth() * 0.05

    timer.Remove( "Horde_Hellfire_Tincture" .. id )
    timer.Create( "Horde_Hellfire_Tincture" .. id, 1, 0, function ()
        HORDE:TakeDamage( ply, selfdamage, DMG_BURN, ply, ply )
        HORDE:ApplyDamageInRadius( ply:GetPos(), 180, HORDE:DamageInfo( damage, DMG_BURN, ply ) )
        count = count - 1
        if not ply:IsValid() or count <= 0 then
            timer.Remove ( "Horde_Hellfire_Tincture" .. id )
            return
        end
    end )
end