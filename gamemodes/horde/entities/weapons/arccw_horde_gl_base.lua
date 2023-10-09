SWEP.Base = "arccw_base"
function SWEP:ShouldDrawCrosshair()
    if self:GetReloading() then return false end
    if self:BarrelHitWall() > 0 then return false end
    local asight = self:GetActiveSights()

    if !self:GetOwner():ShouldDrawLocalPlayer()
            and self:GetState() == ArcCW.STATE_SIGHTS and !asight.CrosshairInSights then
        return false
    end

    if self:GetNWState() == ArcCW.STATE_SPRINT and !self:CanShootWhileSprint() then return false end
    if self:GetCurrentFiremode().Mode == 0 then return false end
    if self:GetBuff_Hook("Hook_ShouldNotFire") then return false end
    if self:GetNWState() == ArcCW.STATE_CUSTOMIZE then return false end
    if self:GetNWState() == ArcCW.STATE_DISABLE then return false end
    local x, y
    local tr = self.Owner:GetEyeTrace()
    if ( self.Owner == LocalPlayer() and self.Owner:ShouldDrawLocalPlayer() ) then
        local coords = tr.HitPos:ToScreen()
        x, y = coords.x, coords.y
    else
        x, y = ScrW() / 2, ScrH() / 2
    end
    surface.SetTexture( surface.GetTextureID( "vgui/hud/gl_crosshair" ) )
    surface.SetDrawColor( 255, 255, 255, 255 )
    surface.DrawTexturedRect( x - ScrW() / 40, y - ScrW() / 40, ScrW() / 20, ScrW() / 20 )
    return false
end