
local PANEL = {}

function PANEL:Init()
	
	self.GoBackBtn = vgui.Create( "Button", self )
	self.GoBackBtn:SetText( "Back" )
	self.GoBackBtn.DoClick = function()
		
		self.ScreenManager:SetScreen( "MainScreen" )
		
	end
	
	self.JoinGameBtn = vgui.Create( "Button", self )
	self.JoinGameBtn:SetText( "Join" )
	self.JoinGameBtn.DoClick = function()
		
		self.ScreenManager:SetScreen( "JoinScreen" )
		
	end
	
	self.CreateGameBtn = vgui.Create( "Button", self )
	self.CreateGameBtn:SetText( "Create" )
	self.CreateGameBtn.DoClick = function()
		
		self.ScreenManager:SetScreen( "CreateScreen" )
		
	end
	
	self.StatsBtn = vgui.Create( "Button", self )
	self.StatsBtn:SetText( "Statistics" )
	self.StatsBtn.DoClick = function()
		
		self.ScreenManager:SetScreen( "StatsScreen" )
		
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
	
	self.GoBackBtn:SetSize( self:GetWide() * 0.1, self:GetTall() * 0.8 )
	self.GoBackBtn:SetPos( self:GetWide() * 0.1, self:GetTall() * 0.1 )
	
	self.JoinGameBtn:SetSize( self:GetWide() * 0.35, self:GetTall() * 0.4 )
	self.JoinGameBtn:SetPos( self:GetWide() * 0.2, self:GetTall() * 0.1 )
	
	self.CreateGameBtn:SetSize( self:GetWide() * 0.35, self:GetTall() * 0.4 )
	self.CreateGameBtn:SetPos( self:GetWide() * 0.55, self:GetTall() * 0.3 )
	
	self.StatsBtn:SetSize( self:GetWide() * 0.35, self:GetTall() * 0.4 )
	self.StatsBtn:SetPos( self:GetWide() * 0.2, self:GetTall() * 0.5 )
	
end

function PANEL:Paint()
	
	surface.SetDrawColor( 255, 0, 255, 100 )
	surface.DrawRect( 0, 0, self:GetWide(), self:GetTall() )
	
end
vgui.Register( "PlayScreen", PANEL, "Panel" )