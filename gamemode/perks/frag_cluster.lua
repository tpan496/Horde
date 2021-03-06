PERK.PrintName = "Cluster Bombs"
PERK.Description = "Grenades and SLAMS spawn {amount} {damage}dmg mini-nades on detonation."

PERK.Parameters = {
    ["amount"] = {type = "i", default = 3, min = 1},
    ["damage"] = {type = "i", default = 150, min = 0},
    ["radius"] = {type = "i", default = 400, min = 0},
}

PERK.Hooks = {}
PERK.Hooks.EntityRemoved = function(ent)
    local owner = IsValid(ent) and ent:GetOwner()
    if SERVER and (ent:GetClass() == "npc_grenade_frag" or ent:GetClass() == "npc_satchel" or ent:GetClass() == "npc_tripmine") and IsValid(owner)
            and owner:IsPlayer() and owner:Horde_GetPerk("frag_cluster") then
        local dmg = owner:Horde_GetPerkParam("frag_cluster", "damage")
        local rad = owner:Horde_GetPerkParam("frag_cluster", "radius")
        for i = 1, (owner:Horde_GetPerkParam("frag_cluster", "amount") or 0) do
            local prop = ents.Create("prop_physics")
            prop:SetModel("models/Combine_Helicopter/helicopter_bomb01.mdl")
            prop:SetModelScale(0.25, 0)
            prop:SetPos(ent:GetPos() + VectorRand() * 4 + Vector(0, 0, 8))
            prop:SetAngles(AngleRand())
            prop:SetCollisionGroup(COLLISION_GROUP_WEAPON)
            prop:Spawn()
            prop:Activate()
            timer.Simple(0, function() prop:GetPhysicsObject():AddVelocity(VectorRand() * 300 + Vector(0, 0, 200)) end)
            timer.Simple(0.5 + i * 0.1, function() if IsValid(prop) then
                local e = EffectData()
                e:SetOrigin(prop:GetPos())
                util.Effect("Explosion", e)
                util.BlastDamage(IsValid(owner:GetWeapon("weapon_frag")) and owner:GetWeapon("weapon_frag") or owner:GetWeapon("weapon_slam"), owner, prop:GetPos(), rad, dmg)
                prop:Remove()
            end end)
        end
    end
end