
local PANEL = {}

function PANEL:Init()
	
	self.PlayNowBtn = vgui.Create( "Button", self )
	self.PlayNowBtn:SetText( "Play Now" )
	self.PlayNowBtn.DoClick = function()
		
		self.ScreenManager:SetScreen( "PlayScreen" )
		
	end
	
	self.LearnBtn = vgui.Create( "Button", self )
	self.LearnBtn:SetText( "Learn How to Play" )
	self.LearnBtn.DoClick = function()
		
		self.ScreenManager:SetScreen( "TutorialScreen" )
		
	end
	
end

function PANEL:OnSelected()
	
	self:SetVisible( true )
	
end

function PANEL:OnHidden()
	
	self:SetVisible( false )
	
end

function PANEL:PerformLayout()
	
	self:SetSize( ScrW(), ScrH() )
	
	self.LearnBtn:SetSize( self:GetWide() * 0.4, self:GetTall() * 0.8 )
	self.LearnBtn:SetPos( self:GetWide() * 0.1, self:GetTall() * 0.1 )
	
	self.PlayNowBtn:SetSize( self:GetWide() * 0.4, self:GetTall() * 0.8 )
	self.PlayNowBtn:SetPos( self:GetWide() * 0.5, self:GetTall() * 0.1 )
	
end

function PANEL:Paint()
	
	surface.SetDrawColor( 255, 0, 0, 100 )
	surface.DrawRect( 0, 0, self:GetWide(), self:GetTall() )
	
end
vgui.Register( "MainScreen", PANEL, "Panel" )