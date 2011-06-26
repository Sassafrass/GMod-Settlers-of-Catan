
include("shared.lua")

function LocalCPlayer()
	
	return LocalPlayer():GetCPlayer()
	
end

function ENT:Initialize()
	
	self:SetRenderBounds( Vector() * -100, Vector() * 100 )
	
end

function ENT:Draw()
end

function ENT:PlacePiece( trPos )
	
	if( not GAMEMODE.PlacingPiece ) then return end
	if( not trPos ) then return end
	
	ErrorNoHalt( "Placing Piece!\n" )
	
	if( GAMEMODE.PlacingPiece == PieceType.Village ) then
		
		local vert = self:GetGame():GetBoard():GetVertexAt( self:GetGame():GetBoard():WorldToVertex( trPos ) )
		if( vert ) then
			RunConsoleCommand( "sog_placepiece", vert:GetX(), vert:GetY() )
		end
		
	elseif( GAMEMODE.PlacingPiece == PieceType.Road ) then
		
		local edge = self:GetGame():GetBoard():GetEdgeAt( self:GetGame():GetBoard():WorldToEdge( trPos ) )
		if( edge ) then
			RunConsoleCommand( "sog_placepiece", edge:GetX(), edge:GetY() )
		end
		
	end
	
end