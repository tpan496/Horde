GM.Name = "Horde"
GM.Author = "tpan496"
GM.Email = "N/A"
GM.Website = "N/A"

DeriveGamemode("sandbox")

function GM:Initialize()
    game.AddAmmoType({
        name = "arccw_horde_nade_incendiary"
    })
    game.AddAmmoType({
        name = "arccw_horde_nade_molotov"
    })
    game.AddAmmoType({
        name = "arccw_nade_m67"
    })
    game.AddAmmoType({
        name = "arccw_horde_m67"
    })
    game.AddAmmoType({
        name = "arccw_nade_medic_ubgl"
    })
    game.AddAmmoType({
        name = "arccw_nade_knife"
    })
    game.AddAmmoType({
        name = "arccw_horde_nade_stun"
    })
    game.AddAmmoType({
        name = "arccw_horde_nade_nanobot",
    })
    game.AddAmmoType({
        name = "arccw_horde_nade_hemo",
    })
    game.AddAmmoType({
        name = "arccw_horde_nade_shrapnel",
    })
    game.AddAmmoType({
        name = "arccw_horde_nade_sonar",
    })
    game.AddAmmoType({
        name = "arccw_horde_nade_emp",
    })
    game.AddAmmoType({
        name = "horde_mine",
    })
    game.AddAmmoType({
        name = "horde_m2_flamethrower"
    })
    if SERVER then
        HORDE.NPCS = list.Get("NPC")
    end
end

function GM:PlayerLoadout(ply) return true end

hook.Add("SpawnMenuOpen", "Horde_SpawnMenu", function() return false end)

function GM:CanProperty() return false end

function GM:ContextMenuOpen() return false end

function GM:PlayerNoClip(ply,desiredState)
    if SERVER then
        ply:Horde_DropMoney()
    end

    return false
end

function GM:PlayerDeathSound() return true end

--function GM:DrawDeathNotice(x,y) return true end

function GM:PlayerSpawnVehicle(ply,model,name,table) return false end

function GM:PlayerSpawnSWEP(ply,weapon,info) return false end

function GM:PlayerSpawnSENT(ply,class) return false end

function GM:PlayerSpawnRagdoll(ply,model) return false end

function GM:PlayerSpawnProp(ply,model) return false end

function GM:PlayerSpawnObject(ply,model,skin) return false end

function GM:PlayerSpawnNPC(ply,npc_type,weapon) return false end

function GM:PlayerSpawnEffect(ply,model) return false end

function GM:PlayerGiveSWEP(ply,weapon,swep) return false end

function GM:HUDAmmoPickedUp(item, amount) return false end

CreateConVar("horde_disable_f1", 0, FCVAR_ARCHIVE, "Disables F1 hotkey for stats menu.")

if GetConVar("horde_disable_f1"):GetInt() == 0 then
    function GM:ShowHelp(ply)
        StatsMenu(ply)
    end
end

function GM:ShowTeam(ply) ConfigMenu(ply) end

function GM:ShowSpare1(ply)
    if MapVote and MapVote.state and MapVote.state.isInProgress then return end
    Shop(ply)
end

function GM:ShowSpare2(ply) Ready(ply) end

function GM:PlayerSetModel(ply)
    local class = ply:Horde_GetClass()
    if class and class.model and class.model ~= nil then
        ply:Horde_SetClassModel(class)
        return
    end

    player_manager.RunClass( ply, "SetModel" )
end

function GM:ShouldCollide(ent1, ent2)
    -- Ulti: Yes, this does prevents bullets from colliding with teammates somehow
    if ent1:IsPlayer() or ent2:IsPlayer() then
        if ent1:IsPlayer() and ent2:IsPlayer() then return false end
        -- No combine balls
        if ent1:GetClass() == "prop_combine_ball" or ent2:GetClass() == "prop_combine_ball" then return false end
        local res = hook.Run("Horde_ShouldCollide", ent1, ent2)
        if res ~= nil then return res end
    end

    return true
end

function GM:PlayerButtonDown(ply, button)
    if (ply:Horde_GetMaxMind() <= 0) then return end
    if button != KEY_F then return end
    if CLIENT then
		if ( IsFirstTimePredicted() ) then ply.Horde_UseSpellUtlity = true end
	else
		ply.Horde_UseSpellUtlity = true
	end
end

function GM:PlayerButtonUp(ply, button)
    if not IsFirstTimePredicted() then return end
    if (ply:Horde_GetMaxMind() <= 0) then return end
    if button != KEY_F then return end
    ply.Horde_UseSpellUtlity = nil
end
--[[
function GM:SetupWorldFog()
	render.FogMode(1)
	render.FogStart(500)
	render.FogEnd(1000)
	render.FogMaxDensity(1)
	--local col = self:GetFogColor()
	render.FogColor(150,150,150)
	return true
end]]--