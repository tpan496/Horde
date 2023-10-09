SPELL.PrintName       = "Hallowed Bolt"
SPELL.Weapon          = {"horde_solar_seal"}
SPELL.Mind            = {40}
SPELL.Price           = 1500
SPELL.ChargeTime      = {1}
SPELL.ChargeRelease   = nil
SPELL.Cooldown        = 15
SPELL.Slot            = HORDE.Spell_Slot_Reload
SPELL.DamageType      = nil
SPELL.Icon            = "spells/hallowed_bolt.png"
SPELL.Type            = {HORDE.Spell_Type_AOE}
SPELL.Description     = [[Strikes the target or area with concentrated lightning. Deals heavy Lightning damage in an area.]]
SPELL.Fire            = function (ply, wpn, charge_stage)
    local function LSS(pos, base_damage, e, properties)
        if e:IsValid() and e:IsNPC() then
            pos = e:GetPos()
        end
    
        sound.Play("horde/weapons/solar_seal/hallowed_bolt_hit.ogg", pos, 100, math.random(90, 110), 1)
    
        for i = 1,10 do
            local LT = ents.Create("info_target")
            LT:SetKeyValue("targetname","bolt_target_" .. ply:Name().. "_" .. tostring(i))
            local f = math.random(-125,125)
            local g = math.random(-125,125)
            LT:SetPos(Vector(pos.x + f, pos.y + g, -500))
            LT:Fire("kill","",0.5)
            LT:Spawn()
    
            if i == 5 then
                for _, ent in pairs(ents.FindInSphere(pos, 125)) do
                    if HORDE:IsEnemy(ent) then
                        local dmg2 = DamageInfo()
                        dmg2:SetDamage(base_damage)
                        dmg2:SetDamageType(DMG_SHOCK)
                        dmg2:SetAttacker(ply)
                        dmg2:SetInflictor(wpn)
                        dmg2:SetDamagePosition(ent:GetPos())
                        ent:TakeDamageInfo(dmg2)
                    end
                end
            elseif i == 10 then
                timer.Simple(0.2, function ()
                    if !IsValid(wpn) or !IsValid(ply) then return end
                    for _, ent in pairs(ents.FindInSphere(pos, 125)) do
                        if HORDE:IsEnemy(ent) then
                            local dmg2 = DamageInfo()
                            dmg2:SetDamage(base_damage)
                            dmg2:SetDamageType(DMG_SHOCK)
                            dmg2:SetAttacker(ply)
                            dmg2:SetInflictor(wpn)
                            dmg2:SetDamagePosition(ent:GetPos())
                            ent:TakeDamageInfo(dmg2)
                        end
                    end
                end)
            end
        end
    
        local tr = util.TraceLine({
            start = pos,
            endpos = pos + Vector(0,0,1) * 10000,
            filter = function (ent)
                return ent:IsWorld()
            end,
        })
        
        local z_max = 100
        if tr.Hit then
            z_max = tr.HitPos.z
        else
            z_max = 500
        end
    
        timer.Simple(0.1, function ()
            for i = 1,10 do
                local LA = ents.Create("env_laser")
                LA:SetKeyValue("lasertarget", "bolt_target_" .. ply:Name() .. "_" .. tostring(i))
                LA:SetKeyValue("rendercolor", "255 255 " .. tostring(math.random(200,255)))
                LA:SetKeyValue("texture", "sprites/laserbeam.spr")
                LA:SetKeyValue("dissolvetype", "1")
                LA:SetKeyValue("width", "5")
                LA:SetKeyValue("damage", "0")
                LA:SetKeyValue("spawnflags", "32")
                LA:SetKeyValue("noiseamplitude", "10")
                LA:SetKeyValue("clipstyle", "0")
                LA:SetOwner(wpn)
                LA:Spawn()
                LA:Fire("Kill","",0.5)
                local f = math.random(-25,25)
                local g = math.random(-25,25)
                LA:SetPos(Vector(pos.x + f,pos.y + g,z_max))
            end
        end)
    end


    ply:EmitSound("horde/weapons/solar_seal/hallowed_bolt_launch.ogg", 100, math.random(90, 110))

	local level = ply:Horde_GetSpellUpgrade("hallowed_bolt")

    local bonus = {increase = 0, more = 1}
	hook.Run("Horde_OnPlayerSpellDamage", ply, bonus)
	local base_damage = (300 + math.floor(80 * math.pow(level, 1.2))) * bonus.more * (1 + bonus.increase)

	local tr = ply:GetEyeTrace()
	local param = {}
	hook.Run("Horde_OnGodSlayerCheck", ply, param)

	if param.godslayer == true then
		timer.Simple(0.3, function ()
			local cloud = ents.Create("horde_solar_orb_fire")
			cloud.BaseDamage = 25 + 3 * level
			cloud:SetRadiusScale(1.25)

			if !IsValid(cloud) then return end

			local vel = Vector(math.Rand(-1, 1), math.Rand(-1, 1), math.Rand(-1, 1)) * 1500

			cloud:SetPos(tr.HitPos)
			cloud:SetAbsVelocity(vel + wpn:GetVelocity())
			cloud:SetOwner(ply)
			cloud:Spawn()
		end)
    end

	if tr.Hit then
		local pos = tr.HitPos
		local ent = tr.Entity
		timer.Simple(0.3, function()
			if !IsValid(wpn) then return end
		    LSS(pos, base_damage, ent)
		end)
	end
end
SPELL.Price                      = 1500
SPELL.Upgrades                   = 3
SPELL.Upgrade_Description        = "Increases damage and area of effect."
SPELL.Upgrade_Prices             = function (upgrade_level)
    return 800 + 100 * upgrade_level
end