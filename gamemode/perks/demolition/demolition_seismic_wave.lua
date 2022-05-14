PERK.PrintName = "Seismic Wave"
PERK.Description = [[Explosive projectiles generate an extra delayed explosion on detonation.
Delayed explosion deals {1} explosion damage as Physical damage.]]
PERK.Icon = "materials/perks/seismic_wave.png"
PERK.Params = {
    [1] = {value = 0.3, percent = true},
}

local exp = {obj_vj_law_rocket = 200, obj_vj_rpg_rocket = 100, arccw_he_round = 75, env_explosion = 50, rpg_missile = 50, horde_sticky_bomb = 75}
PERK.Hooks = {}

PERK.Hooks.EntityRemoved = function(ent)
    local owner = ent.Owner
    if SERVER and IsValid(ent) and exp[ent:GetClass()] and IsValid(owner) and owner:IsPlayer() and owner:Horde_GetPerk("demolition_seismic_wave") then
        local dmg = exp[ent:GetClass()]
        local pos = ent:GetPos()
        local attacker = owner
        timer.Simple(0.5, function()
            local bpos = pos + VectorRand()
            local d = DamageInfo()
            d:SetAttacker(attacker)
            d:SetInflictor(attacker)
            d:SetDamageType(DMG_GENERIC)
            d:SetDamage(dmg)
            util.BlastDamageInfo(d, bpos, dmg * 2)
            local e = EffectData()
                e:SetNormal(Vector(0,0,1))
                e:SetOrigin(bpos)
                e:SetRadius(dmg * 2)
            util.Effect("seismic_wave", e, true, true)
        end)
    end
end