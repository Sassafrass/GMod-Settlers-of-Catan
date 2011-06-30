local PANEL = {}

PANEL.CTILE_HEIGHT = ScrW()
PANEL.CTILE_HALF_HEIGHT = PANEL.CTILE_HEIGHT * 0.5
PANEL.CTILE_NARROW_WIDTH = PANEL.CTILE_HEIGHT / math.cos( math.rad( 30 ) )
PANEL.CTILE_SIZE = PANEL.CTILE_NARROW_WIDTH * 0.5
PANEL.CTILE_SEGMENT = PANEL.CTILE_SIZE * math.sin( math.rad( 30 ) )
PANEL.CTILE_WIDTH = (3*PANEL.CTILE_HALF_HEIGHT) / (2*math.sin( math.rad( 60 ) ))

function PANEL:TileToWorld( PosX, PosY )
	
	local wx = PosX * self.CTILE_WIDTH
	local wy = (2*PosY - PosX) * self.CTILE_HALF_HEIGHT
	
	return wx, wy
	
end

function PANEL:Init()
	
	self.Screens = {}
	-- self:NoClipping( true )
	self:AddScreen( "TutorialScreen", 2, 2 )
	self:AddScreen( "CustomizeScreen", 2, 4 )
	self:AddScreen( "MainScreen", 2, 3 )
	self:AddScreen( "PlayScreen", 3, 3 )
	self:AddScreen( "JoinScreen", 3, 2 )
	self:AddScreen( "CreateScreen", 4, 3 )
	self:AddScreen( "StatsScreen", 3, 4 )
	self:AddScreen( "RoomScreen", 4, 1 )
	
	self:SetScreen( "MainScreen", true )
	
	self:InvalidateLayout()
	
end

function PANEL:PerformLayout()
	
	self:SetSize( self.CTILE_HEIGHT * 5, self.CTILE_HEIGHT * 4 )
	
	for i = 1, #self.Screens do
		
		local screen = self.Screens[ i ]
		local px, py = self:TileToWorld( screen.scrX, screen.scrY )
		screen:SetSize( self.CTILE_NARROW_WIDTH, self.CTILE_HEIGHT )
		screen:SetPos( px - self.CTILE_SIZE, py - self.CTILE_HALF_HEIGHT )
		
	end
	
end

function PANEL:AddScreen( ScreenName, scrX, scrY )
	
	if( not self.HexPoly ) then
		local centerx = self.CTILE_SIZE
		local centery = self.CTILE_HALF_HEIGHT
		self.HexPoly = {
			{
				x = centerx - self.CTILE_SIZE - 1,
				y = centery,
				u = 0,
				v = 0.5
			},
			{
				x = centerx - self.CTILE_SEGMENT - 1,
				y = centery - self.CTILE_HALF_HEIGHT - 1,
				u = 0.26,
				v = 0.06
			},
			{
				x = centerx + self.CTILE_SEGMENT + 1,
				y = centery - self.CTILE_HALF_HEIGHT - 1,
				u = 0.75,
				v = 0.06
			},
			{
				x = centerx + self.CTILE_SIZE + 1,
				y = centery,
				u = 1,
				v = 0.5
			},
			{
				x = centerx + self.CTILE_SEGMENT + 1,
				y = centery + self.CTILE_HALF_HEIGHT + 1,
				u = 0.75,
				v = 0.93
			},
			{
				x = centerx - self.CTILE_SEGMENT - 1,
				y = centery + self.CTILE_HALF_HEIGHT + 1,
				u = 0.26,
				v = 0.93
			},
			{
				x = centerx - self.CTILE_SIZE - 1,
				y = centery,
				u = 0,
				v = 0.5
			}
		}
	end
	
	local screen = vgui.Create( ScreenName, self )
	if( screen ) then
		screen.ScreenManager = self
		screen.name = ScreenName
		screen.scrX = scrX
		screen.scrY = scrY
		screen.HexPoly = self.HexPoly
		self.Screens[ #self.Screens + 1 ] = screen
	end
	
end

function PANEL:SetScreen( ScreenName, bNoTween )
	
	for i = 1, #self.Screens do
		
		local screen = self.Screens[ i ]
		if( screen.name == ScreenName ) then
			if( bNoTween ) then
				self:SetPos( self:TileToWorld( -screen.scrX, -screen.scrY ) )
			end
			self.ScreenID = i
			screen:OnSelected()
			return true
		end
		
	end
	
end

function PANEL:CalcView()
	
	if( not GAMEMODE ) then return end
	if( not GAMEMODE.ViewAngle ) then return end
	
	if( self:GetScreen() == "RoomScreen" ) then
		
		if( self.lastCalcView ) then
			GAMEMODE.ViewAngle.y = GAMEMODE.ViewAngle.y + (RealTime() - self.lastCalcView)
		end
		GAMEMODE.ViewDistance = Lerp( 0.1, GAMEMODE.ViewDistance, GAMEMODE.MaxViewDistance )
		
	else
	
		GAMEMODE.ViewDistance = Lerp( 0.1, GAMEMODE.ViewDistance, 250 )
		
	end
	
	self.lastCalcView = RealTime()
	
end

function PANEL:GetScreen()
	
	return self.Screens[ self.ScreenID ].name
	
end

function PANEL:Think()
	
	local x, y = self:GetPos()
	local screen = self.Screens[ self.ScreenID ]
	if( screen ) then
		local px, py = self:TileToWorld( screen.scrX, screen.scrY )
		px = px - ScrW() * 0.5
		py = py - ScrH() * 0.5
		self:SetPos( math.Approach( x, -px, self.CTILE_WIDTH * 0.05  ), math.Approach( y, -py, self.CTILE_HEIGHT * 0.025  ))
	end
	
	for i = 1, #self.Screens do
		
		local screen = self.Screens[ i ]
		local x, y = self:LocalToScreen( screen:GetPos() )
		if( x < ScrW() and x + ScrW() > 0 and y < ScrH() and y + ScrH() > 0 ) then
			screen:SetVisible( true )
		elseif( screen:IsVisible() ) then
			-- screen:OnHidden()
		end
		
	end
	
	if( ValidPanel( GAMEMODE.ChatBox ) ) then
		
		GAMEMODE.ChatBox:SetVisible( false )
		
	end
	
end

if( ValidPanel( ScreenManager ) ) then
	include( "Screens/tutorialscreen.lua" )
	include( "Screens/mainscreen.lua" )
	include( "Screens/playscreen.lua" )
	include( "Screens/customizescreen.lua" )
	include( "Screens/statsscreen.lua" )
	include( "Screens/createscreen.lua" )
	include( "Screens/joinscreen.lua" )
	include( "Screens/roomscreen.lua" )
	ScreenManager:Remove()
end
ScreenManager = vgui.CreateFromTable( vgui.RegisterTable( PANEL, "EditablePanel" ) )
ScreenManager:MakePopup()
-- ScreenManager:DoModal()
ScreenManager:SetFocusTopLevel(true)