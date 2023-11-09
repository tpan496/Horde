local colmask = Color(0,0,0,0)
local render_DrawSphere = render.DrawSphere

rings = rings or {}

local List = {}
local col = Color(255,255,255,255)

function rings.SetColor(color) --this does not work for multiple colours right now
	col = color
end

function rings.Add(ent, outer, thickness, Detail, ringcolor)
	t = { pos = ent:GetPos(), inner_r = math.max(outer - thickness,0), outer_r = outer, detail = Detail}

	table.insert( List, t )
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

function rings.DrawRings( cam_normal, Color )

	local cam_pos = EyePos( LocalPlayer() )
	render.SetStencilCompareFunction( STENCIL_EQUAL )
	render.SetStencilReferenceValue( 1 )
	render.DrawQuadEasy(cam_pos + cam_normal*10, -cam_normal, 100, 200, Color, 0)
end

function rings.RenderRings( zones, col )

	rings.StartStencils()
	
	rings.RenderSphere( zones )

	rings.CamRendering( LocalPlayer():EyeAngles():Forward(), col )
	
	render.SetStencilEnable( false )
end

hook.Add("PostDrawOpaqueRenderables","RenderRings",function()
	List = {}
	hook.Run("PreDrawRings")

	if #List == 0 then end
	rings.RenderRings(List, col)
end)
