ENT.Type = "brush"

function ENT:StartTouch(ent)
	if ent:IsPlayer() then
		if HORDE.current_break_time > 0 then
			ent:Horde_SetInBuyZone(true)
		else
			ent:Horde_SetInBuyZone(false)
		end
	end
end

function ENT:EndTouch(ent)
	if ent:IsPlayer() then
		ent:Horde_SetInBuyZone(false)
		net.Start("Horde_ForceCloseShop")
    	net.Send(ent)
	end
end