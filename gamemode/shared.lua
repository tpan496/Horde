GM.Name = "Horde"
GM.Author = "tpan496"
GM.Email = "N/A"
GM.Website = "N/A"

CreateConVar("horde_enable_sandbox", 0, SERVER_CAN_EXECUTE, "Enables sandbox/cheat features.")

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

function GM:PlayerSetModel(ply) return ply:SetModel("models/player/" .. table.Random(groups) .. "/" .. table.Random(sex) .. table.Random(nums) .. ".mdl") end