
local PANEL = {}

function PANEL:Init()
	
	self.ReturnBtn = vgui.Create( "Button", self )
	self.ReturnBtn:SetText( "Back to Menu" )
	self.ReturnBtn.DoClick = function()
		
		self.ScreenManager:SetScreen( "PlayScreen" )
		
	end
	
end

function PANEL:OnSelected()
	
	self:SetVisible( true )
	
end

function PANEL:OnHidden()
	
	self:SetVisible( false )
	
end

function PANEL:PerformLayout()
	
	local w, h = ScrW(), ScrH()
	
	self.ReturnBtn:SetSize( w * 0.8, h * 0.1 )
	self.ReturnBtn:SetPos( w * 0.1, h * 0.1 )
	
end

PANEL.BackgroundTex = surface.GetTextureID( "sog/gui/hexes/tile_hills" )

function PANEL:Paint()
	
	surface.SetTexture( self.BackgroundTex )
    surface.SetDrawColor( 0, 255, 0, 255 )
    surface.DrawPoly( self.HexPoly )
	
end
vgui.Register( "StatsScreen", PANEL, "Panel" )