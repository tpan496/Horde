HORDE.Attachments = {}
HORDE.Attachments.Pricings = {} -- Unused
HORDE.UniversalPricing = 100
HORDE.UniversalCategoryPricing = {
	["Optic"] = 100,
	["Underbarrel"] = 150,
	["Tactical"] = 100,
	["Barrel"] = 125,
	["Muzzle"] = 125,
	["Magazine"] = 150,
	["Stock"] = 100,
	["Ammo Type"] = 50,
	["Perk"] = 200,
	["Charm"] = 0,
}

--[[
	If you wonder what are all those crap under this comment, I was planning to make a config menu for attachments
	But nah im too lazy to do that, so I just leave it here.
]]

function HORDE.CompressTable(t)
	local data = util.Compress(util.TableToJSON(t))
	local len = #data
	return data, len
end

function HORDE.DecompressTable(data)
	return util.JSONToTable(util.Decompress(data))
end

function HORDE.GetAttachmentPrice(slot, class)
	local uPrice = HORDE.UniversalCategoryPricing[slot] || HORDE.UniversalPricing
	local att = HORDE.items[class]
	if(att && att.price) then
		uPrice = att.price
	end
	return uPrice
end

if(SERVER) then
	util.AddNetworkString("Horde_RequestAttachments")
	util.AddNetworkString("Horde_SyncAttachments")
	util.AddNetworkString("Horde_BuyAttachment")

	function HORDE.SaveAttachments()
		local data = HORDE.CompressTable(HORDE.Attachments.Pricings)
		file.Write("horde/attachments.txt", data)
	end

	function HORDE.ReadAttachments()
		if(file.Exists("horde/attachments.txt", "DATA")) then
			local data = file.Read("horde/attachments.txt", "DATA")
			HORDE.Attachments.Pricings = HORDE.DecompressTable(data)
		end
	end

	function HORDE.BroadcastAttachments()
		local data, len = HORDE.CompressTable(HORDE.Attachments.Pricings)
		net.Start("Horde_SyncAttachments")
		net.WriteUInt(len, 32)
		net.WriteData(data, len)
		net.Broadcast()
	end

	function HORDE.SyncAttachments(ply)
		local data, len = HORDE.CompressTable(HORDE.Attachments.Pricings)
		net.Start("Horde_SyncAttachments")
		net.WriteUInt(len, 32)
		net.WriteData(data, len)
		net.Send(ply)
	end

	net.Receive("Horde_RequestAttachments", function(len, ply)
		HORDE.SyncAttachments(ply)
	end)

	net.Receive("Horde_SyncAttachments", function(len, ply)
		if(!ply:IsAdmin()) then return end
		local len = net.ReadUInt(32)
		local data = net.ReadData(len)
		HORDE.Attachments.Pricings = HORDE.DecompressTable(data)
		HORDE.BroadcastAttachments()
		HORDE.SaveAttachments()
	end)

	net.Receive("Horde_BuyAttachment", function(len, ply)
		local slot = net.ReadString()	
		local class = net.ReadString()
		local price = HORDE.GetAttachmentPrice(slot, class)
		if(ply:Horde_GetMoney() < price) then return end
		ArcCW:PlayerGiveAtt(ply, class, 1)
		ArcCW:PlayerSendAttInv(ply)
		ply:EmitSound("weapons/arccw/useatt.wav")
		ply:Horde_AddMoney(-price)
		ply:Horde_SyncEconomy()
	end)

	HORDE.ReadAttachments()
else
	function HORDE.RequestAttachments()
		net.Start("Horde_RequestAttachments")
		net.SendToServer()
	end

	--go_m249_barrel_long
	function HORDE.IsAttachmentWhitelisted(class)
		local att = HORDE.items[class]
		if(GetConVar("horde_testing_attachment_copy"):GetInt() == 1) then return true end
		if(!att) then return false end
		if(!att.whitelist) then return true end
		local subclass = LocalPlayer():Horde_GetCurrentSubclass()
		return att.whitelist[subclass] == true
	end

	net.Receive("Horde_SyncAttachments", function()
		local len = net.ReadUInt(32)
		local data = net.ReadData(len)
		HORDE.Attachments.Pricings = HORDE.DecompressTable(data)
	end)

	hook.Add("InitPostEntity", "Horde_GetAttachments", function()
		--HORDE.RequestAttachments() -- No need to request attachments, Since we're not going to make it customizable
	end)
end