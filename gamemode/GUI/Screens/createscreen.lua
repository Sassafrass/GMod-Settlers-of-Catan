
local PANEL = {}

surface.CreateFont ("Verdana", ScreenScale(30), 400, true, false, "CatanFont0")
surface.CreateFont ("Verdana", ScreenScale(20), 400, true, false, "CatanFont1")
surface.CreateFont ("Verdana", ScreenScale(16), 400, true, false, "CatanFont2")
surface.CreateFont ("Verdana", ScreenScale(12), 400, true, false, "CatanFont3")
surface.CreateFont ("Verdana", ScreenScale(10), 400, true, false, "CatanFont4")
surface.CreateFont ("Verdana", ScreenScale(8), 400, true, false, "CatanFont5")

local function panelTextChangedFunc(p)
		
	if( p:GetValue():len() > p.MaxChars ) then
		cpos = p:GetCaretPos()
		p:SetValue( p.lastValue:sub( 1, math.min( p.lastValue:len(), p.MaxChars ) ) )
		p:SetCaretPos( cpos-1 )
	end
	
	for i = 1, 5 do
		surface.SetFont( "CatanFont"..i )
		local w, h = surface.GetTextSize( p:GetValue() )
		if( w < p:GetWide() * 0.9 ) then
			p:SetFont( "CatanFont"..i )
			break
		end
	end
	
	p.lastValue = p:GetValue()
	
end

function PANEL:Init()
	
	self.GoBackBtn = vgui.Create( "Button", self )
	self.GoBackBtn:SetText( "Back" )
	self.GoBackBtn.DoClick = function()
		
		self.ScreenManager:SetScreen( "PlayScreen" )
		
	end
	
	self.Container = vgui.Create( "Panel", self )
	self.Container:SetKeyboardInputEnabled( true )
	self.Container:SetMouseInputEnabled( true )
	self.Container.Paint = function( p )
		surface.SetDrawColor( 0, 0, 0, 10 )
		surface.DrawRect( 0, 0, p:GetWide(), p:GetTall() )
	end
	
	self.Container.Fields = {}
	
	--TITLE PANEL
	local panel = vgui.Create( "Panel", self.Container )
	panel.Paint = function( p )
		surface.SetDrawColor( 0, 0, 0, 10 )
		surface.DrawRect( 0, 0, p:GetWide(), p:GetTall() )
	end
	panel.label = vgui.Create( "DLabel", panel )
	panel.label:SetText( "Create Game" )
	panel.label:SetFont( "CatanFont0" )
	panel.label:SetExpensiveShadow( 1, Color( 0, 0, 0, 190 ) )
	panel.Resize = function()
		
		panel.label:SizeToContents()
		panel.label:SetPos( panel:GetWide() * 0.01, self.Container:GetTall() * 0.01 )
		
		panel:SetTall( panel.label:GetTall() + self.Container:GetTall() * 0.02 )
		
	end
	
	table.insert( self.Container.Fields, panel )
	------------------------
	--GAME NAME PANEL
	local panel = vgui.Create( "Panel", self.Container )
	panel.Paint = function( p )
		surface.SetDrawColor( 0, 0, 0, 10 )
		surface.DrawRect( 0, 0, p:GetWide(), p:GetTall() )
	end
	panel.OnGetFocus = function( p )
		p.input:RequestFocus()
	end
	panel.OnMousePressed = function( p )
		p.input:RequestFocus()
		p.input:SelectAll()
	end
	panel.label = vgui.Create( "DLabel", panel )
	panel.label:SetText( "Game Name:" )
	panel.label:SetFont( "CatanFont2" )
	panel.input = vgui.Create( "DTextEntry", panel )
	panel.input:SetText( "Settlers of Catan" )
	panel.input:SetFont( "CatanFont1" )
	panel.input:SetAllowNonAsciiCharacters( false )
	panel.input.MaxChars = 40
	panel.input.OnTextChanged = panelTextChangedFunc
	panel.input.OnKeyCodeTyped = function( p, key )
		if( key == KEY_TAB ) then
			timer.Simple(0,function()self.PasswordEntry:RequestFocus()end)
		end
	end
	self.GameNameEntry = panel.input
	panel.Resize = function()
		
		panel.label:SizeToContents()
		panel.label:SetPos( panel:GetWide() * 0.27 - panel.label:GetWide(), self.Container:GetTall() * 0.01 )
		
		panel.input:SetWide( panel:GetWide() * 0.7 )
		panel.input:SetPos( panel:GetWide() * 0.29, self.Container:GetTall() * 0.01 )
		panel.input:SetTall( panel.label:GetTall() )
		
		panel:SetTall( panel.label:GetTall() + self.Container:GetTall() * 0.02 )
		
	end
	
	table.insert( self.Container.Fields, panel )
	------------------------
	--PASSWORD PANEL
	local panel = vgui.Create( "Panel", self.Container )
	panel.Paint = function( p )
		surface.SetDrawColor( 0, 0, 0, 10 )
		surface.DrawRect( 0, 0, p:GetWide(), p:GetTall() )
	end
	panel.OnGetFocus = function( p )
		p.input:RequestFocus()
	end
	panel.OnMousePressed = function( p )
		p.input:RequestFocus()
		p.input:SelectAll()
	end
	panel.label = vgui.Create( "DLabel", panel )
	panel.label:SetText( "Password:" )
	panel.label:SetFont( "CatanFont2" )
	panel.input = vgui.Create( "DTextEntry", panel )
	panel.input:SetText( "" )
	panel.input:SetFont( "CatanFont1" )
	panel.input:SetAllowNonAsciiCharacters( false )
	panel.input.MaxChars = 10
	panel.input.OnTextChanged = panelTextChangedFunc
	panel.input.OnKeyCodeTyped = function( p, key )
		if( key == KEY_TAB ) then
			self.GameTypeChoice:RequestFocus()
		end
	end
	self.PasswordEntry = panel.input
	panel.Resize = function()
		
		panel.label:SizeToContents()
		panel.label:SetPos( panel:GetWide() * 0.27 - panel.label:GetWide(), self.Container:GetTall() * 0.01 )
		
		panel.input:SetWide( panel:GetWide() * 0.7 )
		panel.input:SetPos( panel:GetWide() * 0.29, self.Container:GetTall() * 0.01 )
		panel.input:SetTall( panel.label:GetTall() )
		
		panel:SetTall( panel.label:GetTall() + self.Container:GetTall() * 0.02 )
		
	end
	
	table.insert( self.Container.Fields, panel )
	------------------------
	--DIVIDER PANEL
	local panel = vgui.Create( "Panel", self.Container )
	panel.Paint = function( p )
		surface.SetDrawColor( 0, 0, 0, 10 )
		surface.DrawRect( 0, 0, p:GetWide(), p:GetTall() )
	end
	panel.Resize = function()
		
		panel:SetTall( self.Container:GetTall() * 0.02 )
		
	end
	
	table.insert( self.Container.Fields, panel )
	------------------------
	--GAMETYPE PANEL
	local panel = vgui.Create( "Panel", self.Container )
	panel.Paint = function( p )
		surface.SetDrawColor( 0, 0, 0, 10 )
		surface.DrawRect( 0, 0, p:GetWide(), p:GetTall() )
	end
	panel.OnGetFocus = function( p )
		p.input:RequestFocus()
	end
	panel.OnMousePressed = function( p )
		p.input:RequestFocus()
		p.input:SelectAll()
	end
	panel.label = vgui.Create( "DLabel", panel )
	panel.label:SetText( "Game Type:" )
	panel.label:SetFont( "CatanFont2" )
	panel.input = vgui.Create( "DMultiChoice", panel )
	panel.input:AddChoice( "Settlers of Catan: Original" )
	panel.input:ChooseOptionID( 1 )
	panel.input:SetEditable( false )
	panel.input.TextEntry:SetFont( "CatanFont2" )
	panel.input.OnKeyCodeTyped = function( p, key )
		if( key == KEY_TAB ) then
			self.MaxPlayersChoice:RequestFocus()
		end
	end
	self.GameTypeChoice = panel.input
	panel.Resize = function()
		
		panel.label:SizeToContents()
		panel.label:SetPos( panel:GetWide() * 0.27 - panel.label:GetWide(), self.Container:GetTall() * 0.01 )
		
		panel.input:SetWide( panel:GetWide() * 0.7 )
		panel.input:SetPos( panel:GetWide() * 0.29, self.Container:GetTall() * 0.01 )
		panel.input:SetTall( panel.label:GetTall() )
		
		panel:SetTall( panel.label:GetTall() + self.Container:GetTall() * 0.02 )
		
	end
	
	table.insert( self.Container.Fields, panel )
	------------------------
	--MAX PLAYERS PANEL
	local panel = vgui.Create( "Panel", self.Container )
	panel.Paint = function( p )
		surface.SetDrawColor( 0, 0, 0, 10 )
		surface.DrawRect( 0, 0, p:GetWide(), p:GetTall() )
	end
	panel.OnGetFocus = function( p )
		p.input:RequestFocus()
	end
	panel.OnMousePressed = function( p )
		p.input:RequestFocus()
		p.input:SelectAll()
	end
	panel.label = vgui.Create( "DLabel", panel )
	panel.label:SetText( "Max Players:" )
	panel.label:SetFont( "CatanFont2" )
	panel.input = vgui.Create( "DMultiChoice", panel )
	panel.input:AddChoice( "2" )
	panel.input:AddChoice( "3" )
	panel.input:AddChoice( "4" )
	panel.input:AddChoice( "5" )
	panel.input:AddChoice( "6" )
	panel.input:ChooseOptionID( 5 )
	panel.input:SetEditable( false )
	panel.input.TextEntry:SetFont( "CatanFont2" )
	self.MaxPlayersChoice = panel.input
	panel.Resize = function()
		
		panel.label:SizeToContents()
		panel.label:SetPos( panel:GetWide() * 0.27 - panel.label:GetWide(), self.Container:GetTall() * 0.01 )
		
		panel.input:SetWide( panel:GetWide() * 0.7 )
		panel.input:SetPos( panel:GetWide() * 0.29, self.Container:GetTall() * 0.01 )
		panel.input:SetTall( panel.label:GetTall() )
		
		panel:SetTall( panel.label:GetTall() + self.Container:GetTall() * 0.02 )
		
	end
	
	table.insert( self.Container.Fields, panel )
	------------------------
	--DIVIDER PANEL
	local panel = vgui.Create( "Panel", self.Container )
	panel.Paint = function( p )
		surface.SetDrawColor( 0, 0, 0, 10 )
		surface.DrawRect( 0, 0, p:GetWide(), p:GetTall() )
	end
	panel.Resize = function()
		
		panel:SetTall( self.Container:GetTall() * 0.02 )
		
	end
	
	table.insert( self.Container.Fields, panel )
	------------------------
	--CREATE BUTTON PANEL
	local panel = vgui.Create( "Panel", self.Container )
	panel.Paint = function( p )
		surface.SetDrawColor( 0, 0, 0, 10 )
		surface.DrawRect( 0, 0, p:GetWide(), p:GetTall() )
	end
	panel.OnGetFocus = function( p )
		p.input:RequestFocus()
	end
	panel.button = vgui.Create( "DButton", panel )
	panel.button:SetText( "" )
	panel.button.label = vgui.Create( "DLabel", panel.button )
	panel.button.label:SetText( "Create" )
	panel.button.label:SetFont( "CatanFont2" )
	self.CreateBtn = panel.button
	panel.button.DoClick = function()
		
		self:CreateGame()
		
	end
	
	panel.Resize = function()
		
		panel.button.label:SizeToContents()
		panel.button:SetSize( panel.button.label:GetWide() * 1.25, panel.button.label:GetTall() * 1.25 )
		panel.button.label:Center()
		panel.button:SetPos( panel:GetWide() * 0.95 - panel.button:GetWide(), self.Container:GetTall() * 0.01 )
		
		panel:SetTall( panel.button:GetTall() + self.Container:GetTall() * 0.02 )
		
	end
	
	table.insert( self.Container.Fields, panel )
	
end

function PANEL:OnSelected()
	
	self:SetVisible( true )
	
	self.Container.Fields[ 2 ]:RequestFocus()
	
end

function PANEL:OnHidden()
	
	self:SetVisible( false )
	
end

function PANEL:PerformLayout()
	
	local w, h = ScrW(), ScrH()
	self.GoBackBtn:SetSize( w * 0.1, h * 0.8 )
	self.GoBackBtn:SetPos( w * 0.1, h * 0.1 )
	
	self.Container:SetSize( w * 0.7, h * 0.8 )
	self.Container:SetPos( w*0.2, h * 0.1 )
	
	local px, py = w * 0.01, h * 0.01
	
	for i, panel in ipairs( self.Container.Fields ) do
		
		panel:SetWide( self.Container:GetWide() - px * 2 )
		panel:SetPos( px, py )
		panel:Resize()
		
		py = py + panel:GetTall()
		
	end
	
end

function PANEL:CreateGame()
	
	--TODO: Checks and stuff
	RunConsoleCommand( "sog_create", self.GameNameEntry:GetValue(), self.PasswordEntry:GetValue(), self.MaxPlayersChoice:GetValue() )
	self.CreateBtn:SetDisabled(true)
	self.ScreenManager:SetScreen( "RoomScreen" )
	
end

PANEL.BackgroundTex = surface.GetTextureID( "sog/gui/hexes/tile_fields" )

function PANEL:Paint()
	
	surface.SetTexture( self.BackgroundTex )
    surface.SetDrawColor( 0, 255, 0, 255 )
    surface.DrawPoly( self.HexPoly )
	
end
vgui.Register( "CreateScreen", PANEL, "Panel" )

if( ScreenManager ) then
	
	for i, screen in pairs( ScreenManager.Screens ) do
		
		if( screen.name == "CreateScreen" ) then
			
			local s = vgui.Create( "CreateScreen", ScreenManager )
			s.name = screen.name
			s.scrX = screen.scrX
			s.scrY = screen.scrY
			s.ScreenManager = ScreenManager
			ScreenManager.Screens[ i ] = s
			screen:Remove()
			ScreenManager:InvalidateLayout()
			
			return
			
		end
		
	end
	
end