include("shared.lua")

local mat_debugwhite = Material( "effects/laser1" )

function ENT:Initialize()
	
	if( not self:GetBoard().VertexMatrix[ self:GetX() ] ) then
		
		self:GetBoard().VertexMatrix[ self:GetX() ] = {}
		
	end
	
	self:GetBoard().VertexMatrix[ self:GetX() ][ self:GetY() ] = self
	self:GetBoard().Vertexs[ #self:GetBoard().Vertexs + 1 ] = self
	
end

local Vector_Up = Vector( 0, 0, 15 )
local color_red = Color( 255, 50, 50, 255 )

function ENT:Draw()
	
	-- local board = self:GetBoard()
	-- if( not board ) then return end
	
	-- render.SetMaterial( mat_debugwhite )
	
	-- local tr = GetPlayerTrace()
	-- if( not tr ) then return end
	-- local x, y = board:WorldToVertex( tr )
	-- if( board:GetVertexAt( x, y ) == self ) then
		
		-- render.DrawBeam( self:GetPos(), self:GetPos() + Vector_Up * 2, 20, 0, 0, color_red )
		
	-- else
		
		-- render.DrawBeam( self:GetPos(), self:GetPos() + Vector_Up, 5, 0, 0, color_white )
		
	-- end
	
end

function ENT:DebugDraw( tr )
	
	local w, h = surface.GetTextSize( "" )
	draw.DrawText( tostring( self:GetX() ) .. ", " .. tostring( self:GetY() ), "CV20", 0, 0, color_red, TEXT_ALIGN_CENTER )
	
end