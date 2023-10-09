SPELL.PrintName       = "Supernova"
SPELL.Weapon          = {"horde_astral_relic"}
SPELL.Mind            = {80}
SPELL.ChargeTime      = {5}
SPELL.ChargeRelease   = nil
SPELL.Cooldown        = 60
SPELL.Upgrades        = 3
SPELL.Slot            = HORDE.Spell_Slot_Reload
SPELL.DamageType      = {HORDE.DMG_FIRE, HORDE.DMG_BLAST}
SPELL.Icon            = "spells/supernova.png"
SPELL.Type            = {HORDE.Spell_Type_AOE}
SPELL.Description     = [[Generates a supernova that emits extreme heat and radiation.]]
SPELL.Fire            = function (ply, wpn, charge_stage)
    local tr = ply:GetEyeTrace()
    if not tr.Hit then return end
    local pos = tr.HitPos
    pos.z = pos.z + 100

    local trail = ents.Create( "info_particle_system" )
    trail:SetKeyValue("effect_name", "supernova")
    trail:SetOwner( ply )
    trail:SetPos( pos )
    trail:SetAngles( ply:GetAngles() )
    trail:Spawn()
    trail:Activate()
    trail:Fire( "start", "", 0 )
    trail:Fire("Kill","", 5)

    local level = ply:Horde_GetSpellUpgrade("supernova")
    local bonus = {increase = 0, more = 1}
	hook.Run("Horde_OnPlayerSpellDamage", ply, bonus)
    local base_damage = math.floor(35 + 8 * math.pow(level, 1.2)) * bonus.more * (1 + bonus.increase)
    local base_damage_2 = math.floor(500 + 100 * math.pow(level, 1.2)) * bonus.more * (1 + bonus.increase)

    sound.Play("horde/spells/supernova.ogg", pos, 500, 100, 1, CHAN_AUTO)
    for i = 1, 17 do
        timer.Simple((i-1) * 0.2, function ()
            HORDE:ApplyDamageInRadius(pos, 750, HORDE:DamageInfo(base_damage, DMG_BURN, ply, wpn), function (ent)
            end)
        end)
    end

    local StartLight1 = ents.Create("light_dynamic")
	StartLight1:SetKeyValue("brightness", "6")
	StartLight1:SetKeyValue("distance", "500")
	StartLight1:SetLocalPos(pos)
	StartLight1:SetLocalAngles(  ply:GetAngles()  )
	StartLight1:Fire("Color", "255 75 75")
	StartLight1:SetParent(trail)
	StartLight1:Spawn()
	StartLight1:Activate()
	StartLight1:Fire("TurnOn", "", 0)
	StartLight1:Fire("Kill", "", 4)

    timer.Simple(3, function ()
        local t2 = ents.Create( "info_particle_system" )
        t2:SetKeyValue("effect_name", "supernova_explosion")
        t2:SetOwner( ply )
        t2:SetPos( pos )
        t2:SetAngles( ply:GetAngles() )
        t2:Spawn()
        t2:Activate()
        t2:Fire( "start", "", 0 )
        t2:Fire("Kill","", 1)
        local dmg = DamageInfo()
        dmg:SetAttacker(ply)
        dmg:SetInflictor(wpn)
        dmg:SetDamageType(DMG_BLAST)
        dmg:SetDamage(base_damage_2)
        dmg:SetDamageCustom(HORDE.DMG_PLAYER_FRIENDLY)
        util.BlastDamageInfo(dmg, pos, 850)
    end)
end
SPELL.Price                      = 1500
SPELL.Upgrades                   = 3
SPELL.Upgrade_Description        = "Increases damage."
SPELL.Upgrade_Prices             = function (upgrade_level)
    return 800 + 100 * upgrade_level
end