
AddCSLuaFile("cl_init.lua")
AddCSLuaFile("shared.lua")
include("shared.lua")

function NewBoard( CGame )
	
	local b = ents.Create( "CatanBoard" )
	b:SetGame( CGame )
	b:Spawn()
	b:Activate()
	
	return b
	
end

function ENT:Initialize()
	
	self:SetModel( "models/Roller.mdl" )
	self:PhysicsInit( SOLID_VPHYSICS )
	self:SetMoveType( MOVETYPE_NONE )
	self:SetSolid( SOLID_NONE )
	
	self.desertTile = nil
	
	self:SharedInitialize()
	self:CreateTiles()
	self:CreatePieces()
	
	self:OnBoardSpawned()
	
	local phys = self:GetPhysicsObject()
	if( ValidEntity( phys ) ) then	
	
		phys:EnableMotion( false )
		
	end
	
end

function ENT:UpdateTransmitState()
	
	return TRANSMIT_ALWAYS
	
end

function ENT:SetGame( CGame )
	
	self.dt.Game = CGame
	
end

local chits_4_players = {
	2, 2,
	3, 3,
	4, 4,
	5, 5,
	6, 6,
	8, 8,
	9, 9,
	10, 10,
	11, 11
}
local tiles_setup_4_players = {
			{ 0, 2},	{ 1, 2},	{ 2, 2},
		{-1, 1},	{ 0, 1},	{ 1, 1},	{ 2, 1},
	{-2, 0},	{-1, 0},	{ 0, 0},	{ 1, 0},	{ 2, 0},
		{-2,-1},	{-1,-1},	{ 0,-1},	{ 1,-1},
			{-2,-2},	{-1,-2},	{ 0,-2},
}
local resource_counts_4_players = {}
	resource_counts_4_players[ Terrain.Desert ] = 1
	resource_counts_4_players[ Terrain.Hills ] = 3
	resource_counts_4_players[ Terrain.Pasture ] = 4
	resource_counts_4_players[ Terrain.Mountains ] = 3
	resource_counts_4_players[ Terrain.Fields ] = 4
	resource_counts_4_players[ Terrain.Forest ] = 4


local chits_6_players = {
	2, 2, 2,
	3, 3, 3,
	4, 4, 4,
	5, 5, 5,
	6, 6, 6,
	8, 8, 8,
	9, 9, 9,
	10, 10, 10,
	11, 11, 11
}
local tiles_setup_6_players = {
				{ 0, 3},	{ 1, 3},	{ 2, 3},
			{-1, 2},	{ 0, 2},	{ 1, 2},	{ 2, 2},
		{-2, 1},	{-1, 1},	{ 0, 1},	{ 1, 1},	{ 2, 1},
	{-3, 0},	{-2, 0},	{-1, 0},	{ 0, 0},	{ 1, 0},	{ 2, 0},
		{-3,-1},	{-2,-1},	{-1,-1},	{ 0,-1},	{ 1,-1},
			{-3,-2},	{-2,-2},	{-1,-2},	{ 0,-2},
				{-3,-3},	{-2,-3},	{-1,-3},
}
local resource_counts_6_players = {}
	resource_counts_6_players[ Terrain.Desert ] = 2
	resource_counts_6_players[ Terrain.Hills ] = 5
	resource_counts_6_players[ Terrain.Pasture ] = 6
	resource_counts_6_players[ Terrain.Mountains ] = 5
	resource_counts_6_players[ Terrain.Fields ] = 6
	resource_counts_6_players[ Terrain.Forest ] = 6

function ENT:CreateTiles()
	
	local tiles = {}
	local player_count = self:GetGame():GetNumPlayers()
	local resource_counts
	local tiles_setup
	local chits
	
	if( player_count > 4 ) then
		
		--Generate larger board
		resource_counts = resource_counts_6_players
		tiles_setup = tiles_setup_6_players
		chits = table.Copy( chits_6_players )
		
	else
		
		--Generate regular board
		resource_counts = resource_counts_4_players
		tiles_setup = tiles_setup_4_players
		chits = table.Copy( chits_4_players )
		
	end
	
	--Shuffle chits
	local n = #chits
	while( n > 0 ) do
		local k = math.random(n)
		local temp = chits[n]
		chits[n] = chits[k]
		chits[k] = temp
		n = n - 1
	end
	
	local tile_count = 0
	for terrainType, count in pairs( resource_counts ) do
		
		for i = 1, count do
			
			tile_count = tile_count + 1
			tiles[ tile_count ] = self:CreateTile( terrainType, chits[ tile_count ] )
			
		end
		
	end
	
	for _, tile_pos in rpairs( tiles_setup ) do
		
		local x, y = tile_pos[1], tile_pos[2]
		if( not self.Tiles[ x ] ) then
			
			self.Tiles[ x ] = {}
			
		end
		
		local tile = tiles[ tile_count ]
		tile:SetPos( self:TileToWorld( x, y ) )
		tile:SetX( x )
		tile:SetY( y )
		tile:CreateVertexs()
		tile:CreateEdges()
		self.Tiles[ x ][ y ] = tile
		tile_count = tile_count - 1
		
		tile:Spawn()
		tile:Activate()
		
	end
	
	local checkedtiles = {}
	self:CreateWaterTiles( self.Tiles[ 0 ][ 0 ], checkedtiles )
	--TODO: Center the board on the table
	
end

function ENT:CreateWaterTiles( CTile, checked )
	
	checked[ CTile ] = true
	
	for _, dir in rpairs{ "UP", "DN", "LL", "UL", "LR", "UR" } do
		
		local tile = CTile[ "Get"..dir ]( CTile )
		
		ErrorNoHalt( dir, "\t", tile, "\n" )
		if( not ValidEntity( tile ) ) then
			
			tile = self:CreateWaterTile( CTile:GetX(), CTile:GetY(), dir )
			checked[ tile ] = true
			
		elseif( not checked[ tile ] ) then
			
			self:CreateWaterTiles( tile, checked )
			
		end
		
	end
	
end

function ENT:CreateTile( terrainType, tokenValue )
	
	local tile = ents.Create( "CatanTile" )
	tile:SetTerrain( terrainType )
	tile:SetBoard( self )
	tile:SetAngles( Angle( 0, 90 + math.random(1,6) * 60, 0 ) )
	
	if( terrainType == Terrain.Desert ) then
		self.desertTile = tile
	else
		tile:SetTokenValue( tokenValue )
	end
	
	return tile
	
end

function ENT:CreateWaterTile( PosX, PosY, dir )
	
	if( dir == "UP" or dir == "UR" ) then
		PosY = PosY + 1
	end
	if( dir == "DN" or dir == "LL" ) then
		PosY = PosY - 1
	end
	if( dir == "LR" or dir == "UR" ) then
		PosX = PosX + 1
	end
	if( dir == "LL" or dir == "UL" ) then
		PosX = PosX - 1
	end
	
	local ang = Angle( 0, -90, 0 )
	if( dir == "UR" ) then
		ang.y = ang.y - 60
	elseif( dir == "LR" ) then
		ang.y = ang.y - 120
	elseif( dir == "DN" ) then
		ang.y = ang.y - 180
	elseif( dir == "LL" ) then
		ang.y = ang.y + 120
	elseif( dir == "UL" ) then
		ang.y = ang.y + 60
	end
	
	local tile = self:CreateTile( math.Rand( 0, 1 ) > 0.3 and Terrain.Water or Terrain.Water + math.random(6) )
	tile:SetPos( self:TileToWorld( PosX, PosY ) )
	tile:SetAngles( ang )
	tile:SetX( PosX )
	tile:SetY( PosY )
	if( not self.Tiles[ PosX ] ) then
		
		self.Tiles[ PosX ] = {}
		
	end
	self.Tiles[ PosX ][ PosY ] = tile
	
	tile:Spawn()
	tile:Activate()
	
	return tile
	
end

function ENT:SetRobber( robber )
	
	self.dt.Robber = robber
	
end

function ENT:CreatePieces()
	
	self:CreateRobber()
	
end

function ENT:CreateRobber()
	
	local robber = ents.Create( "CatanPieceRobber" )
	robber:SetTile( self.desertTile )
	
	self:SetRobber( robber )
	
	robber:Spawn()
	robber:Activate()
	
end

function ENT:OnBoardSpawned()
	
end