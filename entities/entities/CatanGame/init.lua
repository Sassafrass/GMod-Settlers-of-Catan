
AddCSLuaFile("cl_init.lua")
AddCSLuaFile("shared.lua")
include("shared.lua")
include( "commands/requestcolor.lua" )
include( "commands/forfeit.lua" )
include( "commands/start.lua" )
include( "commands/ready.lua" )
include( "commands/placepiece.lua" )

function ENT:Initialize()
	
	self:SharedInitialize()
	self:SetBoard( NewBoard( self ) )
	
end

AccessorFunc( ENT, "CHostPlayer", "Host" )
AccessorFunc( ENT, "Password", "Password" )

function ENT:SetBoard( board )
	
	self.dt.Board = board
	
end

function ENT:UpdateTransmitState()
	
	return TRANSMIT_ALWAYS
	
end

function ENT:SetGameID( id )
	
	self.dt.GameID = id
	
end

function ENT:GetPhase()
	
	return self.TurnManager:GetPhase()
	
end

function ENT:SetState( game_state )
	
	self.dt.GameState = game_state
	
end

function ENT:StartGame()

	if( self:GetState() ~= GAME_STATE.LOBBY ) then
		
		return false, "The game was already started"
		
	end
	
	if( self:GetNumPlayers() < 2 ) then
		
		return false, "You need at least two players to start the game"
		
	end
	
	if( not self:IsEveryoneReady() ) then
		
		return false, "Not everyone is ready"
		
	end
	
	self:SetState( GAME_STATE.STARTING )
	
	self.TurnManager = GAMEMODE.TurnManager:GetTurnManager( self )
	
	self:ChatBroadcast( "The game is starting in 5 seconds" )
	timer.Simple( 1, self.Start, self )
	
	return true
	
end

function ENT:Start()
	
	self:ChatBroadcast( "The game has started" )
	self:SetState( GAME_STATE.STARTED )
	self.TurnManager:OnGameStarted()
	self:GetBoard():CreateTiles()
	self:GetBoard():CreatePieces()
	
end

function ENT:Think()
	if(self.TurnManager) then
		self.TurnManager:Think()
	end
end

-----------------------------------------------------------------------------

function ENT:OnDiceRolled( CPlayer, result )
	
	self:ChatBroadcast( CPlayer:GetName() .. " has rolled a " .. result )
	self.TurnManager:OnDiceRolled( CPlayer, result )
	
	if( self:GetPhase() == TurnState.Gather ) then
		
		if( result == 7 ) then
			
			--TODO: Move the robber
			self.TurnManager:NextPhase() --TODO: Call this once the robber is moved and the player steals a card
			
		else
			
			self:GiveResourcesForRoll( result )
			self.TurnManager:NextPhase()
			
		end
		
	end
	
end

function ENT:GiveResourcesForRoll( value )
	
	for _, vert in pairs( self:GetBoard():GetVertexs() ) do
		
		local piece = vert:GetPiece()
		if( ValidEntity( piece ) ) then
			
			for _, tile in pairs( vert:GetAdjacentTiles() ) do
				
				if( not tile:HasRobber() and tile:GetTokenValue() == value ) then
					
					piece:GetPlayer():AddResource( tile:GetTerrain() )
					
				end
				
			end
			
		end
		
	end
	
end

function ENT:GetActivePlayer()
	return self.TurnManager:GetActivePlayer()
end

function ENT:PlayerTurnStart( CPlayer )
	
	self.dt.ActivePlayer = CPlayer
	
	self:OnTurnStart( CPlayer )
	
	if( self:GetState() == GAME_STATE.SETUP ) then
		
		self:PlayerBuildPiece( CPlayer, PieceType.Village )
		
	end
	
end

function ENT:BotBuildPiece( CPl, PType )
	
	self:OnBuildPiece( CPl, PType )
	
end

function ENT:PlayerBuildPiece( CPl, PType )

	CPl:SetBuiltPiece( PType )
	
	CPl:ChatPrint( "You built a piece" )
	
	self:SetupPieceGhost( PType )
	
	umsg.Start( "sog_builtpiece", CPl:GetPlayer() )
		umsg.Char( PType-128 )
	umsg.End()
	
	self:OnBuildPiece( CPl, PType )
	
end

function ENT:OnBuildPiece( CPl, PType )

	if( CPl:IsBot() ) then
		if(PType == PieceType.Village) then
			
			local bestValue = 0
			local bestVertex = false
			
			for _, vert in pairs( self:GetBoard():GetVertexs() ) do
				if( CPl:CanPlacePiece( PType, vert:GetX(), vert:GetY() ) ) then
					local value = 0
					for _, tile in pairs( vert:GetAdjacentTiles() ) do
						value = value + tile:GetTokenValue()
					end
					if(value > bestValue) then
						bestValue = value
						bestVertex = vert
					end
				end
			end
			
			CPl:PlacePiece( bestVertex:GetX(), bestVertex:GetY() )
			
		elseif(PType == PieceType.Road) then
			
			for _, edge in rpairs( CPl.PreviousPlacedVillage:GetSocket():GetAdjacentEdges() ) do
				if( CPl:CanPlacePiece( PType, edge:GetX(), edge:GetY() ) ) then
					CPl:PlacePiece( edge:GetX(), edge:GetY() )
					break
				end
			end
			
		end
	end
	
end

function ENT:SetupPieceGhost( PType )
	
	local g = ents.Create( "CatanPieceGhost" )
	g:SetNoDraw( true )
	g:SetBoard( self:GetBoard() )
	g:SetPlayer( self:GetActivePlayer() )
	g:Setup( PType )
	g:Spawn()
	g:Activate()
	
	self.PieceGhost = g
	
end

function ENT:RemovePieceGhost()
	
	self.PieceGhost:Remove()
	self.PieceGhost = nil
	
end

function ENT:CreatePiece( CPlayer, PType )
	
	local ent
	if( PType == PieceType.Village ) then
		ent = ents.Create( "CatanPieceVillage" )
	elseif( PType == PieceType.Road ) then
		ent = ents.Create( "CatanPieceRoad" )
	else
		Error( "Invalid Piece Type ", PType, "\n" )
	end
	
	ent:SetPlayer( CPlayer )
	ent:SetBoard( self:GetBoard() )
	ent:Spawn()
	ent:Activate()
	
	return ent
	
end

function ENT:OnPiecePlaced( CPlayer, Piece )
	
	self:ChatBroadcast( "OnPiecePlaced" )
	
	if( self.PieceGhost ) then
		
		self:RemovePieceGhost()
		
	end
	
	if( self:GetState() == GAME_STATE.SETUP ) then
		
		if( Piece.PieceType == PieceType.Village ) then
			
			CPlayer.PreviousPlacedVillage = Piece --Make sure the road is placed adjacent to this village
			self:PlayerBuildPiece( CPlayer, PieceType.Road )
			
		elseif( Piece.PieceType == PieceType.Road ) then
			
			self.TurnManager:FinishTurn()
			
		end
		
	end
	
	-- self.TurnManager:FinishTurn()
	
end

function ENT:OnTurnStart( CPlayer )
	
	self:ChatBroadcast("OnTurnStart: "..CPlayer:GetName())
	
end

function ENT:GatherPhase(NextPhase)
	self:ChatBroadcast("GatherPhase")
	self:GetActivePlayer():RollDie()
end

function ENT:TradePhase(NextPhase)
	self:ChatBroadcast("TradePhase")
end

function ENT:BuildPhase(NextPhase)
	self:ChatBroadcast("BuildPhase")
end

function ENT:OnTurnEnd()
	self.dt.ActivePlaye = NullEntity()
	self:ChatBroadcast("OnTurnEnd")
end

-----------------------------------------------------------------------------

function ENT:IsEveryoneReady()
	
	for _, CPl in pairs( self:GetPlayers() ) do
		
		if( not CPl:IsReady() ) then
			
			return false
			
		end
		
	end
	
	return true
	
end

function ENT:ChatBroadcast( msg )
	
	for _, CPl in pairs( self:GetPlayers() ) do
		
		CPl:ChatPrint( msg )
		
	end
	
end

function ENT:CanPlayerJoin( CPl )
	
	if( CPl:IsInGame() ) then return false end
	if( self:GetState() ~= GAME_STATE.LOBBY ) then
		
		CPl:GetPlayer():ChatPrint( "The game has already started" )
		return false
		
	end
	return self:GetNumPlayers() < self:GetMaxPlayers()
	
end

function ENT:AddPlayer( CPl )
	
	for i = 1, self:GetMaxPlayers() do
		
		local p = self.Players[ i ]
		if( not p ) then
			
			CPl:SetPlayerID( i )
			CPl:SetGame( self )
			local chair = GAMEMODE:GetChairByID( i )
			CPl:SetPos( chair:LocalToWorld( Vector( 0, 0, 0 ) ) )
			local ang = chair:GetAngles()
			-- ang:RotateAroundAxis( Vector( 0, 0, 1 ), 180 )
			CPl:SetAngles( ang )
			
			self.Players[ i ] = CPl
			
			self:OnPlayerJoined( CPl, CPl:GetName() )
			
			return true
			
		end
		
	end
	
	Error( "Failed to Add Player ", CPl, " to the game!\n" )
	return false
	
end

function ENT:GetRecipientFilter()
	
	local rf = RecipientFilter()
	for _, CPl in pairs( self:GetPlayers() ) do
		
		rf:AddPlayer( CPl:GetPlayer() )
		
	end
	
	for _, CPl in pairs( self:GetSpectators() ) do
		
		rf:AddPlayer( CPl:GetPlayer() )
		
	end
	
	return rf
	
end

function ENT:OnPlayerJoined( CPl )
	
	if( not self:GetHost() ) then
		
		self:SetHost( CPl )
		CPl:ChatPrint( "You are now the host." )
		
	end
	
	self:SetNumPlayers( self:GetNumPlayers() + 1 )
	
	self:ChatBroadcast( "Player " .. tostring( CPl:GetName() ) .. " has joined the game." )
	
end

function ENT:OnPlayerReady( CPl, bReady )
	
	self:ChatBroadcast( "Player " .. CPl:GetName() .. " is " ..tostring( bReady and "now" or "no longer" ) .. " ready." )
	
end

function ENT:RequestColor( CPlayer, Color_Enum )
	
	if( not self:HasPlayer( CPlayer ) ) then return end
	
	if( self:GetState() ~= GAME_STATE.LOBBY ) then
		
		CPlayer:ChatPrint( "You cannot change colors after the game has started" )
		return
		
	end
		
	if( ValidEntity( self.UsedColors[ Color_Enum ] ) ) then
		
		CPlayer:ChatPrint( "Another player already has that color" )
		return
		
	end
	
	if( self.UsedColors[ CPlayer.dt.Color ] == CPlayer ) then
		
		self.UsedColors[ CPlayer.dt.Color ] = nil
		
	end
	
	CPlayer:SetColorID( Color_Enum )
	self.UsedColors[ Color_Enum ] = CPlayer
	
	return true
	
end

function ENT:HasPlayer( CPl )
	
	if( not CPl ) then return end
	if( not CPl:IsInGame() ) then return end
	return self.Players[ CPl:PlayerID() ] == CPl
	
end

function ENT:CanPlayerLeave( CPl )
	
	assert( self:HasPlayer( CPl ) )
	if( self:GetState() >= GAME_STATE.STARTED ) then
		
		CPl:GetPlayer():ChatPrint( "You cannot leave a game in progress. Try requesting a forfeit." )
		return false
		
	end
	return true
	
end

function ENT:RemovePlayer( CPl )
	
	assert( self:HasPlayer( CPl ) )
	self.Players[ CPl:PlayerID() ] = nil
	
	if( self.UsedColors[ CPl:ColorID() ] == CPl ) then
		
		self.UsedColors[ CPl:ColorID() ] = nil
		
	end
	
	CPl:SetGame( NULL )
	CPl:SetPlayerID( 0 )
	CPl:SetColorID( 0 )
	
	self:OnPlayerLeft( CPl )
	
end

function ENT:OnPlayerLeft( CPl )
	
	if( self:GetHost() == CPl ) then
		
		if( not self:FindNewHost() ) then
			
			--TODO: Start lifetime timer and remove this game after 1 minute
			--The lobby should purge all games that have no players for 1 minute
			
		end
		
	end
	
	if( self:GetState() == GAME_STATE.STARTING ) then
		
		self:ChatBroadcast( "The start was interrupted" )
		self:SetState( GAME_STATE.LOBBY )
		
	end
	
	self:SetNumPlayers( self:GetNumPlayers() - 1 )
	
	self:ChatBroadcast( "Player " .. tostring(CPl:GetName()) .. " has left the game" )
	
end

function ENT:FindNewHost()
	
	ErrorNoHalt( "Removing game host\n" )
	self:SetHost( nil )
	
	for _, CPl in pairs( self.Players ) do
		
		if( ValidEntity( CPl ) ) then
			
			self:SetHost( CPl )
			CPl:ChatPrint( "You are now the game's host" )
			
			return true
			
		end
		
	end
	
end

function ENT:SetNumPlayers( num )
	
	self.dt.NumPlayers = num
	
end

function ENT:SetMaxPlayers( num )
	
	num = math.Clamp( num, 2, 6 )
	
	self.dt.MaxPlayers = num
	
end