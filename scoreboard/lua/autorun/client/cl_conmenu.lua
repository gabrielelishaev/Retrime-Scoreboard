
function ContextMenu(menu, target)

	if not IsValid(target) then return end

	local nick = target:Nick()
	local steamid = target:SteamID()
	local group = target:GetUserGroup()
	local steamname = target:SteamName()

	if target:IsBot() then
		steamid = nick
	end

	local other, other_tab = menu:AddSubMenu(nick, function() SetClipboardText(nick) end)
	other_tab:SetIcon("icon16/pictures.png")

	other.showprofile = other:AddOption("Открыть профиль", function() target:ShowProfile() end)
	other.showprofile:SetIcon("icon16/world.png")

	if target:IsMuted() then
		other.unmute = other:AddOption("Включить микрофон", function() target:SetMuted(false) end)
		other.unmute:SetIcon("icon16/transmit_add.png")
	else
		other.mute = other:AddOption("Отключить микрофон", function() target:SetMuted(true) end)
		other.mute:SetIcon("icon16/transmit_delete.png")
	end

	other:AddSpacer()

	other.steamname = other:AddOption(steamname, function() SetClipboardText(steamname) end)
	other.steamname:SetIcon("icon16/user.png")

	other.steamid = other:AddOption(steamid, function() SetClipboardText(steamid) end)
	other.steamid:SetIcon("icon16/link_break.png")

	other.usergroup = other:AddOption(group, function() SetClipboardText(group) end)
	other.usergroup:SetIcon("icon16/group.png")

end

properties.Add("Context", {

	MenuLabel = "context",
	MenuIcon = "icon16/bomb.png",

	Filter = function(self, ent)
		return IsValid(ent) and ent:IsPlayer()
	end,

	Action = function()
		return
	end,

	MenuOpen = function(self, option, ent)
		local menu = option:AddSubMenu()
		ContextMenu(menu, ent)
	end

})