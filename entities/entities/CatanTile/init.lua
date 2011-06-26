
AddCSLuaFile("cl_init.lua")
AddCSLuaFile("shared.lua")
include("shared.lua")

function ENT:Initialize()
	
	self:SetModel( "models/mrgiggles/sog/tile_base.mdl" )
	self:PhysicsInit( SOLID_VPHYSICS )
	self:SetMoveType( MOVETYPE_NONE )
	self:SetSolid( SOLID_NONE )
	
end

function ENT:UpdateTransmitState()
	
	return TRANSMIT_ALWAYS
	
end

function ENT:SetTokenValue( value )
	self.dt.TokenValue = value
end

function ENT:SetX( x )
	self.dt.X = x
end

function ENT:SetY( y )
	self.dt.Y = y
end

function ENT:SetBoard( board )
	self.dt.Board = board
end

function ENT:SetTerrain( terrainType )
	self:SetSkin( terrainType-1 )
	self.dt.TerrainType = terrainType
end

function ENT:CreateVertexs()
	
	for _, offset in pairs{ {-1, 0}, {0, 1}, {0, 0}, {0, -1}, {-1, -2}, {-1, -1} } do
		
		local px = self:GetX() + offset[1]
		local py = self:GetY()*2 + offset[2]
		
		local vert = self:GetBoard():GetVertexAt( px, py )
		if( not ValidEntity( vert ) ) then
			
			self:CreateVertex( px, py )
			
		end
		
	end
	
end

function ENT:CreateVertex( PosX, PosY )
	
	local vert = ents.Create( "CatanTileVertex" )
	vert:SetPos( self:GetBoard():VertexToWorld( PosX, PosY ) )
	vert:SetAngles( Angle( 0, math.random(0, 12) * 30, 0 ) )
	vert:SetX( PosX )
	vert:SetY( PosY )
	if( not self:GetBoard().VertexMatrix[ PosX ] ) then
		
		self:GetBoard().VertexMatrix[ PosX ] = {}
		
	end
	self:GetBoard().VertexMatrix[ PosX ][ PosY ] = vert
	self:GetBoard().Vertexs[ #self:GetBoard().Vertexs + 1 ] = vert
	vert:SetBoard( self:GetBoard() )
	vert:Spawn()
	vert:Activate()
	
end

function ENT:CreateEdges()
	
	for _, offset in pairs{ {-1, 1}, {0, 2}, {0, 0}, {-1, -2}, {-1, -1}, {-1, 0} } do
		
		local px = self:GetX() + offset[1]
		local py = self:GetY()*3 + offset[2]
		
		local vert = self:GetBoard():GetEdgeAt( px, py )
		if( not ValidEntity( vert ) ) then
			
			self:CreateEdge( px, py )
			
		end
		
	end
	
end

function ENT:CreateEdge( PosX, PosY )
	
	local edge = ents.Create( "CatanTileEdge" )
	edge:SetPos( self:GetBoard():EdgeToWorld( PosX, PosY ) )
	
	if( PosY % 3 == 0 ) then
		
		edge:SetAngles( Angle( 0, -120, 0 ) )
		
	elseif( (PosY + 1) % 3 == 0 ) then
		
		edge:SetAngles( Angle( 0, 120, 0 ) )
		
	end
	
	edge:SetX( PosX )
	edge:SetY( PosY )
	if( not self:GetBoard().EdgeMatrix[ PosX ] ) then
		
		self:GetBoard().EdgeMatrix[ PosX ] = {}
		
	end
	self:GetBoard().EdgeMatrix[ PosX ][ PosY ] = edge
	self:GetBoard().Edges[ #self:GetBoard().Edges + 1 ] = edge
	edge:SetBoard( self:GetBoard() )
	edge:Spawn()
	edge:Activate()
	
end