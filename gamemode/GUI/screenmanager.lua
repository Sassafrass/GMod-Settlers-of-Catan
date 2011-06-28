local PANEL = {}

function PANEL:Init()
	
	self.Screens = {}
	self.ScreenID = 0
	self:AddScreen( "TutorialScreen", 0, 1 )
	self:AddScreen( "MainScreen", 1, 1 )
	self:AddScreen( "PlayScreen", 2, 1 )
	
	self:SetScreen( "MainScreen", true )
	
	self:InvalidateLayout()
	
end

function PANEL:PerformLayout()
	
	self:SetSize( ScrW() * 3, ScrH() * 3 )
	
	for i = 1, #self.Screens do
		
		local screen = self.Screens[ i ]
		screen:SetPos( ScrW() * screen.scrX, ScrH() * screen.scrY )
		
	end
	
end

function PANEL:AddScreen( ScreenName, scrX, scrY )
	
	local screen = vgui.Create( ScreenName, self )
	screen.ScreenManager = self
	screen.name = ScreenName
	screen.scrX = scrX
	screen.scrY = scrY
	self.Screens[ #self.Screens + 1 ] = screen
	
end

function PANEL:SetScreen( ScreenName, bNoTween )
	
	for i = 1, #self.Screens do
		
		local screen = self.Screens[ i ]
		if( screen.name == ScreenName ) then
			if( bNoTween ) then
				self:SetPos( ScrW() * -screen.scrX, ScrH() * -screen.scrY )
			end
			self.ScreenID = i
			screen:OnSelected()
			return true
		end
		
	end
	
end

function PANEL:Think()
	
	local x, y = self:GetPos()
	local screen = self.Screens[ self.ScreenID ]
	if( screen ) then
		self:SetPos( math.Approach( x, ScrW() * -screen.scrX, ScrW() * 0.05  ), math.Approach( y, ScrH() * -screen.scrY, ScrH() * 0.05  ))
	end
	
	for i = 1, #self.Screens do
		
		local screen = self.Screens[ i ]
		local x, y = self:LocalToScreen( screen:GetPos() )
		if( x < ScrW() and x + ScrW() > 0 and y < ScrH() and y + ScrH() > 0 ) then
			screen:SetVisible( true )
		elseif( screen:IsVisible() ) then
			screen:OnHidden()
		end
		
	end
	
end

ScreenManager = vgui.CreateFromTable( vgui.RegisterTable( PANEL, "Panel" ) )