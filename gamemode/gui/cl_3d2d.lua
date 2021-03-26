surface.CreateFont("Icon", { font = "arial", size = 64 })

local function Render(bdepth, bskybox)
    if bskybox then return end

    for _, ply in pairs(player.GetAll()) do
        if not IsValid(ply) or (ply == LocalPlayer()) or (not ply:Alive()) then
            goto cont
        end

        local class = HORDE.Class_Survivor
        if ply:Horde_GetClass() then class = ply:Horde_GetClass().name end

        local attachment_id = ply:LookupAttachment("anim_attachment_head") or 0 -- Can't take any chances with nils here
        local attachment = ply:GetAttachment(attachment_id)

        local base_pos = Vector()

        if attachment and attachment.Pos then -- Would've been too ugly with a ternary
            base_pos = attachment.Pos
        else
            base_pos = (ply:LocalToWorld(ply:OBBCenter()) + ply:GetUp() * 24)
        end

        local render_pos = base_pos + ply:GetUp() * 15

        -- Distance fading
        local render_mindist = 500
        local render_maxdist = render_mindist + 80

        local dist = (render_pos - EyePos()):Length()
        local dist_clamped = math.Clamp(dist, render_mindist, render_maxdist)
        local dist_alpha = math.Remap(dist_clamped, render_mindist, render_maxdist, 200, 0)

        if dist_alpha == 0 then goto cont end -- Nothing to render

        -- Colors
        local fade_white = Color(255, 255, 255, dist_alpha)

        -- Render ang
        local render_ang = EyeAngles()
        render_ang:RotateAroundAxis(render_ang:Right(),90)
        render_ang:RotateAroundAxis(-render_ang:Up(),90)

        local mat = Material(HORDE.class[class].icon, "mips smooth")
        local len = string.len(class) * 6

        cam.Start3D2D(render_pos, render_ang, 0.1)
            surface.SetMaterial(mat)
            surface.SetDrawColor(fade_white)
            surface.DrawTexturedRect(- 64 - len - 8, -64 / 2, 64, 64)
            draw.SimpleText(class, "Icon", len + 8, 0, fade_white, TEXT_ALIGN_CENTER, TEXT_ALIGN_CENTER)

        cam.End3D2D()
        ::cont::
    end

end

if GetConVar("horde_enable_3d2d_icon"):GetInt() == 1 then
    hook.Add("PostDrawTranslucentRenderables", "Horde_RenderClassIcon", Render)
end