
c_wwhite = Color(230, 230, 230)
c_bubrown  = Color(30, 30, 30)
c_bblack  = Color(30, 30, 30,180)
c_bwhite = Color(109, 109, 109)
c_bbrown = Color(45, 45, 45)
c_brown = Color(33, 33, 33)
c_red = Color(255, 102, 51)
c_white = Color(255, 255, 255)

function paim.icon( x, y, w, h, col, mat )
	surface.SetDrawColor( col )
	surface.SetMaterial( Material(mat) )
	surface.DrawTexturedRect( x, y, w, h )
end

function paim.drawblur(panel, amount)
    local blur = Material("pp/blurscreen")
    local scrW, scrH = ScrW(), ScrH()
    surface.SetDrawColor(255, 255, 255)
    surface.SetMaterial(blur)
    for i = 1, 3 do
        blur:SetFloat("$blur", (i / 3) * (amount or 6))
        blur:Recompute()
        render.UpdateScreenEffectTexture()
        surface.DrawTexturedRect(0 , 0, scrW, scrH)
    end
end

surface.CreateFont( "Size.22", {
	font = "Arial",
	extended = true,
	size = 22,
	weight = 500,
} )

surface.CreateFont( "Size.19", {
	font = "Arial",
	extended = true,
	size = 19,
	weight = 500,
} )