-- Class
HORDE.classes = {}
HORDE.order_to_class_name = {}
HORDE.Class_Survivor = "Survivor"
HORDE.Class_Assault = "Assault"
HORDE.Class_Heavy = "Heavy"
HORDE.Class_Medic = "Medic"
HORDE.Class_Demolition = "Demolition"
HORDE.Class_Ghost = "Ghost"
HORDE.Class_Engineer = "Engineer"
HORDE.Class_Berserker = "Berserker"

-- Creates a Horde class
function HORDE:CreateClass(name, extra_description, max_hp, movespd, sprintspd, base_perk, perks, order, display_name, model, icon)
    if name == nil or name == "" then return end
    local class = {}
    class.name = name
    class.extra_description = extra_description
    class.max_hp = max_hp
    class.movespd = movespd
    class.sprintspd = sprintspd
    class.base_perk = base_perk
    class.perks = perks
    class.order = order
    class.display_name = display_name or name
    class.model = model or nil
    class.icon = icon or (class.name .. ".png")
    HORDE.order_to_class_name[class.order] = class.name
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
                if class.display_name then
                    HORDE.classes[class.name].display_name = class.display_name
                end
                if class.extra_description then
                    HORDE.classes[class.name].extra_description = class.extra_description
                end
                if class.model then
                    HORDE.classes[class.name].model = class.model
                end
                if class.base_perk then
                    HORDE.classes[class.name].base_perk = class.base_perk
                end
                if class.perks then
                    HORDE.classes[class.name].perks = class.perks
                end
                if class.icon then
                    HORDE.classes[class.name].icon = class.icon
                end
            end
        end
    end
end

function HORDE:GetDefaultClassesData()
    HORDE:CreateClass(
        HORDE.Class_Survivor,
        "Have access to all weapons except for exclusive and special weapons.\n\nLimited access to attachments.",
        100,
        GetConVar("horde_base_walkspeed"):GetInt(),
        GetConVar("horde_base_runspeed"):GetInt(),
        "survivor_base",
        {
            [1] = {title = "Survival", choices = {"medic_antibiotics", "assault_charge"}},
            [2] = {title = "Improvise", choices = {"berserker_breathing_technique", "demolition_frag_cluster"}},
            [3] = {title = "Inspired Learning", choices = {"heavy_liquid_armor", "ghost_headhunter"}},
        },
        0
    )

    HORDE:CreateClass(
        HORDE.Class_Assault,
        "Have full access to Assault Rifles.",
        100,
        GetConVar("horde_base_walkspeed"):GetInt(),
        GetConVar("horde_base_runspeed"):GetInt(),
        "assault_base",
        {
            [1] = {title = "Maneuverability", choices = {"assault_ambush", "assault_charge"}},
            [2] = {title = "Adaptability", choices = {"assault_drain", "assault_overclock"}},
            [3] = {title = "Conditioning", choices = {"assault_heightened_reflex", "assault_cardiac_overload"}},
        },
        1
    )

    HORDE:CreateClass(
        HORDE.Class_Heavy,
        "Have full access to Machine Guns and high weight weapons.",
        100,
        GetConVar("horde_base_walkspeed"):GetInt(),
        GetConVar("horde_base_runspeed"):GetInt(),
        "heavy_base",
        {
            [1] = {title = "Suppression", choices = {"heavy_sticky_compound", "heavy_crude_casing"}},
            [2] = {title = "Armor Protection", choices = {"heavy_liquid_armor", "heavy_reactive_armor"}},
            [3] = {title = "Technology", choices = {"heavy_nanomachine", "heavy_ballistic_shock"}},
        },
        2
    )

    HORDE:CreateClass(
        HORDE.Class_Medic,
        "Have acesss to most light weapons and medical tools.",
        100,
        GetConVar("horde_base_walkspeed"):GetInt(),
        GetConVar("horde_base_runspeed"):GetInt(),
        "medic_base",
        {
            [1] = {title = "Medicine", choices = {"medic_antibiotics", "medic_painkillers"}},
            [2] = {title = "Bio-Engineering", choices = {"medic_berserk", "medic_fortify"}},
            [3] = {title = "Natural Selection", choices = {"medic_cellular_implosion", "medic_xcele"}},
        },
        3
    )

    HORDE:CreateClass(
        HORDE.Class_Demolition,
        "Have full access to explosive weapons.",
        100,
        GetConVar("horde_base_walkspeed"):GetInt(),
        GetConVar("horde_base_runspeed"):GetInt(),
        "demolition_base",
        {
            [1] = {title = "Grenade", choices = {"demolition_frag_impact", "demolition_frag_cluster"}},
            [2] = {title = "Approach", choices = {"demolition_fragmentation", "demolition_napalm"}},
            [3] = {title = "Destruction", choices = {"demolition_pressurized_warhead", "demolition_chain_reaction"}},
        },
        4
    )

    HORDE:CreateClass(
        HORDE.Class_Ghost,
        "Have access to sniper rifles and selected light weapons.\n\nHave access to suppressors and sniper scopes.",
        100,
        GetConVar("horde_base_walkspeed"):GetInt(),
        GetConVar("horde_base_runspeed"):GetInt(),
        "ghost_base",
        {
            [1] = {title = "Tactics", choices = {"ghost_headhunter", "ghost_sniper"}},
            [2] = {title = "Reposition", choices = {"ghost_phase_walk", "ghost_ghost_veil"}},
            [3] = {title = "Disposal", choices = {"ghost_coup", "ghost_decapitate"}},
        },
        5
    )

    HORDE:CreateClass(
        HORDE.Class_Engineer,
        "Have access to special weapons and equipment.",
        100,
        GetConVar("horde_base_walkspeed"):GetInt(),
        GetConVar("horde_base_runspeed"):GetInt(),
        "engineer_base",
        {
            [1] = {title = "Craftsmanship", choices = {"engineer_tinkerer", "engineer_manhack"}},
            [2] = {title = "Archetype", choices = {"engineer_golem", "engineer_spectre"}},
            [3] = {title = "Experimental", choices = {"engineer_symbiosis", "engineer_kamikaze"}},
        },
        6
    )

    HORDE:CreateClass(
        HORDE.Class_Berserker,
        "Only has access to melee weapons.",
        100,
        GetConVar("horde_base_walkspeed"):GetInt(),
        GetConVar("horde_base_runspeed"):GetInt(),
        "berserker_base",
        {
            [1] = {title = "Fundamentals", choices = {"berserker_breathing_technique", "berserker_bloodlust"}},
            [2] = {title = "Technique", choices = {"berserker_bushido", "berserker_savagery"}},
            [3] = {title = "Combat Arts", choices = {"berserker_mindeye", "berserker_rip_and_tear"}},
        },
        7
    )
end

-- TODO: Should we support adding custom classes?
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
    HORDE:GetDefaultClassesData()
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