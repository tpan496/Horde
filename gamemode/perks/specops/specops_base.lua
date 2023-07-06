PERK.PrintName = "SpecOps Base"
PERK.Description = [[
The SpecOps class focuses on the effects of its unique Tactical Mode.
COMPLEXITY: MEDIUM

Press F to enter Tactical Mode, replacing your flashlight.
You have Nightvision during Tactical Mode.
Cannot run during Tactical Mode.
50% reduced movement speed during Tactical Mode.

{1} more movement speed during Tactical Mode. ({2} per level, up to {3})
{1} increased headshot damage during Tactical Mode. ({2} per level, up to {3})]]
PERK.Icon = "materials/subclasses/specops.png"
PERK.Params = {
    [1] = {percent = true, base = 0, level = 0.01, max = 0.25, classname = "SpecOps"},
    [2] = {value = 0.01, percent = true},
    [3] = {value = 0.25, percent = true},
}

PERK.Hooks = {}

PERK.Hooks.Horde_PrecomputePerkLevelBonus = function (ply)
    if SERVER then
        ply:Horde_SetPerkLevelBonus("specops_base", math.min(0.25, 0.01 * ply:Horde_GetLevel("SpecOps")))
    end
end

PERK.Hooks.PlayerSwitchFlashlight = function (ply, switchOn)
    if not ply:Horde_GetPerk("specops_base") then return end
    if switchOn then
        -- Enable tactical mode
        net.Start("Horde_SyncStatus")
            net.WriteUInt(HORDE.Status_Tactical_Mode, 8)
            net.WriteUInt(1, 8)
        net.Send(ply)
        ply.Horde_In_Tactical_Mode = true
        if ply:Horde_GetPerk("specops_biotic_mask") then
            ply:Horde_SetHealthRegenPercentage(0.02)
        end

        if ply:Horde_GetPerk("specops_neuron_stabilizer") then
            ply:Horde_SetNeuronStabilizerEnabled(true)
        end
    else
        -- Disable tactical mode
        net.Start("Horde_SyncStatus")
            net.WriteUInt(HORDE.Status_Tactical_Mode, 8)
            net.WriteUInt(0, 8)
        net.Send(ply)
        ply.Horde_In_Tactical_Mode = nil
        ply:Horde_SetHealthRegenPercentage(0)

        if ply:Horde_GetPerk("specops_neuron_stabilizer") then
            ply:Horde_SetNeuronStabilizerEnabled(nil)
        end
    end
end

PERK.Hooks.Horde_OnPlayerDamage = function (ply, npc, bonus, hitgroup, dmginfo)
    if not ply:Horde_GetPerk("specops_base") then return end
    if ply.Horde_In_Tactical_Mode and hitgroup == HITGROUP_HEAD then
        bonus.increase = bonus.increase + ply:Horde_GetPerkLevelBonus("specops_base")
    end
end

PERK.Hooks.Horde_PlayerMoveBonus = function(ply, bonus_walk, bonus_run)
    if not ply:Horde_GetPerk("specops_base") then return end
    if ply.Horde_In_Tactical_Mode then
        local b = ply:Horde_GetPerkLevelBonus("specops_base")
        if ply:Horde_GetPerk("specops_night_stalker") then
            bonus_walk.more = 1.2 * bonus_walk.more * (0.5 + b)
            bonus_run.more = 1.2 * 0.8 * (0.5 + b) * bonus_run.more
        else
            bonus_walk.more = bonus_walk.more * (0.5 + b)
            bonus_run.more = 0.8 * (0.5 + b) * bonus_run.more
        end
    end
end

local function nv_color()
	return Color(120, 255, 120, 255)
end

local function nv_center(ent)
	return ent:LocalToWorld(ent:OBBCenter())
end

local function nv_posvisible(pos)
	if pos.x < 50 then return false end
	if pos.x > ScrW() - 50 then return false end
	if pos.y < 50 then return false end
	if pos.y > ScrH() - 50 then return false end
	
	return true
end

local function nv_unitstofeat(units)
    units = units + (units*0.25)
    units = math.floor(units / 12)
	return units
end

local function nv_cansee(ent)
	local tracedata = {}
	tracedata.start = MySelf:GetShootPos()
	tracedata.endpos = nv_center(ent)
	tracedata.filter = {ent, MySelf}
	local trace = util.TraceLine(tracedata)
	if trace.Hit then
		return false
	end
	
	return true
end

local function nv_ents()
	local entities = {}

	for k, v in pairs(ents.FindInSphere(MySelf:GetPos(), 1000)) do
        if v:Health() > 0 and (v:IsPlayer() or v:IsNPC()) then
		    table.insert(entities, v)
        end
	end

	return entities
end

PERK.Hooks.Think = function()
    if SERVER then return end
    local ply = MySelf
    if not ply.Horde_StatusTable then return end
	if not ply.Horde_StatusTable[HORDE.Status_Tactical_Mode] then return end
    local light = DynamicLight(0)
    if (light) then
        light.Pos = MySelf:GetPos() + Vector(0,0,30)
        light.r = nv_color().r
        light.g = nv_color().g
        light.b = nv_color().b
        light.Brightness = 1
        light.Size = 750
        light.Decay = 750 * 5
        light.DieTime = CurTime() + 0.1
    end
end

PERK.Hooks.HUDPaint = function()
    local ply = MySelf
    if not ply.Horde_StatusTable then return end
	if ply.Horde_StatusTable[HORDE.Status_Tactical_Mode] then
		surface.SetDrawColor(Color(nv_color().r,nv_color().g,nv_color().b,math.random(255)))
		
		for k, v in pairs(nv_ents()) do
			--if nv_cansee(v) then
				local pos = nv_center(v):ToScreen()
				
				if nv_posvisible(pos) then
                    surface.DrawCircle(pos.x, pos.y, 30)
					--surface.DrawLine(pos.x, 0, pos.x, ScrH())
					--surface.DrawLine(0, pos.y, ScrW(), pos.y)
					draw.DrawText(v:Health(), "Trebuchet24",
					pos.x - 15, pos.y - 15, nv_color(), TEXT_ALIGN_LEFT)
				end
			--end
		end

		draw.DrawText("T a c t i c a l V i s i o n", "ChatFont",
		ScrW() / 2, ScrH() - 50, nv_color(), TEXT_ALIGN_CENTER)
	end
end