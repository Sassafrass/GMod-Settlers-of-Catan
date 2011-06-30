concommand.Add( "sog_create", function( pl, cmd, args )
	
	if( not ValidEntity( pl ) ) then return end
	
	local CPl = pl:GetCPlayer()
	if( not ValidEntity( CPl ) ) then return end
	
	if( CPl:IsInGame() ) then
		
		pl:ChatPrint( "You cannot make a game while you are in one" )
		return
		
	end
	
	local max_players = tonumber( args[1] ) or 6
	local game_name = (args[2] or "Settlers of GMod"):sub( 1, 40 )
	local game_pass = (args[2] or ""):sub( 1, 10 )
	if( game_pass == "" ) then
		game_pass = nil
	end
	
	GAMEMODE.Lobby:CreateGame( CPl, max_players, game_name, game_pass )
	
end )