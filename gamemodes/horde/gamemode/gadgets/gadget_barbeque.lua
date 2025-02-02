GADGET.PrintName = "Barbeque"
GADGET.Description =
[[Ignited enemies killed by you drop edible gibs.
Each gib restores 5 health.]]
GADGET.Icon = "items/gadgets/barbeque.png"
GADGET.Duration = 0
GADGET.Cooldown = 0
GADGET.Active = false
GADGET.Params = {}
GADGET.Hooks = {}

GADGET.Hooks.Horde_OnEnemyKilled = function(victim, killer, wpn)
    if killer:Horde_GetGadget() ~= "gadget_barbeque" then return end

    local health = victim:GetMaxHealth()
    for _ = 1, math.min( health / 200, 10 ) do
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
