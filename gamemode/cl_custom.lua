
-- EasyLabel
function EasyLabel(parent, text, font, textcolor)
	local ELpanel = vgui.Create("DLabel", parent)
	if font then
		ELpanel:SetFont(font or "DefaultFont")
	end
	ELpanel:SetText(text)
	ELpanel:SizeToContents()
	if textcolor then
		ELpanel:SetTextColor(textcolor)
	end
	ELpanel:SetKeyboardInputEnabled(false)
	ELpanel:SetMouseInputEnabled(false)

	return ELpanel
end
