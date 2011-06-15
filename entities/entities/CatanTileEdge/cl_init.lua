include("shared.lua")

local Vector_Up = Vector( 0, 0, 15 )
local color_green = Color( 0, 255, 0, 255 )
local mat_debugwhite = Material( "effects/laser1" )

function ENT:Initialize()
	
	if( not self:GetBoard().Edges[ self:GetX() ] ) then
		
		self:GetBoard().Edges[ self:GetX() ] = {}
		
	end
	
	self:GetBoard().Edges[ self:GetX() ][ self:GetY() ] = self
	
end

function ENT:Draw()

	local board = self:GetBoard()
	if( not board ) then return end
	
	render.SetMaterial( mat_debugwhite )
	
	local tr = GetPlayerTrace()
	if( not tr ) then return end
	local x, y = board:WorldToEdge( tr )
	if( board:GetEdgeAt( x, y ) == self ) then
		
		render.DrawBeam( self:GetPos(), self:GetPos() + Vector_Up * 2, 20, 0, 0, color_green )
		
	else
		
		render.DrawBeam( self:GetPos(), self:GetPos() + Vector_Up, 5, 0, 0, color_white )
		
	end
	
end

function ENT:DebugDraw( tr )
	
	local w, h = surface.GetTextSize( "" )
	draw.DrawText( tostring( self:GetX() ) .. ", " .. tostring( self:GetY() ), "CV20", 0, 0, color_green, TEXT_ALIGN_CENTER )
	
end