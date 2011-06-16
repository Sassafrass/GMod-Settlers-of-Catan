
ENT.Type = "anim"
ENT.Base = "base_anim"

CTILE_HEIGHT = 88.8
CTILE_HALF_HEIGHT = CTILE_HEIGHT * 0.5
CTILE_NARROW_WIDTH = CTILE_HEIGHT / math.cos( math.rad( 30 ) )
CTILE_SIZE = CTILE_NARROW_WIDTH * 0.5
CTILE_SEGMENT = CTILE_SIZE * math.sin( math.rad( 30 ) )
CTILE_WIDTH = (3*CTILE_HALF_HEIGHT) / (2*math.sin( math.rad( 60 ) ))

ENUM( "Terrain",
	"Hills",
	"Pasture",
	"Mountains",
	"Fields",
	"Forest",
	"Desert",
	"Water",
	"WaterAny",
	"WaterWool",
	"WaterBrick",
	"WaterWheat",
	"WaterWood",
	"WaterIron"
	)
	

function TerrainName( terrainType )
	
	if( terrainType == Terrain.Desert ) then
		return "Desert"
	elseif( terrainType == Terrain.Hills ) then
		return "Hills"
	elseif( terrainType == Terrain.Pasture ) then
		return "Pasture"
	elseif( terrainType == Terrain.Mountains ) then
		return "Mountains"
	elseif( terrainType == Terrain.Fields ) then
		return "Fields"
	elseif( terrainType == Terrain.Forest ) then
		return "Forest"
	end
	
end

function ENT:SharedInitialize()

	self.Tiles = {}
	self.Vertexs = {}
	self.Edges = {}
	
end

function ENT:SetupDataTables()
	
	self:DTVar( "Entity", 0, "Game" )
	self:DTVar( "Entity", 1, "Robber" )
	
end

function ENT:GetGame()
	
	return self.dt.Game
	
end

function ENT:GetRobber()
	
	return self.dt.Robber
	
end

function ENT:WorldToTile( WorldPos )
	
	WorldPos = self:WorldToLocal( WorldPos )
	
	local x = WorldPos.x / CTILE_WIDTH + 0.66666666666
	local y = WorldPos.y / CTILE_HEIGHT + 0.5 + math.floor(x) * 0.5
	
	local a = math.atan2( 0.5-y%1, x%1 )
	if( a < -1 ) then
		
		x = x - 1
		
	elseif( a > 1 ) then
		
		y = y - 1
		x = x - 1
		
	end
	
	return math.floor( x ), math.floor( y )
	
end

function ENT:WorldToVertex( WorldPos )
	
	WorldPos = self:WorldToLocal( WorldPos )
	local u = WorldPos.x / CTILE_WIDTH
	local v = WorldPos.y / CTILE_HALF_HEIGHT + u
	
	local b = v/2%1
	if( b > u%1 ) then
		
		v = v + 1
		
	end
	if( b > 0.5 ) then
		
		v = v - 1
		
	end
	
	return math.floor( u ), math.floor( v )
	
end

function ENT:WorldToEdge( WorldPos )
	
	WorldPos = self:WorldToLocal( WorldPos )
	WorldPos.x = WorldPos.x - CTILE_SIZE
	
	local x = WorldPos.x / CTILE_WIDTH + 0.66666666666
	local y = WorldPos.y / CTILE_HEIGHT * 3 + 1.5 + math.floor(x) * 1.5
	
	local c = x%1
	local b = y/3%1
	if( c < 0.666666666 ) then
		
		local a = math.atan2( 0.5-b, c )
		if( a < -1 ) then
			
			x = x - 1
			y = y - 1
			
		elseif( a > 1 ) then
			
			y = y - 2
			x = x - 1
			
		end
		if( b > 0.5 ) then
			
			y = y + 2
			
		end
		
	else
		
		local a = math.atan2( 0.5-b, c-0.666666666 )
		if( a < -1 ) then
			
			y = y + 1
			
		elseif( a > 1 ) then
			
			y = y - 1
			
		end
		y = y + 1
		
	end
	
	return math.floor( x ), math.floor( y - math.floor(b*3) )
	
end

function ENT:EdgeToWorld( PosX, PosY )

	-- local x = WorldPos.x / CTILE_WIDTH + 0.66666666666
	-- local y = WorldPos.y / CTILE_HEIGHT * 3 + 1.5 + math.floor(x) * 1.5
	local wx = PosX * CTILE_WIDTH
	local wy = (PosY - PosX*1.5 - 1.5) / 3 * CTILE_HEIGHT
	
	wx = wx + CTILE_SIZE
	
	local a = PosY % 3
	if( a == 0 ) then
		
		wx = wx - CTILE_SEGMENT * 0.5
		wy = wy + CTILE_HALF_HEIGHT * 0.5
		
	elseif( a == 1 ) then
		
		wx = wx + CTILE_SIZE * 0.5
		wy = wy + CTILE_HALF_HEIGHT - CTILE_HEIGHT * 0.333333333
		
	elseif( a == 2 ) then
	
		wx = wx - CTILE_SEGMENT * 0.5
		wy = wy + CTILE_HEIGHT * 0.333333333 - CTILE_HALF_HEIGHT * 0.5
		
	end
	
	return self:LocalToWorld( Vector( wx, wy ) ), wx, wy
	
end

function ENT:VertexToWorld( PosX, PosY )
	
	local wx = PosX * CTILE_WIDTH
	local wy = (PosY - PosX) * CTILE_HALF_HEIGHT
	
	if( PosY % 2 == 0 ) then
		
		wx = wx + CTILE_SIZE
		
	else
		
		wx = wx + CTILE_SEGMENT
		
	end
	
	return self:LocalToWorld( Vector( wx, wy ) )
	
end

function ENT:TileToWorld( PosX, PosY )
	
	local wx = PosX * CTILE_WIDTH
	local wy = (2*PosY - PosX) * CTILE_HALF_HEIGHT
	
	return self:LocalToWorld( Vector( wx, wy ) )
	
end

function ENT:GetTileAt( PosX, PosY )
	
	if( not self.Tiles ) then return end
	if( not self.Tiles[ PosX ] ) then return end
	
	return self.Tiles[ PosX ][ PosY ]
	
end

function ENT:GetVertexAt( PosX, PosY )
	
	if( not self.Vertexs ) then return end
	if( not self.Vertexs[ PosX ] ) then return end
	
	return self.Vertexs[ PosX ][ PosY ]
	
end

function ENT:GetEdgeAt( PosX, PosY )
	
	if( not self.Edges ) then return end
	if( not self.Edges[ PosX ] ) then return end
	
	return self.Edges[ PosX ][ PosY ]
	
end