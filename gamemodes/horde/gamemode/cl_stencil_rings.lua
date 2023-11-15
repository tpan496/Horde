local colmask = Color(0,0,0,0)
local render_DrawSphere = render.DrawSphere
local table_insert = table.insert
rings = rings or {}

local Lists = {}
local col = Color(255,255,255,255)

function rings.SetColor(color) --this does not work for multiple colours right now
	col = color
end

function rings.AddSet(tbl, col)
	local set = { zones = {}, color = col }
	for _ , ring in ipairs(tbl) do
		local t = { pos = ring[1]:GetPos(), 
		inner_r = math.max(ring[2] - ring[3],0), 
		outer_r = ring[2], 
		detail = ring[4] }
		table_insert( set.zones , t )
	end
	table_insert( Lists , set )
end

function rings.RenderSphere( tbl )
	render.SetStencilCompareFunction( STENCIL_ALWAYS )
	render.SetStencilZFailOperation( STENCIL_INCRSAT )
	for _, v in next, tbl do render_DrawSphere( v.pos, -v.outer_r, v.detail, v.detail, colmask ) end
	render.SetStencilZFailOperation( STENCIL_DECR )
	for _, v in next, tbl do render_DrawSphere( v.pos, v.outer_r, v.detail, v.detail, colmask ) end
	render.SetStencilZFailOperation( STENCIL_INCR )
	for _, v in next, tbl do render_DrawSphere( v.pos, -v.inner_r, v.detail, v.detail, colmask ) end
	render.SetStencilZFailOperation( STENCIL_DECR )
	for _, v in next, tbl do render_DrawSphere( v.pos, v.inner_r, v.detail, v.detail, colmask ) end
end

function rings.StartStencils()
	cam.IgnoreZ( false )
	render.SetStencilEnable( true )
	render.SetStencilCompareFunction( STENCIL_ALWAYS )
	render.SetStencilPassOperation( STENCIL_KEEP )
	render.SetStencilFailOperation( STENCIL_KEEP )
	render.SetStencilZFailOperation( STENCIL_KEEP )
	render.SetStencilReferenceValue( 1 )
	render.SetStencilTestMask( 255 )
	render.SetStencilWriteMask( 255 )
	render.ClearStencil()
	render.SetColorMaterial()
end

function rings.DrawRings( zones )
	local cam_normal = LocalPlayer():EyeAngles():Forward()
	local cam_pos = EyePos()
	render.SetStencilCompareFunction( STENCIL_EQUAL )
	render.SetStencilReferenceValue( 1 )
	render.DrawQuadEasy(cam_pos + cam_normal*10, -cam_normal, 100, 200, zones.color, 0)
end

function rings.RenderRings( zones )
	rings.StartStencils()

	rings.RenderSphere( zones.zones )

	rings.DrawRings( zones )

	render.SetStencilEnable( false )
end

hook.Add("PostDrawOpaqueRenderables","RenderRings",function()
	Lists = {}
	hook.Run("PreDrawRings")

	if #Lists == 0 then return end
	for _,set in pairs(Lists) do
		if #set.zones == 0 then continue end
		rings.RenderRings(set)
	end
end)
