
local PANEL = {}

function PANEL:Init()
	
	self.ReturnBtn = vgui.Create( "Button", self )
	self.ReturnBtn:SetText( "Back to Menu" )
	self.ReturnBtn.DoClick = function()
		
		self.ScreenManager:SetScreen( "MainScreen" )
		
	end
	
end

function PANEL:OnSelected()
	
	self:SetVisible( true )
	
	if( not ValidPanel( self.TutorialPanel ) ) then
		ErrorNoHalt( "Tut selected\n" )
		self.TutorialPanel = vgui.Create( "HTML", self )
		self.TutorialPanel:SetSize( 950, 600 )
		self.TutorialPanel:SetPos( self:GetWide() * 0.5 - 475, self:GetTall() * 0.5 - 300 )
		self.TutorialPanel:SetVisible( true )
		self.TutorialPanel.Paint = function( self )
			
			surface.SetDrawColor( 255, 255, 255, 255 )
			surface.DrawRect( 0, 0, self:GetWide(), self:GetTall() )
			
		end
		self.TutorialPanel:OpenURL( "http://www.profeasy.com/Settlers_Boardgame/" )
		self.TutorialPanel:StartAnimate( 100 )
	end
	
end

function PANEL:OnHidden()
	
	self:SetVisible( false )
	
end

function PANEL:PerformLayout()
	
	local w, h = ScrW(), ScrH()
	self.ReturnBtn:SetSize( 950, h * 0.1 )
	self.ReturnBtn:SetPos( w * 0.5 - 475, h * 0.55 + 300 )
	
end

PANEL.BackgroundTex = surface.GetTextureID( "sog/gui/hexes/tile_pasture" )

function PANEL:Paint()
	
	surface.SetTexture( self.BackgroundTex )
    surface.SetDrawColor( 255, 0, 0, 255 )
    surface.DrawPoly( self.HexPoly )
	
end
vgui.Register( "TutorialScreen", PANEL, "Panel" )