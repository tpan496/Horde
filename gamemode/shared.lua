GM.Name = "Horde"
GM.Author = "tpan496"
GM.Email = "N/A"
GM.Website = "N/A"

CreateConVar("horde_enable_sandbox", 0, FCVAR_SERVER_CAN_EXECUTE + FCVAR_REPLICATED, "Enables sandbox/cheat features.")
CreateConVar("horde_enable_player_collision", 0, {FCVAR_SERVER_CAN_EXECUTE, FCVAR_REPLICATED}, "Enables player collision.")

DeriveGamemode("sandbox")

function GM:PlayerLoadout(ply) ply:StripWeapons() end

local function CheckAllowHook(hook_name)
    if GetConVar("horde_enable_sandbox"):GetBool() then
        hook.Call(hook_name)
        return true
    else
        return false
    end
end

local function CheckAllowFeature()
    if GetConVar("horde_enable_sandbox"):GetBool() then
        return true
    else
        return false
    end
end

hook.Add("SpawnMenuOpen", "Horde_SpawnMenu", CheckAllowFeature)

--function GM:OnSpawnMenuOpen() return CheckAllowHook("SpawnMenuOpen") end

function GM:ContextMenuOpen() return CheckAllowHook("ContextMenuOpen") end

function GM:PlayerNoClip(ply,desiredState) return CheckAllowFeature() end

function GM:PlayerDeathSound() return true end

--function GM:DrawDeathNotice(x,y) return true end

function GM:PlayerSpawnVehicle(ply,model,name,table) return CheckAllowFeature() end

function GM:PlayerSpawnSWEP(ply,weapon,info) return CheckAllowFeature() end

function GM:PlayerSpawnSENT(ply,class) return CheckAllowFeature() end

function GM:PlayerSpawnRagdoll(ply,model) return CheckAllowFeature() end

function GM:PlayerSpawnProp(ply,model) return CheckAllowFeature() end

function GM:PlayerSpawnObject(ply,model,skin) return CheckAllowFeature() end

function GM:PlayerSpawnNPC(ply,npc_type,weapon) return CheckAllowFeature() end

function GM:PlayerSpawnEffect(ply,model) return CheckAllowFeature() end

function GM:PlayerGiveSWEP(ply,weapon,swep) return CheckAllowFeature() end

function GM:HUDAmmoPickedUp(item, amount) return CheckAllowFeature() end

function GM:ShowTeam(ply) ConfigMenu(ply) end

function GM:ShowSpare1(ply) Shop(ply) end

function GM:ShowSpare2(ply) Ready(ply) end

local groups = {"group01", "group03"}
local sex = {"female", "male"}
local nums = {"_01", "_02", "_03", "_04", "_05", "_06"}

function GM:PlayerSetModel(ply)
    local class = ply:Horde_GetClass()
    if class and class.model and class.model ~= nil then
        return ply:Horde_SetClassModel(class)
    end
    return ply:SetModel("models/player/" .. table.Random(groups) .. "/" .. table.Random(sex) .. table.Random(nums) .. ".mdl")
end

function GM:ShouldCollide(ent1, ent2)
    -- Ulti: Yes, this does prevents bullets from colliding with teammates somehow
    if ent1:IsPlayer() or ent2:IsPlayer() then
        if GetConVar("horde_enable_player_collision"):GetInt() == 0 and ent1:IsPlayer() and ent2:IsPlayer() then return false end
        -- No combine balls
        if ent1:GetClass() == "prop_combine_ball" or ent2:GetClass() == "prop_combine_ball" then return false end
    end

    return true
end