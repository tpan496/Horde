GADGET.PrintName = "Gunslinger"
GADGET.Description =
[[25% more Pistol damage.
25% more Pistol headshot damage.]]
GADGET.Icon = "items/gadgets/gunslinger.png"
GADGET.Duration = 0
GADGET.Cooldown = 0
GADGET.Active = false
GADGET.Params = {
    [1] = {value = 0.25},
}
GADGET.Hooks = {}

GADGET.Hooks.Horde_OnSetGadget = function (ply, gadget)
    if CLIENT then return end
end

GADGET.Hooks.Horde_OnUnsetGadget = function (ply, gadget)
    if CLIENT then return end
end

GADGET.Hooks.Horde_OnPlayerDamage = function (ply, npc, bonus, hitgroup, dmginfo)
    if not ply:Horde_GetPerk("gadget_gunslinger") then return end
    local inflictor = dmginfo:GetInflictor()
    if not inflictor:IsValid() then return end
    local item = HORDE.items[inflictor:GetClass()]
    if not item or not (item.category == "Pistol") then
        return
    end
    if hitgroup == HITGROUP_HEAD then
        bonus.more = bonus.more * 1.25
    end
    bonus.more = bonus.more * 1.25
end
