
local PANEL = {}

function PANEL:Init()
	
	self.PlayNowBtn = vgui.Create( "Button", self )
	self.PlayNowBtn:SetText( "Play Now" )
	self.PlayNowBtn.DoClick = function()
		
		self.ScreenManager:SetScreen( "PlayScreen" )
		
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
	
	-- if( ValidPanel( self.TutorialPanel ) ) then	
		
		-- self.TutorialPanel:Remove()
		
	-- end
	
	self:SetVisible( false )
	
end

function PANEL:PerformLayout()
	
	self:SetSize( ScrW(), ScrH() )
	
	self.PlayNowBtn:SetSize( self:GetWide() * 0.1, 768 )
	self.PlayNowBtn:SetPos( self:GetWide() * 0.5 + 512, self:GetTall() * 0.5 - 384 )
	
end

function PANEL:Paint()
	
	surface.SetDrawColor( 0, 255, 0, 100 )
	surface.DrawRect( 0, 0, self:GetWide(), self:GetTall() )
	
end
vgui.Register( "TutorialScreen", PANEL, "Panel" )