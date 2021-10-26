GADGET.PrintName = "Barbeque"
GADGET.Description =
[[Ignited enemies killed by you drop edible gibs.
Each gib restores 5 health.]]
GADGET.Icon = "items/gadgets/barbeque.png"
GADGET.Duration = 0
GADGET.Cooldown = 0
GADGET.Active = false
GADGET.Params = {
    [1] = {value = 5},
}
GADGET.Hooks = {}

GADGET.Hooks.OnNPCKilled = function(victim, killer, wpn)
    if not killer:IsPlayer() or killer:Horde_GetGadget() ~= "gadget_barbeque"  then return end
    if not victim:IsValid() or not victim:IsNPC() or not killer:IsPlayer() or not victim:IsOnFire() then return end
    local health = victim:GetMaxHealth()
    local i = 1
    while health > 0 do
        health = health - 200
        local ent = ents.Create("horde_edible_gib")
        local pos = victim:GetPos()
        local drop_pos = pos
        drop_pos = drop_pos + VectorRand() * 5
        drop_pos.z = pos.z + 15
        ent:SetPos(drop_pos)
        ent.Owner = killer
        ent:Spawn()
    end
end