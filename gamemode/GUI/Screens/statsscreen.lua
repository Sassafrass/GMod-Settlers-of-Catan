
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
	
	self:SetSize( ScrW(), ScrH() )
	
	self.ReturnBtn:SetSize( self:GetWide() * 0.8, self:GetTall() * 0.1 )
	self.ReturnBtn:SetPos( self:GetWide() * 0.1, self:GetTall() * 0.1 )
	
end

function PANEL:Paint()
	
	surface.SetDrawColor( 255, 255, 0, 100 )
	surface.DrawRect( 0, 0, self:GetWide(), self:GetTall() )
	
end
vgui.Register( "StatsScreen", PANEL, "Panel" )