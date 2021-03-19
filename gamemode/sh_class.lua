-- Class
HORDE.classes = {}

-- Creates a Horde class
function HORDE:CreateClass(name, fixed_description, extra_description, max_hp, movespd, sprintspd, perks)
    if name == nil or name == "" then return end
    local class = {}
    class.name = name
    class.fixed_description = fixed_description
    class.extra_description = extra_description
    class.max_hp = max_hp
    class.movespd = movespd
    class.sprintspd = sprintspd
    class.perks = perks
    HORDE.classes[class.name] = class
end
-- Only allow 1 change per wave
HORDE.player_class_changed = {}

function SyncClasses()
    if player then
        for _, ply in pairs(player.GetAll()) do
            net.Start("Horde_SyncClasses")
            net.WriteTable(HORDE.classes)
            net.Send(ply)
        end
    end
end

function HORDE:SetClassData()
    if SERVER then
        if GetConVar("horde_default_class_config"):GetInt() == 1 then return end
        if not file.IsDir("horde", "DATA") then
            file.CreateDir("horde")
        end

        file.Write("horde/class.txt", util.TableToJSON(HORDE.classes))
    end
end

local function GetClassData()
    if SERVER then
        if not file.IsDir("horde", "DATA") then
            file.CreateDir("horde")
            return
        end

        if file.Read("horde/class.txt", "DATA") then
            local t = util.JSONToTable(file.Read("horde/class.txt", "DATA"))

            for _, class in pairs(t) do
                -- Fallback notice
                if class.description then
                    if CLIENT then
                        hook.Add("InitPostEntity", "Horde_Class_Deprecation", function ()
                            timer.Simple(5, function() notification.AddLegacy("Class config descriptions contain deprecated fields! Please reset using !classconfig.", NOTIFY_ERROR, 5) end)
                            timer.Simple(5, function() notification.AddLegacy("Default class descriptions are loaded.", NOTIFY_ERROR, 5) end)
                        end)
                    end
                end
                if class.extra_description then
                    HORDE.classes[class.name].extra_description = class.extra_description
                end
            end
        end
    end
end

local prefix = "horde/gamemode/classes/"
local function Horde_LoadClasses()
    for _, f in ipairs(file.Find(prefix .. "*", "LUA")) do
        PERK = {}
        AddCSLuaFile(prefix .. f)
        include(prefix .. f)
    end
    PERK = nil
end

-- Startup
Horde_LoadClasses()
if SERVER then
    util.AddNetworkString("Horde_SetClassData")

    if GetConVar("horde_default_class_config"):GetInt() == 1 then
        -- Do nothing
    else
        GetClassData()
    end

    SyncClasses()
    
    net.Receive("Horde_SetClassData", function (len, ply)
        if not ply:IsSuperAdmin() then return end
        HORDE.classes = net.ReadTable()
        HORDE:SetClassData()
        SyncClasses()
    end)
end