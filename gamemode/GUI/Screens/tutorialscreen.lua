
local PANEL = {}

function PANEL:Init()
	
	self.ReturnBtn = vgui.Create( "Button", self )
	self.ReturnBtn:SetText( "Back to Menu" )
	self.ReturnBtn.DoClick = function()
		
		self.ScreenManager:SetScreen( "MainScreen" )
		
	end
	
	self:SetVisible( false )
	
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
	
	self:SetSize( ScrW(), ScrH() )
	
	self.ReturnBtn:SetSize( 950, self:GetTall() * 0.1 )
	self.ReturnBtn:SetPos( self:GetWide() * 0.5 - 475, self:GetTall() * 0.55 + 300 )
	
end

function PANEL:Paint()
	
	surface.SetDrawColor( 0, 255, 0, 100 )
	surface.DrawRect( 0, 0, self:GetWide(), self:GetTall() )
	
end
vgui.Register( "TutorialScreen", PANEL, "Panel" )