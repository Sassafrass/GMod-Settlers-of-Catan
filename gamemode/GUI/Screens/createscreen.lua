
local PANEL = {}

surface.CreateFont ("Verdana", ScreenScale(20), 400, true, false, "CatanFont1") --scaled

function PANEL:Init()
	
	self:SetKeyboardInputEnabled( true )
	
	self.GoBackBtn = vgui.Create( "Button", self )
	self.GoBackBtn:SetText( "Back" )
	self.GoBackBtn.DoClick = function()
		
		self.ScreenManager:SetScreen( "PlayScreen" )
		
	end
	
	self.Container = vgui.Create( "Panel", self )
	self.Container:SetKeyboardInputEnabled( true )
	self.Container.Paint = function( p )
		surface.SetDrawColor( 0, 0, 0, 10 )
		surface.DrawRect( 0, 0, p:GetWide(), p:GetTall() )
	end
	
	self.Container.Fields = {}
	
	local panel = vgui.Create( "Panel", self.Container )
	panel:SetKeyboardInputEnabled( true )
	panel.Paint = function( p )
		surface.SetDrawColor( 0, 0, 0, 10 )
		surface.DrawRect( 0, 0, p:GetWide(), p:GetTall() )
	end
	panel.label = vgui.Create( "DLabel", panel )
	panel.label:SetText( "Game Name" )
	panel.label:SetFont( "CatanFont1" )
	panel.input = vgui.Create( "DTextEntry", panel )
	panel.input:SetMultiline( false )
	panel.input:SetText( "Settlers of Catan" )
	panel.input:SetFont( "CatanFont1" )
	panel.input:SetAllowNonAsciiCharacters( false )
	panel.input:SelectAllOnFocus( true )
	panel.input:SetEditable( true )
	panel.input:SetKeyboardInputEnabled( true )
	panel.input.OnTextChanged = function( p )
		
		ErrorNoHalt( "test\n" )
		p:SetValue( p:GetValue():sub( 1, math.min( p:GetValue():len(), 25 ) ) )
		
	end
	
	table.insert( self.Container.Fields, panel )
	
end

function PANEL:OnSelected()

	-- self.Container.Fields[ 1 ].input:RequestFocus()
	self:SetVisible( true )
	
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
		panel.input:SetWide( panel:GetWide() * 0.5 )
		panel.input:SetPos( panel:GetWide() * 0.49, self.Container:GetTall() * 0.01 )
		panel.input:SetTall( panel.label:GetTall() )
		
		panel:SetTall( panel.label:GetTall() + self.Container:GetTall() * 0.02 )
		
		py = py + panel:GetTall()
		
	end
	
end

function PANEL:Paint()
	
	surface.SetDrawColor( 0, 255, 255, 100 )
	surface.DrawRect( 0, 0, self:GetWide(), self:GetTall() )
	
end
vgui.Register( "CreateScreen", PANEL, "Panel" )