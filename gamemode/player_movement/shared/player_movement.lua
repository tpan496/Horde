
local M_Entity = FindMetaTable("Entity")
local M_Player = FindMetaTable("Player")
local M_CMoveData = FindMetaTable("CMoveData")
local M_Vector = FindMetaTable("Vector")

local E_GetTable = M_Entity.GetTable
local E_GetDTFloat = M_Entity.GetDTFloat
local E_GetDTBool = M_Entity.GetDTBool
local P_GetLegDamage = M_Player.GetLegDamage
local P_GetActiveWeapon = M_Player.GetActiveWeapon
local M_SetVelocity = M_CMoveData.SetVelocity
local M_GetVelocity = M_CMoveData.GetVelocity
local M_SetMaxSpeed = M_CMoveData.SetMaxSpeed
local M_GetMaxSpeed = M_CMoveData.GetMaxSpeed
local M_SetMaxClientSpeed = M_CMoveData.SetMaxClientSpeed
local M_GetMaxClientSpeed = M_CMoveData.GetMaxClientSpeed
local M_GetForwardSpeed = M_CMoveData.GetForwardSpeed
local M_GetSideSpeed = M_CMoveData.GetSideSpeed

-- Start
local P_Team = M_Player.Team
local E_OnGround = M_Entity.OnGround
local E_WaterLevel = M_Entity.WaterLevel
local P_Crouching = M_Player.Crouching
local V_Length2D = M_Vector.Length2D
local V_Length2DSqr = M_Vector.Length2DSqr
local V_LengthSqr = M_Vector.LengthSqr
local P_AnimRestartGesture = M_Player.AnimRestartGesture
local P_AnimRestartMainSequence = M_Player.AnimRestartMainSequence
local P_Alive = M_Player.Alive
-- Finish 

local vel, mul

local DEFAULT_VIEW_OFFSET = Vector(0, 0, 64) -- default
local DEFAULT_VIEW_OFFSET_DUCKED = Vector(0, 0, 32) --modified ( 18 is default? idk)

function GM:Move(pl, move)

	pl:SetViewOffsetDucked(DEFAULT_VIEW_OFFSET_DUCKED)
	pl:SetViewOffset(DEFAULT_VIEW_OFFSET)

	pl:SetHullDuck(Vector(-16, -16, 0),Vector(16, 16, 38))
	pl:SetHull(Vector(-16, -16, 0), Vector(16, 16, 68))

	pl:SetWalkSpeed( 200 )
	pl:SetRunSpeed( 290 ) -- run speed

	pl:SetJumpPower( 210 )
	pl:SetDuckSpeed( 0.31 )
	pl:SetUnDuckSpeed( 0.2 )

end

function GM:FinishMove(pl, move)

	vel = M_GetVelocity(move)
	x_mul = 1.001
	y_mul = 1.001
	z_mul = 1
	vel.x = vel.x * x_mul
	vel.y = vel.y * y_mul
	vel.z = vel.z * z_mul
	M_SetVelocity(move, vel)

end

-- Yeah im really bad, i forgot taunting
function GM:PlayerShouldTaunt(pl, actid)
	pt = E_GetTable(pl)

	return P_Alive(pl) and not P_Team(pl) == TEAM_SPECTATOR
end

function GM:CalcMainActivity(pl, velocity)
	pt = E_GetTable(pl)

	if not P_Team(pl) == TEAM_SPECTATOR then
		if tab.CalcMainActivity then
			ideal, override = tab:CalcMainActivity(pl, velocity)
			if ideal then
				return ideal, override
			end
		end
	end

	-- Handle landing
	onground = E_OnGround(pl)
	if onground and not pt.m_bWasOnGround then
		P_AnimRestartGesture(pl, GESTURE_SLOT_JUMP, ACT_LAND, true)
		pt.m_bWasOnGround = true
	end
	--

	-- Handle jumping
	-- airwalk more like hl2mp, we airwalk until we have 0 velocity, then it's the jump animation
	-- underwater we're alright we airwalking
	waterlevel = E_WaterLevel(pl)
	if pt.m_bJumping then
		if pt.m_bFirstJumpFrame then
			pt.m_bFirstJumpFrame = false
			P_AnimRestartMainSequence(pl)
		end

		if waterlevel >= 2 or CurTime() - pt.m_flJumpStartTime > 0.2 and onground then
			pt.m_bJumping = false
			pt.m_fGroundTime = nil
			P_AnimRestartMainSequence(pl)
		else
			return ACT_MP_JUMP, -1
		end
	elseif not onground and waterlevel <= 0 then
		if not pt.m_fGroundTime then
			pt.m_fGroundTime = CurTime()
		elseif CurTime() > pt.m_fGroundTime and V_Length2D(velocity) < 0.5 then
			pt.m_bJumping = true
			pt.m_bFirstJumpFrame = false
			pt.m_flJumpStartTime = 0
		end
	end
	--

	-- Handle ducking
	if P_Crouching(pl) then
		if V_Length2DSqr(velocity) >= 1 then
			return ACT_MP_CROUCHWALK, -1
		end

		return ACT_MP_CROUCH_IDLE, -1
	end
	--

	-- Handle swimming
	if not onground and waterlevel >= 2 then
		return ACT_MP_SWIM, -1
	end
	--

	len2d = V_Length2DSqr(velocity)
	if len2d >= 22500 then -- 150^2
		return ACT_MP_RUN, -1
	end

	if len2d >= 1 then
		return ACT_MP_WALK, -1
	end

	return ACT_MP_STAND_IDLE, -1
end

