
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
	
	local w, h = ScrW(), ScrH()
	self.GoBackBtn:SetSize( w * 0.1, h * 0.8 )
	self.GoBackBtn:SetPos( w * 0.1, h * 0.1 )
	
	self.JoinGameBtn:SetSize( w * 0.35, h * 0.4 )
	self.JoinGameBtn:SetPos( w * 0.2, h * 0.1 )
	
	self.CreateGameBtn:SetSize( w * 0.35, h * 0.4 )
	self.CreateGameBtn:SetPos( w * 0.55, h * 0.3 )
	
	self.StatsBtn:SetSize( w * 0.35, h * 0.4 )
	self.StatsBtn:SetPos( w * 0.2, h * 0.5 )
	
end

PANEL.BackgroundTex = surface.GetTextureID( "sog/gui/hexes/tile_forest" )

function PANEL:Paint()
	
	surface.SetTexture( self.BackgroundTex )
    surface.SetDrawColor( 255, 0, 255, 255 )
    surface.DrawPoly( self.HexPoly )
	
end
vgui.Register( "PlayScreen", PANEL, "Panel" )