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

        if (not HORDE.classes) or (not HORDE.classes[class]) then return end
        local mat = Material(HORDE.classes[class].icon, "mips smooth")
        local loc_class = translate.Get("Class_" .. class)
        local len = string.len(loc_class) * 6
        local rank = ply:Horde_GetRank(class)
        local rank_level = ply:Horde_GetRankLevel(class)

        cam.Start3D2D(render_pos, render_ang, 0.1)
            surface.SetMaterial(mat)
            surface.SetDrawColor(HORDE.Rank_Colors[rank])
            local pos = - 64 - len - 8
            surface.DrawTexturedRect(pos, -64 / 2, 64, 64)
            draw.SimpleText(loc_class, "Icon", len + 8, 0, fade_white, TEXT_ALIGN_CENTER, TEXT_ALIGN_CENTER)
            if rank == HORDE.Rank_Master then
                draw.SimpleText(rank_level, "Trebuchet18", pos - 5, 15, HORDE.Rank_Colors[rank], TEXT_ALIGN_CENTER, TEXT_ALIGN_CENTER)
            else
                if rank_level > 0 then
                    local star = Material("star.png", "mips smooth")
                    surface.SetMaterial(star)
                    local y_pos = 15
                    for i = 0, rank_level - 1 do
                        surface.DrawTexturedRect(pos - 10, y_pos, 10, 10)
                        y_pos = y_pos - 7
                    end
                end
            end

        cam.End3D2D()
        ::cont::
    end

end

if GetConVar("horde_enable_3d2d_icon"):GetInt() == 1 then
    hook.Add("PostDrawTranslucentRenderables", "Horde_RenderClassIcon", Render)
end