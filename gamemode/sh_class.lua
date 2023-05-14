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
HORDE.Class_Warden = "Warden"
HORDE.Class_Cremator = "Cremator"

-- Creates a Horde class
function HORDE:CreateClass(name, extra_description, max_hp, movespd, sprintspd, base_perk, perks, order, display_name, model, icon, subclasses)
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
    class.infusions = infusions or {}
    class.subclasses = subclasses or {}
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
        "Has access to all weapons except for exclusive and special weapons.\n\nLimited access to attachments.",
        100,
        GetConVar("horde_base_walkspeed"):GetInt(),
        GetConVar("horde_base_runspeed"):GetInt(),
        "survivor_base",
        {
            [1] = {title = "Survival", choices = {"medic_antibiotics", "assault_charge"}},
            [2] = {title = "Improvise", choices = {"berserker_breathing_technique", "demolition_frag_cluster"}},
            [3] = {title = "Imprinting", choices = {"heavy_liquid_armor", "cremator_entropy_shield"}},
            [4] = {title = "Inspired Learning", choices = {"ghost_headhunter", "specops_flare"}},
        },
        0,nil,nil,nil,
        {HORDE.Class_Survivor}
    )

    HORDE:CreateClass(
        HORDE.Class_Assault,
        "Has full access to assault rifles.",
        100,
        GetConVar("horde_base_walkspeed"):GetInt(),
        GetConVar("horde_base_runspeed"):GetInt(),
        "assault_base",
        {
            [1] = {title = "Maneuverability", choices = {"assault_ambush", "assault_charge"}},
            [2] = {title = "Adaptability", choices = {"assault_drain", "assault_overclock"}},
            [3] = {title = "Aggression", choices = {"assault_cardiac_resonance", "assault_cardiac_overload"}},
            [4] = {title = "Conditioning", choices = {"assault_heightened_reflex", "assault_merciless_assault"}},
        },
        1,nil,nil,nil,
        {HORDE.Class_Assault}
    )

    HORDE:CreateClass(
        HORDE.Class_Heavy,
        "Has full access to machine guns and high weight weapons.",
        100,
        GetConVar("horde_base_walkspeed"):GetInt(),
        GetConVar("horde_base_runspeed"):GetInt(),
        "heavy_base",
        {
            [1] = {title = "Suppression", choices = {"heavy_sticky_compound", "heavy_crude_casing"}},
            [2] = {title = "Backup", choices = {"heavy_repair_catalyst", "heavy_floating_carrier"}},
            [3] = {title = "Armor Protection", choices = {"heavy_liquid_armor", "heavy_reactive_armor"}},
            [4] = {title = "Technology", choices = {"heavy_nanomachine", "heavy_ballistic_shock"}},
        },
        2,nil,nil,nil,
        {HORDE.Class_Heavy}
    )

    HORDE:CreateClass(
        HORDE.Class_Medic,
        "Has acesss to most light weapons and medical tools.",
        100,
        GetConVar("horde_base_walkspeed"):GetInt(),
        GetConVar("horde_base_runspeed"):GetInt(),
        "medic_base",
        {
            [1] = {title = "Medicine", choices = {"medic_antibiotics", "medic_painkillers"}},
            [2] = {title = "Bio-Engineering", choices = {"medic_berserk", "medic_fortify"}},
            [3] = {title = "Enhancement", choices = {"medic_purify", "medic_haste"}},
            [4] = {title = "Natural Selection", choices = {"medic_cellular_implosion", "medic_xcele"}},
        },
        3,nil,nil,nil,
        {HORDE.Class_Medic}
    )

    HORDE:CreateClass(
        HORDE.Class_Demolition,
        "Has full access to explosive weapons.",
        100,
        GetConVar("horde_base_walkspeed"):GetInt(),
        GetConVar("horde_base_runspeed"):GetInt(),
        "demolition_base",
        {
            [1] = {title = "Grenade", choices = {"demolition_frag_impact", "demolition_frag_cluster"}},
            [2] = {title = "Weaponry", choices = {"demolition_direct_hit", "demolition_seismic_wave"}},
            [3] = {title = "Approach", choices = {"demolition_fragmentation", "demolition_knockout"}},
            [4] = {title = "Destruction", choices = {"demolition_chain_reaction", "demolition_pressurized_warhead"}},
        },
        4,nil,nil,nil,
        {HORDE.Class_Demolition}
    )

    HORDE:CreateClass(
        HORDE.Class_Ghost,
        "Has access to sniper rifles and selected light weapons.\n\nHave access to suppressors and sniper scopes.",
        100,
        GetConVar("horde_base_walkspeed"):GetInt(),
        GetConVar("horde_base_runspeed"):GetInt(),
        "ghost_base",
        {
            [1] = {title = "Tactics", choices = {"ghost_headhunter", "ghost_sniper"}},
            [2] = {title = "Reposition", choices = {"ghost_phase_walk", "ghost_ghost_veil"}},
            [3] = {title = "Trajectory", choices = {"ghost_brain_snap", "ghost_kinetic_impact"}},
            [4] = {title = "Disposal", choices = {"ghost_coup", "ghost_decapitate"}},
        },
        5,nil,nil,nil,
        {HORDE.Class_Ghost}
    )

    HORDE:CreateClass(
        HORDE.Class_Engineer,
        "Has access to special weapons and equipment.",
        100,
        GetConVar("horde_base_walkspeed"):GetInt(),
        GetConVar("horde_base_runspeed"):GetInt(),
        "engineer_base",
        {
            [1] = {title = "Craftsmanship", choices = {"engineer_tinkerer", "engineer_pioneer"}},
            [2] = {title = "Core", choices = {"engineer_fusion", "engineer_metabolism"}},
            [3] = {title = "Manipulation", choices = {"engineer_antimatter_shield", "engineer_displacer"}},
            [4] = {title = "Experimental", choices = {"engineer_symbiosis", "engineer_kamikaze"}},
        },
        6,nil,nil,nil,
        {HORDE.Class_Engineer}
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
            [3] = {title = "Parry", choices = {"berserker_graceful_guard", "berserker_unwavering_guard"}},
            [4] = {title = "Combat Arts", choices = {"berserker_phalanx", "berserker_rip_and_tear"}},
        },
        7,nil,nil,nil,
        {HORDE.Class_Berserker}
    )

    HORDE:CreateClass(
        HORDE.Class_Warden,
        "Has full access to shotguns and watchtowers (horde_watchtower).",
        100,
        GetConVar("horde_base_walkspeed"):GetInt(),
        GetConVar("horde_base_runspeed"):GetInt(),
        "warden_base",
        {
            [1] = {title = "Sustain", choices = {"warden_bulwark", "warden_vitality"}},
            [2] = {title = "Resource Utilization", choices = {"warden_restock", "warden_inoculation"}},
            [3] = {title = "Escort", choices = {"warden_rejection_pulse", "warden_energize"}},
            [4] = {title = "Coverage", choices = {"warden_ex_machina", "warden_resonance_cascade"}},
        },
        8,nil,nil,nil,
        {HORDE.Class_Warden}
    )

    HORDE:CreateClass(
        HORDE.Class_Cremator,
        "Has access to heat-based weaponry.",
        100,
        GetConVar("horde_base_walkspeed"):GetInt(),
        GetConVar("horde_base_runspeed"):GetInt(),
        "cremator_base",
        {
            [1] = {title = "Chemicals", choices = {"cremator_methane", "cremator_napalm"}},
            [2] = {title = "Energy Absorption", choices = {"cremator_positron_array", "cremator_entropy_shield"}},
            [3] = {title = "Heat Manipulation", choices = {"cremator_hyperthermia", "cremator_ionization"}},
            [4] = {title = "Energy Discharge", choices = {"cremator_firestorm", "cremator_incineration"}},
        },
        9,nil,nil,nil,
        {HORDE.Class_Cremator}
    )
end

if SERVER then
    util.AddNetworkString("Horde_SetClassData")
    util.AddNetworkString("Horde_SetSubclass")
    util.AddNetworkString("Horde_UnlockSubclass")
    util.AddNetworkString("Horde_SubclassUnlocked")
    util.AddNetworkString("Horde_SyncSubclassUnlocks")
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

    net.Receive("Horde_SetSubclass", function (len, ply)
        local class_name = net.ReadString()
        local subclass = net.ReadString()
        ply:Horde_SetSubclass(class_name, subclass)

        if not ply:IsValid() then return end

        -- Clear status
        net.Start("Horde_ClearStatus")
        net.Send(ply)

        ply:Horde_ApplyPerksForClass()
        ply:Horde_SyncEconomy()
    end)
    
    net.Receive("Horde_UnlockSubclass", function (len, ply)
        local subclass_name = net.ReadString()
        local subclass = HORDE.subclasses[subclass_name]
        if not subclass then return end
        local cost = subclass.UnlockCost

        if ply:Horde_GetSubclassUnlocked(subclass_name) == true then
            HORDE:SendNotification("Subclass " .. subclass.PrintName .. " is already unlocked!", 1, ply)
            return
        end

        if ply:Horde_GetSkullTokens() >= cost then
            ply:Horde_AddSkullTokens(-cost)
            ply:Horde_SetSubclassUnlocked(subclass_name, true)
            ply:Horde_SyncEconomy()
            
            HORDE:SendNotification("You unlocked " .. subclass.PrintName .. " subclass.", 0, ply)
        end
    end)
end

if CLIENT then
    net.Receive("Horde_SyncClasses", function ()
        HORDE.classes = net.ReadTable()
        for name, c in pairs(HORDE.classes) do
            HORDE.order_to_class_name[c.order] = name
        end
        local class = MySelf:Horde_GetCurrentSubclass() or HORDE.Class_Survivor
    end)

    net.Receive("Horde_SyncSubclassUnlocks", function ()
        local table = net.ReadTable()
        MySelf.Horde_subclasses_unlocked = table
    end)
end

HORDE.subclasses = {}
HORDE.classes_to_subclasses = {
    [HORDE.Class_Survivor] = {HORDE.Class_Survivor},
    [HORDE.Class_Assault] = {HORDE.Class_Assault},
    [HORDE.Class_Medic] = {HORDE.Class_Medic},
    [HORDE.Class_Heavy] = {HORDE.Class_Heavy},
    [HORDE.Class_Demolition] = {HORDE.Class_Demolition},
    [HORDE.Class_Cremator] = {HORDE.Class_Cremator},
    [HORDE.Class_Ghost] = {HORDE.Class_Ghost},
    [HORDE.Class_Warden] = {HORDE.Class_Warden},
    [HORDE.Class_Berserker] = {HORDE.Class_Berserker},
    [HORDE.Class_Engineer] = {HORDE.Class_Engineer},
}
HORDE.classes_to_order = {
    [HORDE.Class_Survivor] = 0,
    [HORDE.Class_Assault] = 1,
    [HORDE.Class_Heavy] = 2,
    [HORDE.Class_Medic] = 3,
    [HORDE.Class_Demolition] = 4,
    [HORDE.Class_Ghost] = 5,
    [HORDE.Class_Engineer] = 6,
    [HORDE.Class_Berserker] = 7,
    [HORDE.Class_Warden] = 8,
    [HORDE.Class_Cremator] = 9,
}
HORDE.order_to_class_name = {
    [0] = HORDE.Class_Survivor,
    [1] = HORDE.Class_Assault,
    [2] = HORDE.Class_Heavy,
    [3] = HORDE.Class_Medic,
    [4] = HORDE.Class_Demolition,
    [5] = HORDE.Class_Ghost,
    [6] = HORDE.Class_Engineer,
    [7] = HORDE.Class_Berserker,
    [8] = HORDE.Class_Warden,
    [9] = HORDE.Class_Cremator,
}
HORDE.subclass_name_to_crc = {}
HORDE.subclasses_to_classes = {}
HORDE.order_to_subclass_name = {}
local prefix = "horde/gamemode/subclasses/"
local function Horde_LoadSubclasses()
    local dev = GetConVar("developer"):GetBool()
    for _, f in ipairs(file.Find(prefix .. "*", "LUA")) do
        SUBCLASS = {}
        AddCSLuaFile(prefix .. f)
        include(prefix .. f)
        if SUBCLASS.Ignore then goto cont end
        SUBCLASS.SortOrder = SUBCLASS.SortOrder or 0
        SUBCLASS.BasePerk = SUBCLASS.BasePerk or (string.lower(SUBCLASS.PrintName).. "_base")

        HORDE.subclasses[SUBCLASS.PrintName] = SUBCLASS
        local crc_val = util.CRC(SUBCLASS.PrintName)
        HORDE.subclass_name_to_crc[SUBCLASS.PrintName] = crc_val
        HORDE.order_to_subclass_name[crc_val] = SUBCLASS.PrintName
        if SUBCLASS.ParentClass then
            table.insert(HORDE.classes_to_subclasses[SUBCLASS.ParentClass], SUBCLASS.PrintName)
            HORDE.subclasses_to_classes[SUBCLASS.PrintName] = SUBCLASS.ParentClass
        else
            HORDE.subclasses_to_classes[SUBCLASS.PrintName] = SUBCLASS.PrintName
    end

        if dev then print("[Horde] Loaded subclass '" .. SUBCLASS.PrintName .. "'.") end
        ::cont::
    end
    PERK = nil
end

Horde_LoadSubclasses()

local plymeta = FindMetaTable("Player")

function plymeta:Horde_SetClass(class)
    self.Horde_class = class
    if GetConVarNumber("horde_enable_class_models") == 0 then return end
    self:Horde_SetClassModel(class)
end

function plymeta:Horde_SetSubclass(class_name, subclass_name)
    if not self.Horde_subclasses then self.Horde_subclasses = {} end
    self.Horde_subclasses[class_name] = subclass_name
    if SERVER then
        -- Check items
        if self:GetWeapons() then
            for _, wpn in pairs(self:GetWeapons()) do
                if HORDE.items[wpn:GetClass()] then
                    local item = HORDE.items[wpn:GetClass()]
                    if self:Horde_GetCurrentSubclass() == "Gunslinger" and item.category == "Pistol" then
                        continue
                    end
                    if (item.whitelist and (not item.whitelist[self:Horde_GetClass().name])) then
                        timer.Simple(0, function ()
                            self:DropWeapon(wpn)
                        end)
                        continue
                    end
                end
            end
        end

        HORDE:SendNotification(class_name .. " subclass changed to " .. HORDE.subclasses[subclass_name].PrintName, 0, self)
    end
    if CLIENT then
        net.Start("Horde_SetSubclass")
            net.WriteString(class_name)
            net.WriteString(subclass_name)
        net.SendToServer()
    end
end

function HORDE:LoadSubclassUnlocks(ply)
    if not ply:IsValid() then return end
    if not file.IsDir("horde/subclass_unlocks", "DATA") then
		file.CreateDir("horde/subclass_unlocks", "DATA")
	end

    local path = "horde/subclass_unlocks/" .. HORDE:ScrubSteamID(ply) .. ".txt"

    ply.Horde_subclasses_unlocked = {}
    if not file.Exists(path, "DATA") then
        print("Path", path, "does not exist!")
        for subclass_name, subclass in pairs(HORDE.subclasses) do
            ply.Horde_subclasses_unlocked[subclass_name] = false
        end
        HORDE:SaveSubclassUnlocks(ply)
        return
    end

    local f = file.Open(path, "rb", "DATA")
    while not f:EndOfFile() do
        local subclass_order = f:ReadULong()
        local status = f:ReadBool()
        local subclass_name = HORDE.order_to_subclass_name[tostring(subclass_order)]
        if not subclass_name then goto cont end
        ply.Horde_subclasses_unlocked[subclass_name] = status
        ::cont::
    end
    f:Close()

    net.Start("Horde_SyncSubclassUnlocks")
        net.WriteTable(ply.Horde_subclasses_unlocked)
    net.Send(ply)
end

function HORDE:SaveSubclassUnlocks(ply)
    if GetConVar("horde_enable_sandbox"):GetInt() == 1 then return end
    if not file.IsDir("horde/subclass_unlocks", "DATA") then
        file.CreateDir("horde/subclass_unlocks", "DATA")
    end

    local path = "horde/subclass_unlocks/" .. HORDE:ScrubSteamID(ply) .. ".txt"
    local f = file.Open(path, "wb", "DATA")
    for subclass_name, status in pairs(ply.Horde_subclasses_unlocked) do
        f:WriteULong(HORDE.subclass_name_to_crc[subclass_name])
        f:WriteBool(status)
    end
    
    f:Close()
end

function plymeta:Horde_SetSubclassUnlocked(subclass, unlocked)
    if not self.Horde_subclasses_unlocked then return end
    self.Horde_subclasses_unlocked[subclass] = unlocked
    if SERVER and unlocked == true then
        net.Start("Horde_SubclassUnlocked")
            net.WriteString(subclass)
        net.Send(self)
        HORDE:SaveSubclassUnlocks(self)
    end
end

function plymeta:Horde_SetSubclassChoice(class_name, subclass_name)
    MySelf.Horde_subclass_choices[class_name] = subclass_name
    if CLIENT then
        HORDE:SaveSubclassChoices()
    end
end

function plymeta:Horde_GetClass()
    return self.Horde_class
end

function plymeta:Horde_GetSubclass(class_name)
    if self.Horde_subclasses and self.Horde_subclasses[class_name] then
        return self.Horde_subclasses[class_name]
    else
        -- return parent class
        return class_name
    end
end

function plymeta:Horde_GetSubclassUnlocked(subclass)
    if not self.Horde_subclasses_unlocked then self.Horde_subclasses_unlocked = {} end
    if not HORDE.subclasses[subclass].ParentClass then return true end
    return self.Horde_subclasses_unlocked[subclass] == true
    --return self.Horde_subclasses_unlocked[subclass] == true
end

function plymeta:Horde_GetCurrentSubclass()
    if not self:Horde_GetClass() then return end
    if self.Horde_subclasses and self.Horde_subclasses[self:Horde_GetClass().name] then
        return self.Horde_subclasses[self:Horde_GetClass().name]
    else
        return self:Horde_GetClass().name
    end
end

function HORDE:SaveSubclassChoices()
    local f = file.Open("horde/subclass_choices.txt", "wb", "DATA")
    for class, subclass in pairs(MySelf.Horde_subclass_choices) do
        f:WriteULong(HORDE.classes_to_order[class])
        f:WriteULong(HORDE.subclass_name_to_crc[subclass])
    end
    f:Close()
end

function HORDE:LoadSubclassChoices()
    MySelf.Horde_subclass_choices = {}
    if not file.Exists("horde/subclass_choices.txt", "DATA") then
        for class_name, _ in pairs(HORDE.classes_to_subclasses) do
            MySelf.Horde_subclass_choices[class_name] = class_name
        end
        HORDE:SaveSubclassChoices()
    else
        local f = file.Open("horde/subclass_choices.txt", "rb", "DATA")
        if not MySelf.Horde_subclasses then MySelf.Horde_subclasses = {} end
        while not f:EndOfFile() do
            local class_order = f:ReadULong()
            local subclass_order = f:ReadULong()
            MySelf.Horde_subclass_choices[HORDE.order_to_class_name[class_order]] = HORDE.order_to_subclass_name[tostring(subclass_order)]
            MySelf.Horde_subclasses[HORDE.order_to_class_name[class_order]] = HORDE.order_to_subclass_name[tostring(subclass_order)]
        end
        f:Close()

        -- Double check that we have all the subclasses we need
        for class_name, _ in pairs(HORDE.classes_to_subclasses) do
            if not MySelf.Horde_subclass_choices[class_name] then
                MySelf.Horde_subclass_choices[class_name] = class_name
            end
        end
    end
end

if CLIENT then
hook.Add("InitPostEntity", "Horde_PlayerInit", function()
    timer.Simple(0, function ()
        HORDE:LoadSubclassChoices()
        local f = file.Read("horde/class_choices.txt", "DATA")
        if f then
            local class = f
            if not HORDE.subclasses[class] then
                class = HORDE.Class_Survivor
            end
            local f2 = file.Read("horde/class_choices.txt", "DATA")
	    -- I Seriously don't understand what it's supposed to do.
            --[[if HORDE.subclasses_to_classes[f2] then
                f2 = HORDE.subclasses_to_classes[f2]
            end]]--

            if f2 then
                HORDE:SendSavedPerkChoices(f2)
            else
                HORDE:SendSavedPerkChoices(class)
            end

            net.Start("Horde_InitClass")
            net.WriteString(class)
            net.SendToServer()
        end
        net.Start("Horde_PlayerInit")
        net.SendToServer()
    end)
end)

net.Receive("Horde_SubclassUnlocked", function ()
    local subclass = net.ReadString()
    MySelf:Horde_SetSubclassUnlocked(subclass, true)
end)
end
