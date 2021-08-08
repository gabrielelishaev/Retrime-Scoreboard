
function Score()
    function Tab()
        local scrw = math.max(864, ScrW() * 0.45)
        local scrh = math.max(720, ScrH() * 0.7)
        local players = player.GetAll()
        local tabpanel = TabMN
        local server = paim.Name
        if #server > 40 then
			server = server:Left(40) .. "..."
		end

		if(IsValid(tabpanel))then
			tabpanel:Remove()
		end

		if(IsValid(tabpanel))then
			tabpanel:Show()
			return
		end
        
        tabpanel = vgui.Create("DFrame")
        tabpanel:SetSize(scrw, scrh)
        tabpanel:Center()
        tabpanel:SetTitle("")
        tabpanel:ShowCloseButton(false)
        tabpanel:SetDraggable(false)
        tabpanel:MakePopup()
        tabpanel.Paint = function(self, w, h)
            draw.RoundedBox(0, 0, 0, w, 40, c_wwhite)
            draw.RoundedBox(0, 0, 40, w, h - 40, c_bubrown)
            draw.SimpleText(server, "Size.22", 17, 20, c_bubrown, 0, 1)
        end

        tabpanel:SetDrawOnTop(true)
		local oldHide = tabpanel.Hide
		tabpanel.Hide = function(self)
			oldHide(self)
		end

        tabpanel.panel = vgui.Create("DPanel", tabpanel)
        tabpanel.panel:SetSize(tabpanel:GetWide() - 54, 32)
        tabpanel.panel:SetPos(27, 58)
        tabpanel.panel.Paint = function(self, w, h)
            local iuser = "score/user.png"
            local iping = "score/wifi.png"
            paim.icon(17, h * 0.5 - 8, 16, 16, c_bwhite, iuser)
            draw.SimpleText(paim.Nick, "Size.19", 59, h * 0.5, c_bwhite, 0, 1)
            draw.SimpleText(paim.Job, "Size.19", w * 0.5 - 96, h * 0.5, c_bwhite, 0, 1)
            paim.icon(w - 34, h * 0.5 - 8, 16, 16, c_bwhite, iping)
        end

        tabpanel.scrlpnl = vgui.Create("DScrollPanel", tabpanel)
        tabpanel.scrlpnl:SetSize(tabpanel:GetWide(), tabpanel:GetTall() - 116)
        tabpanel.scrlpnl:SetPos(0, 90)
        tabpanel.scrlpnl.Paint = function() end

        tabpanel.scrlbar = tabpanel.scrlpnl:GetVBar()

        tabpanel.scrlbar.Paint = function(self, w, h)
            draw.RoundedBox(0, w - 4, 0, 4, h, c_bbrown)
        end

        tabpanel.scrlbar.btnUp.Paint = function(self, w, h)
            draw.RoundedBox(0, w - 4, 0, 4, h, c_bubrown)
        end

        tabpanel.scrlbar.btnGrip.Paint = function(self, w, h)
            draw.RoundedBox(0, w - 4, 0, 4, h, c_bwhite)
        end

        tabpanel.scrlbar.btnDown.Paint = function(self, w, h)
            draw.RoundedBox(0, w - 4, 0, 4, h, c_bubrown)
        end

        for k, v in pairs(players) do
            local nick = v:Nick()
            local job = team.GetName(v:Team())
            local ping = v:Ping()
    
            if #nick > 23 then
                nick = nick:Left(23) .. "..."
            end
    
            tabpanel.ply_pnl = tabpanel.scrlpnl:Add("DButton")
            tabpanel.ply_pnl:SetSize(tabpanel.scrlpnl:GetWide() - 54, 50)
            tabpanel.ply_pnl:SetPos(27, (k - 1) * 50)
            tabpanel.ply_pnl:SetText("")
            tabpanel.ply_pnl.Paint = function(self, w, h)
                if k % 2 == 0 then
                    draw.RoundedBox(0, 0, 0, w, h, c_brown)
                end
    
                if v == LocalPlayer() then
                    draw.RoundedBox(0, 0, 16, 2, 18, c_red)
                end
    
                draw.SimpleText(nick, "Size.22", 59, h * 0.5, c_white, 0, 1)
                draw.SimpleText(job, "Size.22", w * 0.5 - 96, h * 0.5, c_white, 0, 1)
                draw.SimpleText(ping, "Size.22", w - 18, h * 0.5, c_white, 2, 1)
            end
            tabpanel.ply_pnl.DoClick = function()
                if not IsValid(v) then return end

                local menu = DermaMenu()
                ContextMenu(menu, v)
                menu:Open()
            end
    
            tabpanel.ply_avtr = tabpanel.ply_pnl:Add("AvatarImage")
            tabpanel.ply_avtr:SetSize(32, 32)
            tabpanel.ply_avtr:SetPos(9, 9)
            tabpanel.ply_avtr:SetPlayer(v)
        end

		TabMN = tabpanel

        if(not IsValid(tabpanel))then return end

    end
    Tab()
end

hook.Add("ScoreboardShow","paim.score",function()
	Score()
	return false
end)

hook.Add("ScoreboardHide","paim.hide",function()
	CloseTabMenu()
end)

function CloseTabMenu()
    if(IsValid(TabMN))then
        TabMN:Hide()
    end
end

if(IsValid(TabMN))then
    TabMN:Remove()
end