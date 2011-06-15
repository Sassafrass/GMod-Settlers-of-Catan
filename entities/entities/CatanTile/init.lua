
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
	vert:SetX( PosX )
	vert:SetY( PosY )
	if( not self:GetBoard().Vertexs[ PosX ] ) then
		
		self:GetBoard().Vertexs[ PosX ] = {}
		
	end
	self:GetBoard().Vertexs[ PosX ][ PosY ] = vert
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
	
	local vert = ents.Create( "CatanTileEdge" )
	vert:SetPos( self:GetBoard():EdgeToWorld( PosX, PosY ) )
	vert:SetX( PosX )
	vert:SetY( PosY )
	if( not self:GetBoard().Edges[ PosX ] ) then
		
		self:GetBoard().Edges[ PosX ] = {}
		
	end
	self:GetBoard().Edges[ PosX ][ PosY ] = vert
	vert:SetBoard( self:GetBoard() )
	vert:Spawn()
	vert:Activate()
	
end