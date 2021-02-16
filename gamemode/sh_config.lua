HORDE = {}
HORDE.__index = HORDE
HORDE.color_crimson = Color(220, 20, 60)
HORDE.start_game = false
HORDE.total_enemies_per_wave = {10, 40, 60, 80, 100}
HORDE.total_enemies_this_wave = 0
HORDE.alive_enemies_this_wave = 0
HORDE.killed_enemies_this_wave = 0
HORDE.current_wave = 0
HORDE.total_break_time = 10
HORDE.current_break_time = HORDE.total_break_time
HORDE.max_spawn_distance = 2000
HORDE.min_spawn_distance = 500
HORDE.max_enemies_alive = 20
HORDE.spawned_enemies = {}
HORDE.ai_nodes = {}
HORDE.found_ai_nodes = false
HORDE.enemy_spawn_z = 15
HORDE.player_ready = {}

-- Economy variables
HORDE.items = {}

HORDE.CreateItem = function (category, name, class, price, weight, description, whitelist)
    if category == nil or name == nil or class == nil or price == nil or weight == nil or description == nil then return end
    if category ~= "Melee" and category ~= "Pistol" and category ~= "SMG" and category ~= "MG" and category ~= "Shotgun" and category ~= "Rifle" and category ~= "Explosive" and category ~= "Special" and category ~= "Equipment" then return end
    if string.len(name) <= 0 or string.len(class) <= 0 then return end
    if price < 0 or weight < 0 then return end
    local item = {}
    item.category = category
    item.name = name
    item.class = class
    item.price = price
    item.weight = weight
    item.description = description
    item.whitelist = whitelist
    HORDE.items[item.class] = item
    SetItemsData()
end

function SetItemsData()
	if not file.IsDir('horde', 'DATA') then
		file.CreateDir('horde')
	end
	
	file.Write('horde/items.txt', util.TableToJSON(HORDE.items))
end

function GetItemsData()
    if not file.IsDir('horde', 'DATA') then
		file.CreateDir('horde')
        return
	end
    
    if file.Read('horde/items.txt', 'DATA') then
        HORDE.items = util.JSONToTable(file.Read('horde/items.txt', 'DATA'))
    end
end

GetItemsData()

HORDE.max_weight = 15
HORDE.default_ammo_price = 10

-- Class
HORDE.classes = {}
HORDE.CreateClass = function (name, description, max_hp, movespd, sprintspd)
    local class = {}
    class.name = name
    class.description = description
    class.category_list = category_list
    class.max_hp = max_hp
    class.movespd = movespd
    class.sprintspd = sprintspd
    HORDE.classes[class.name] = class
end
-- Only allow 1 change per wave
HORDE.player_class_changed = {}