PERK.PrintName = "Pressure Blast"
PERK.Description = "Grenades and SLAMs do an extra blast with 200 dmg in 400 HU."

local exp = {npc_grenade_frag = true, npc_satchel = true, npc_tripmine = true}
PERK.Hooks = {}
PERK.Hooks.EntityRemoved = function(ent)
    local owner = ent:GetInternalVariable("m_hThrower")
    if not owner then ent = ent:GetInternalVariable("m_hOwner") end
    if SERVER and IsValid(ent) and exp[ent:GetClass()] and IsValid(owner)
            and owner:IsPlayer() and owner:Horde_GetPerk("frag_double") then
        local dmg = 200
        local rad = 400
        local pos = ent:GetPos()
        local wpn = ent:GetClass() == "npc_grenade_frag" and owner:GetWeapon("weapon_frag") or owner:GetWeapon("weapon_slam")
        timer.Simple(0.08, function()
            local e = EffectData()
            e:SetOrigin(pos)
            util.Effect("Explosion", e)
            util.BlastDamage(wpn, owner, pos, rad, dmg)
        end)
    end
end