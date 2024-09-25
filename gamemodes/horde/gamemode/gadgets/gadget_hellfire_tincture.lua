GADGET.PrintName = "Hellfire Tincture"
GADGET.Description = [[
Every second:
- Deals 5% of your max health as damage to you.
- Deals 50% of your max health as Fire damage to enemies near you.]]
GADGET.Icon = "items/gadgets/hellfire_tincture.png"
GADGET.Active = true
GADGET.Duration = 5
GADGET.Cooldown = 5
GADGET.Droppable = true
GADGET.Params = {
    [1] = {value = 0.05, percent = true},
    [2] = {value = 0.5, percent = true},
}
GADGET.Hooks = {}
GADGET.Hooks.Horde_UseActiveGadget = function (ply)
    if CLIENT then return end
    if ply:Horde_GetGadget() ~= "gadget_hellfire_tincture" then return end
    ply:EmitSound("horde/player/drink.ogg")

    local id = ply:SteamID()
    local count = 5
    timer.Remove("Horde_Hellfire_Tincture" .. id)
    timer.Create("Horde_Hellfire_Tincture" .. id, 1, 0, function ()
        if !ply:IsValid() or count <= 1 then timer.Remove("Horde_Hellfire_Tincture" .. id) return end
        HORDE:TakeDamage(ply, 0.05 * ply:GetMaxHealth(), DMG_DIRECT, ply, ply)
        HORDE:ApplyDamageInRadius(ply:GetPos(), 180, HORDE:DamageInfo(ply:GetMaxHealth() * 0.5, DMG_BURN, ply))
        count = count - 1
    end)
end