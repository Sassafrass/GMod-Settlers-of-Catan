concommand.Add( "sog_placepiece", function( pl, cmd, args )
	
	if( not ValidEntity( pl ) ) then return end
	
	local CPl = pl:GetCPlayer()
	if( not ValidEntity( CPl ) ) then return end
	
	ErrorNoHalt( "CPlayer ", CPl, " is trying to place a piece.", CPl:IsPlayersTurn(), " ", CPl:HasBuiltPiece(), "\n" )
	if( not CPl:IsPlayersTurn() ) then return end
	if( not CPl:HasBuiltPiece() ) then return end
	
	local px = tonumber( args[1] )
	local py = tonumber( args[2] )
	
	--TODO: Checks and stuff
	if( CPl:CanPlacePiece( CPl:GetBuiltPiece(), px, py ) ) then
		
		CPl:PlacePiece( px, py )
		
	end
	
end )