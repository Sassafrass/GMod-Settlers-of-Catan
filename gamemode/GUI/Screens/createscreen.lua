
local PANEL = {}

surface.CreateFont ("Verdana", ScreenScale(30), 400, true, false, "CatanFont0")
surface.CreateFont ("Verdana", ScreenScale(20), 400, true, false, "CatanFont1")
surface.CreateFont ("Verdana", ScreenScale(16), 400, true, false, "CatanFont2")
surface.CreateFont ("Verdana", ScreenScale(12), 400, true, false, "CatanFont3")
surface.CreateFont ("Verdana", ScreenScale(10), 400, true, false, "CatanFont4")
surface.CreateFont ("Verdana", ScreenScale(8), 400, true, false, "CatanFont5")

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
	
	local panel = vgui.Create( "Panel", self.Container )
	panel.Paint = function( p )
		surface.SetDrawColor( 0, 0, 0, 10 )
		surface.DrawRect( 0, 0, p:GetWide(), p:GetTall() )
	end
	panel.label = vgui.Create( "DLabel", panel )
	panel.label:SetText( "Create Game" )
	panel.label:SetFont( "CatanFont0" )
	
	table.insert( self.Container.Fields, panel )
	
	local panel = vgui.Create( "Panel", self.Container )
	panel:SetTabPosition( 100 )
	panel.OnGetFocus = function( p )
		ErrorNoHalt( "test\n" )
		p.input:RequestFocus()
	end
	panel.Paint = function( p )
		surface.SetDrawColor( 0, 0, 0, 10 )
		surface.DrawRect( 0, 0, p:GetWide(), p:GetTall() )
	end
	panel.OnMousePressed = function( p )
		p.input:RequestFocus()
		p.input:SelectAll()
	end
	panel.label = vgui.Create( "DLabel", panel )
	panel.label:SetText( "Game Name" )
	panel.label:SetFont( "CatanFont1" )
	panel.input = vgui.Create( "DTextEntry", panel )
	panel.input:SetText( "Settlers of Catan" )
	panel.input:SetFont( "CatanFont1" )
	panel.input:SetAllowNonAsciiCharacters( false )
	panel.input:SelectAllOnFocus( true )
	panel.input:SetEditable( true )
	panel.input:AllowInput( true )
	panel.input:SetFocusTopLevel( true )
	panel.input.MaxChars = 40
	panel.input.OnTextChanged = function( p )
		
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
	
	table.insert( self.Container.Fields, panel )
	
	--------------------------------
	local panel = vgui.Create( "Panel", self.Container )
	panel:SetTabPosition( 101 )
	panel.OnGetFocus = function( p )
		p.input:RequestFocus()
	end
	panel.Paint = function( p )
		surface.SetDrawColor( 0, 0, 0, 10 )
		surface.DrawRect( 0, 0, p:GetWide(), p:GetTall() )
	end
	panel.OnMousePressed = function( p )
		p.input:RequestFocus()
		p.input:SelectAll()
	end
	panel.label = vgui.Create( "DLabel", panel )
	panel.label:SetText( "Password" )
	panel.label:SetFont( "CatanFont1" )
	panel.input = vgui.Create( "DTextEntry", panel )
	panel.input:SetText( "" )
	panel.input:SetFont( "CatanFont1" )
	panel.input:SetAllowNonAsciiCharacters( false )
	panel.input:SelectAllOnFocus( true )
	panel.input:SetEditable( true )
	panel.input:AllowInput( true )
	panel.input:SetFocusTopLevel( true )
	panel.input.MaxChars = 10
	panel.input.OnTextChanged = function( p )
		
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
	
	self:SetSize( ScrW(), ScrH() )
	
	self.GoBackBtn:SetSize( self:GetWide() * 0.1, self:GetTall() * 0.8 )
	self.GoBackBtn:SetPos( self:GetWide() * 0.1, self:GetTall() * 0.1 )
	
	self.Container:SetSize( self:GetWide() * 0.7, self:GetTall() * 0.8 )
	self.Container:SetPos( self:GetWide()*0.2, self:GetTall() * 0.1 )
	
	local px, py = self:GetWide() * 0.01, self:GetTall() * 0.01
	
	for i, panel in ipairs( self.Container.Fields ) do
		
		panel:SetWide( self.Container:GetWide() - px * 2 )
		panel:SetPos( px, py )
		
		panel.label:SizeToContents()
		panel.label:SetPos( panel:GetWide() * 0.01, self.Container:GetTall() * 0.01 )
		
		if( panel.input ) then
			panel.input:SetWide( panel:GetWide() * 0.7 )
			panel.input:SetPos( panel:GetWide() * 0.29, self.Container:GetTall() * 0.01 )
			panel.input:SetTall( panel.label:GetTall() )
		end
		
		panel:SetTall( panel.label:GetTall() + self.Container:GetTall() * 0.02 )
		
		py = py + panel:GetTall()
		
	end
	
end

function PANEL:Paint()
	
	surface.SetDrawColor( 0, 255, 255, 100 )
	surface.DrawRect( 0, 0, self:GetWide(), self:GetTall() )
	
end
vgui.Register( "CreateScreen", PANEL, "Panel" )