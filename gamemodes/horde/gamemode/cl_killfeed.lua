local cl_drawhud = GetConVar( "cl_drawhud" )
local hud_deathnotice_time = GetConVar( "hud_deathnotice_time" )

local deaths = {}

local function onPlayerDied()
    local ply = net.ReadEntity()
    local plyName = ply:GetName()
    local plyColor = team.GetColor( ply:Team() )

    local npcClassName = net.ReadString()
    
    table.insert( deaths, {
        left = npcClassName,
        right = plyName,
        icon = npcClassName,
        color1 = Color( 255, 50, 0, 255 ),
        color2 = plyColor,
        count = 1,
        time = CurTime()
    } )
end

net.Receive( "killfeed_player_died", onPlayerDied )

local function onPlayerKilledNPC()
    local ply = net.ReadEntity()
    local plyName = ply:GetName()
    
    local inflictorClass = net.ReadString()
    local npcClassName = "#" .. net.ReadString()
    
    for _, death in ipairs( deaths ) do
        if death.left == plyName and death.icon == inflictorClass then
            death.right = npcClassName
            death.count = death.count + 1
            death.time = CurTime()
            return
        end
    end
    
    local plyColor = team.GetColor( ply:Team() )
    
    table.insert( deaths, {
        left = plyName,
        right = npcClassName,
        icon = inflictorClass,
        color1 = plyColor,
        color2 = Color( 255, 50, 0, 255 ),
        count = 1,
        time = CurTime()
    } )
end

net.Receive( "killfeed_player_killed_npc", onPlayerKilledNPC )

local function drawDeath( x, y, death, time )
    local w, h = killicon.GetSize( death.icon )
    if not w or not h then return end
    local fadeout = ( death.time + time ) - CurTime()
    
    local alpha = math.Clamp( fadeout * 255, 0, 255 )
    death.color1.a = alpha
    death.color2.a = alpha
    
    killicon.Render( x - w / 2, y, death.icon )
    
    if death.left then
        draw.SimpleText( death.left, "ChatFont", x - w / 2 - 16, y + h / 2, death.color1, TEXT_ALIGN_RIGHT, TEXT_ALIGN_CENTER )
    end
    
    local offset = draw.SimpleText( death.right, "ChatFont", x + w / 2 + 16, y + h / 2, death.color2, TEXT_ALIGN_LEFT, TEXT_ALIGN_CENTER )

    if death.count > 1 then
        draw.SimpleText( "+" .. death.count, "ChatFont", x + w / 2 + 24 + offset, y + h / 2, Color( 255, 255, 255, alpha ), TEXT_ALIGN_LEFT, TEXT_ALIGN_CENTER )
    end
    
    return math.ceil( y + h * 0.75 )
end

function GM:DrawDeathNotice( x, y )
    if cl_drawhud:GetInt() == 0 then return true end

    local time = hud_deathnotice_time:GetFloat()
    
    x = x * ScrW()
    y = y * ScrH()
    
    local remainingDeaths = {}
    
    for _, death in ipairs( deaths ) do
        if death.time + time > CurTime() then
            if death.lerp then
                x = x * 0.3 + death.lerp.x * 0.7
                y = y * 0.3 + death.lerp.y * 0.7
            end
            
            death.lerp = death.lerp or {}
            death.lerp.x = x
            death.lerp.y = y
            
            y = drawDeath( math.floor( x ), math.floor( y ), death, time )
            
            table.insert( remainingDeaths, death )
        end
    end
    
    deaths = remainingDeaths
end
