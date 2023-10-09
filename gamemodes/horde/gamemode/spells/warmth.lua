SPELL.PrintName       = "Warmth"
SPELL.Weapon          = {"horde_solar_seal"}
SPELL.Mind            = {10}
SPELL.Price           = 0
SPELL.ChargeTime      = {0}
SPELL.ChargeRelease   = true
SPELL.Cooldown        = 12
SPELL.Slot            = HORDE.Spell_Slot_Utility
SPELL.DamageType      = nil
SPELL.Icon            = "spells/warmth.png"
SPELL.Type            = {HORDE.Spell_Type_Utility}
SPELL.Description     = [[Heals players nearby and provides a faint light.]]
SPELL.Fire            = function (ply, wpn, charge_stage)
    ply:EmitSound("horde/spells/warmth.ogg")
    local pos = ply:GetPos()
    pos.z = pos.z + 50

    local light = ents.Create("light_dynamic")
	light:SetKeyValue("brightness", "4")
	light:SetKeyValue("distance", "250")
	light:SetLocalPos(pos)
	light:SetLocalAngles( ply:EyeAngles() )
	light:Fire("Color", "255 255 200")
	light:Spawn()
	light:Activate()
	light:Fire("TurnOn", "", 0)
    light:Fire("Kill", "", 5)

    local heal_amount = 3
    ParticleEffect("solar_orb_warmth", pos, Angle(0,0,0), nil)
    timer.Simple(2, function ()
        ParticleEffect("solar_orb_warmth", pos, Angle(0,0,0), nil)
    end)
    local owner = ply
    for i = 1, 10 do
        timer.Simple((i-1) * 0.5, function ()
            if !owner:IsValid() then return end
            for _, ent in pairs(ents.FindInSphere(pos, 150)) do
                if ent:IsPlayer() then
                    local healinfo = HealInfo:New({amount=heal_amount, healer=owner})
                    HORDE:OnPlayerHeal(ent, healinfo)
                end
            end
        end)
    end
end
SPELL.Price = 750