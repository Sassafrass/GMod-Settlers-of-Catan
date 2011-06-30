
local PANEL = {}

function PANEL:Init()
	
	self.GoBackBtn = vgui.Create( "Button", self )
	self.GoBackBtn:SetText( "Back" )
	self.GoBackBtn.DoClick = function()
		
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
	self.GoBackBtn:SetSize( w * 0.8, h * 0.1 )
	self.GoBackBtn:SetPos( w * 0.1, h * 0.8 )
	
end

PANEL.BackgroundTex = surface.GetTextureID( "sog/gui/hexes/tile_fields" )

function PANEL:Paint()
	
	surface.SetTexture( self.BackgroundTex )
    surface.SetDrawColor( 0, 255, 0, 255 )
    surface.DrawPoly( self.HexPoly )
	
end
vgui.Register( "JoinScreen", PANEL, "Panel" )