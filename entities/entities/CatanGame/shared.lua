
ENT.Type = "anim"
ENT.Base = "base_anim"

function ENT:SharedInitialize()
	
	self.UsedColors = {}
	self.Players = {}
	self.Spectators = {}
	
end

function ENT:SetupDataTables()
	
	self:DTVar( "Int", 0, "GameID" )
	self:DTVar( "Int", 1, "NumPlayers" )
	self:DTVar( "Int", 2, "MaxPlayers" )
	self:DTVar( "Int", 3, "GameState" )
	self:DTVar( "Entity", 0, "Board" )
	self:DTVar( "Entity", 1, "ActivePlayer" )
	
end

function ENT:GameID()
	
	return self.dt.GameID
	
end

function ENT:GetPlayers()
	
	return self.Players
	
end

function ENT:GetBoard()
	
	return self.dt.Board
	
end

function ENT:GetActivePlayer()
	return self.dt.ActivePlayer
end

function ENT:GetNumPlayers()
	
	return self.dt.NumPlayers
	
end

function ENT:GetSpectators()
	
	return self.Spectators
	
end

function ENT:GetNumSpectators()
	
	return #self.Spectators
	
end

function ENT:GetMaxPlayers()
	
	return self.dt.MaxPlayers
	
end

function ENT:GetState()
	
	return self.dt.GameState
	
end

function ENT:GetPlayerByID( id )
	
	return self.Players[ id ]
	
end

function ENT:ValidVillagePlacement( CPlayer, CVertex )
	
	for _, vert in pairs( CVertex:GetAdjacentVertexs() ) do
		
		if( ValidEntity( vert:GetPiece() ) and vert:GetPiece().PieceType == PieceType.Village ) then
			
			if( SERVER ) then
				CPlayer:ChatPrint( "This village is too close to another village" )
			end
			return false
			
		end
		
	end
	
	if( self:GetState() == GAME_STATE.SETUP ) then
		
		for _, edge in pairs( CVertex:GetAdjacentEdges() ) do
			
			if( not ValidEntity( edge:GetPiece() ) ) then
				
				return true
				
			end
			
		end
		
		if( SERVER ) then
			CPlayer:ChatPrint( "You cannot place a village here because there is no room for its road" )
		end
		return false
		
	elseif( self:GetState() > GAME_STATE.SETUP ) then
		
		for _, edge in pairs( CVertex:GetAdjacentEdges() ) do
			
			if( ValidEntity( edge:GetPiece() ) and edge:GetPiece():GetPlayer() == CPlayer ) then
				
				return true
				
			end
			
		end
		
		if( SERVER ) then
			CPlayer:ChatPrint( "You must place your village on a road" )
		end
		return false
		
	end
	
	
end

function ENT:ValidRoadPlacement( CPlayer, CEdge )
	
	if( self:GetState() == GAME_STATE.SETUP ) then
	
		for _, vert in pairs( CEdge:GetAdjacentVertexs() ) do
			
			local piece = vert:GetPiece()
			if( ValidEntity( piece ) and piece:GetPlayer() == CPlayer and piece == CPlayer.PreviousPlacedVillage ) then
				
				return true
				
			end
			
		end
		
		if( SERVER ) then
			CPlayer:ChatPrint( "Your road must be placed adjacent to the village you just placed" )
		end
		
		return false
		
	else
		
		for _, edge in pairs( CEdge:GetAdjacentEdges() ) do
			
			local piece = edge:GetPiece()
			if( ValidEntity( piece ) and piece:GetPlayer() == CPlayer ) then
				
				return true
				
			end
			
		end
		
		if( SERVER ) then
			CPlayer:ChatPrint( "Your road must be built adjacent to another road" )
		end
		
		return false
		
	end
	
end