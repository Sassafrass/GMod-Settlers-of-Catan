
local PANEL = {}

function PANEL:Init()
	
	self.CloseBtn = vgui.Create( "Button", self )
	self.CloseBtn:SetText( "Close (Temporary Button)" )
	self.CloseBtn:SizeToContents()
	self.CloseBtn:SetSize( self.CloseBtn:GetWide() * 1.1, self.CloseBtn:GetTall() * 1.1 )
	self.CloseBtn.DoClick = function()
		
		self.ScreenManager:Remove()
		
	end
	
end

function PANEL:OnSelected()
	
	self:SetVisible( true )
	
end

function PANEL:OnHidden()
	
	self:SetVisible( false )
	
end

function PANEL:PerformLayout()
	
end

PANEL.BackgroundTex = surface.GetTextureID( "sog/gui/hexes/tile_fields" )

function PANEL:Paint()
	
	surface.SetTexture( self.BackgroundTex )
    surface.SetDrawColor( 0, 255, 0, 255 )
    surface.DrawPoly( self.HexPoly )
	
end
vgui.Register( "RoomScreen", PANEL, "Panel" )