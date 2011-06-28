
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
	
	self:SetSize( ScrW(), ScrH() )
	
	self.GoBackBtn:SetSize( self:GetWide() * 0.8, self:GetTall() * 0.1 )
	self.GoBackBtn:SetPos( self:GetWide() * 0.1, self:GetTall() * 0.8 )
	
end

function PANEL:Paint()
	
	surface.SetDrawColor( 0, 255, 255, 100 )
	surface.DrawRect( 0, 0, self:GetWide(), self:GetTall() )
	
end
vgui.Register( "JoinScreen", PANEL, "Panel" )