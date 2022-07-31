GADGET.PrintName = "Volatile Body"
GADGET.Description =
[[Creates a large explosion when your health depletes.
Explosion deals 5000 damage.]]
GADGET.Icon = "items/gadgets/volatile_body.png"
GADGET.Duration = 0
GADGET.Cooldown = 0
GADGET.Active = false
GADGET.Params = {
    [1] = {value = 5},
}
GADGET.Hooks = {}

GADGET.Hooks.Horde_OnSetGadget = function (ply, gadget)
    if CLIENT then return end
    if gadget ~= "gadget_t_virus" then return end
    local id = ply:SteamID()
    timer.Create("Horde_T_Virus_Effect" .. id, 1, 0, function ()
        if not ply:IsValid() then timer.Remove("Horde_T_Virus_Effect" .. id) return end
        if ply:Armor() > 0 then
            ply:SetHealth(math.min(ply:GetMaxHealth() * 2.5, ply:Health() + ply:Armor()))
            ply:SetArmor(0)
        end
    end)
end

GADGET.Hooks.Horde_OnUnsetGadget = function (ply, gadget)
    if CLIENT then return end
    if gadget ~= "gadget_t_virus" then return end
    local id = ply:SteamID()
    timer.Remove("Horde_T_Virus_Effect" .. id)
    ply:SetHealth(ply:GetMaxHealth())
end