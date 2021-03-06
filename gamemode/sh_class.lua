-- Class
HORDE.classes = {}
HORDE.CreateClass = function(name, fixed_description, extra_description, max_hp, movespd, sprintspd, perks)
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

HORDE.CreateClasses = function()
    HORDE.CreateClass(
        "Survivor",
        "No bonus.\n\n",
        "Have access to all weapons except for special weapons.\n\nLimited access to attachments.",
        100,
        GetConVar("horde_base_walkspeed"):GetInt(),
        GetConVar("horde_base_runspeed"):GetInt(),
        {L = "25% less damage taken.",
        R = "25% increased damage."}
    )

    HORDE.CreateClass(
        "Medic",
        "Regenerate 2% health per second.\n\n",
        "Have partial access to Rifles and most light weapons.",
        100,
        GetConVar("horde_base_walkspeed"):GetInt(),
        GetConVar("horde_base_runspeed"):GetInt(),
        {L = "50% increased maximum health.",
        R = "Adds 25 Poison damage to each attack."}
    )

    HORDE.CreateClass(
        "Demolition",
        "75% less explosive damage taken.\n\nRegenerate 1 frag grenade every 30 seconds, if you do not have one.\n\n",
        "Have full access to Explosive weapons.",
        100,
        GetConVar("horde_base_walkspeed"):GetInt(),
        GetConVar("horde_base_runspeed"):GetInt(),
        {L = "50% increased explosive damage",
        R = "Enemies you kill explode,\ndealing (100 + 10% of their health) as AOE damage."}
    )

    HORDE.CreateClass(
        "Assault",
        "25% increased movement speed.\n\n",
        "Have full access to Rifles.",
        100,
        GetConVar("horde_base_walkspeed"):GetInt() * 1.25,
        GetConVar("horde_base_runspeed"):GetInt() * 1.25,
        {L = "25% chance to not consume ammo while firing.",
        R = "Each enemy you kill grants you 1 Frenzy charge.\nEach frenzy charge increases your damage and movespeed by 6%."}
    )

    HORDE.CreateClass(
        "Heavy",
        "+5 to maximum carrying capacity.\n\nRegenerate 1 armor per second, up to 25.\n\n",
        "Have full access to Machine Guns and heavier weapons.",
        100,
        GetConVar("horde_base_walkspeed"):GetInt(),
        GetConVar("horde_base_runspeed"):GetInt(),
        {L = "Damage does not bypass Armor.",
        R = "Enemies you hit are Pressured for 1 second.\nPressured enemies deal 25% less damage and take 25% increased damage."}
    )

    HORDE.CreateClass(
        "Ghost",
        "50% increased headshot damage.\n\n",
        "Increased headshot damage applies to headshot-immune enemies.\n\nHave access to sniper rifles and selected light weapons.\n\nHave access to suppressors and sniper scopes.",
        100,
        GetConVar("horde_base_walkspeed"):GetInt(),
        GetConVar("horde_base_runspeed"):GetInt(),
        {L = "100% increased damage with single shot weapons.",
        R = "Headshot damage stacks,\ndealing 10% increased damage each stack."}
    )

    HORDE.CreateClass(
        "Engineer",
        "100% increased minion health and damage.\n\n",
        "Turrets you build have a base damage of 10.\n\nHave access to special weapons and equipment.",
        100,
        GetConVar("horde_base_walkspeed"):GetInt(),
        GetConVar("horde_base_runspeed"):GetInt(),
        {L = "",
        R = ""}
    )
end

function SyncClasses()
    if player then
        for _, ply in pairs(player.GetAll()) do
            net.Start("Horde_SyncClasses")
            net.WriteTable(HORDE.classes)
            net.Send(ply)
        end
    end
end

HORDE.SetClassData = function ()
    if SERVER then
        if GetConVar("horde_default_class_config"):GetInt() == 1 then return end
        if not file.IsDir("horde", "DATA") then
            file.CreateDir("horde")
        end
        
        file.Write("horde/class.txt", util.TableToJSON(HORDE.classes))
    end
end

function GetClassData()
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

-- Startup
HORDE.CreateClasses()
if SERVER then
    util.AddNetworkString("Horde_SetClassData")

    if GetConVar("horde_default_class_config"):GetInt() == 1 then
        -- Do nothing
    else
        GetClassData()
    end

    SyncClasses()
    
    net.Receive("Horde_SetClassData", function ()
        HORDE.classes = net.ReadTable()
        HORDE.SetClassData()
        SyncClasses()
    end)
end