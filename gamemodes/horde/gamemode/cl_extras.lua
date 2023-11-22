hook.Add( "InitPostEntity", "MapVoteRestyle", function()
    if not MapVote then return end
    MapVote.style.colorPrimaryBG = Color( 50, 50, 50, 240 )
    MapVote.style.colorSecondaryFG = Color( 48, 48, 48 )
    MapVote.style.colorTextPrimary = Color( 255, 255, 255 )
    MapVote.style.colorCloseButton = Color( 255, 0, 0 )
    MapVote.style.frameBlur = 2
    MapVote.style.frameCornerRadius = 2
end )

gameevent.Listen( "player_spawn" )
hook.Add( "player_spawn", "FlashWindowOnRespawn", function( data )
    if Player( data.userid ) ~= LocalPlayer() then return end
    if system.HasFocus() then return end
    system.FlashWindow()
end )
