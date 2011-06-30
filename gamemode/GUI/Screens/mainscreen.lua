
local PANEL = {}

function PANEL:Init()
	
	self.DisconnectBtn = vgui.Create( "Button", self )
	self.DisconnectBtn:SetText( "Disconnect" )
	self.DisconnectBtn.DoClick = function()
		
		Derma_Query("Are you sure you want to disconnect?", "Wait!",
			"Yes", function() RunConsoleCommand( "disconnect" ) end,
			"No", function() end
		)
		
	end
	
	self.PlayNowBtn = vgui.Create( "Button", self )
	self.PlayNowBtn:SetText( "Play Now" )
	self.PlayNowBtn.DoClick = function()
		
		self.ScreenManager:SetScreen( "PlayScreen" )
		
	end
	
	self.CustomizeBtn = vgui.Create( "Button", self )
	self.CustomizeBtn:SetText( "Customize" )
	self.CustomizeBtn.DoClick = function()
		
		self.ScreenManager:SetScreen( "CustomizeScreen" )
		
	end
	
	self.LearnBtn = vgui.Create( "Button", self )
	self.LearnBtn:SetText( "Learn How to Play" )
	self.LearnBtn.DoClick = function()
		
		self.ScreenManager:SetScreen( "TutorialScreen" )
		
	end
	
	self.CloseBtn = vgui.Create( "Button", self )
	self.CloseBtn:SetText( "Close (Temporary Button)" )
	self.CloseBtn:SizeToContents()
	self.CloseBtn:SetSize( self.CloseBtn:GetWide() + 20, self.CloseBtn:GetTall() + 10 )
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
	
	local centerx, centery = self:GetWide()*0.5, self:GetTall()*0.5
	local w, h = ScrW(), ScrH()
	self.DisconnectBtn:SetSize( w * 0.1, h * 0.8 )
	self.DisconnectBtn:SetPos( centerx - w*0.5 + w * 0.1, centery - h*0.5 + h * 0.1 )
	
	self.LearnBtn:SetSize( w * 0.3, h * 0.4 )
	self.LearnBtn:SetPos( centerx - w*0.5 + w * 0.2, centery - h*0.5 + h * 0.1 )
	
	self.CustomizeBtn:SetSize( w * 0.3, h * 0.4 )
	self.CustomizeBtn:SetPos( centerx - w*0.5 + w * 0.2, centery - h*0.5 + h * 0.5 )
	
	self.PlayNowBtn:SetSize( w * 0.4, h * 0.8 )
	self.PlayNowBtn:SetPos( centerx - w*0.5 + w * 0.5, centery - h*0.5 + h * 0.1 )
	
end

PANEL.BackgroundTex = surface.GetTextureID( "sog/gui/hexes/tile_desert" )

function PANEL:Paint()
	
	surface.SetTexture( self.BackgroundTex )
    surface.SetDrawColor( 255, 255, 0, 255 )
    surface.DrawPoly( self.HexPoly )
	
end
vgui.Register( "MainScreen", PANEL, "Panel" )