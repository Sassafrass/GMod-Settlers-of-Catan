function ENUM( enumName, ... )
	
	if( not enumName ) then return end
	
	assert( _G[ "enumName" ] == nil )
	
	local e = {}
	
	for i = 1, #arg do
		e[ arg[i] ] = i
	end
	
	_G[ enumName ] = e
	
end


ENUM( "PlayerColor",
	"Red",
	"Blue",
	"Green",
	"Orange",
	"White",
	"Brown"
	)
	
	
PLAYER_COLORS = {
	[PlayerColor.Red] = Color( 255, 0, 0 ),
	[PlayerColor.Blue] = Color( 0, 0, 255 ),
	[PlayerColor.Green] = Color( 0, 255, 0 ),
	[PlayerColor.Orange] = Color( 255, 140, 0 ),
	[PlayerColor.White] = Color( 255, 255, 255 ),
	[PlayerColor.Brown] = Color( 139, 69, 19 )
}

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

function terrainToResource( terrainType )
	
	if( terrainType < 6 ) then
		return terrainType
	else
		return
	end
	
end

function ResourceName( resourceType )
	
	if( resourceType == Resource.Brick ) then
		return "Brick"
	elseif( resourceType == Resource.Wool ) then
		return "Wool"
	elseif( resourceType == Resource.Ore ) then
		return "Ore"
	elseif( resourceType == Resource.Grain ) then
		return "Grain"
	elseif( resourceType == Resource.Lumber ) then
		return "Lumber"
	end
	
end

ENUM( "Resource",
	"Brick",
	"Wool",
	"Ore",
	"Grain",
	"Lumber"
	)

ENUM( "CardType",
	"LongestRoad",
	"LargestArmy",
	"Resource",
	"Development"
	)

ENUM( "DevelopmentCard",
	"Quarry",
	"ToolMaking",
	"GlassMaking",
	"RoadBuilding",
	"SwiftJourney",
	"Knight"
	)

ENUM( "GAME_STATE",
	"LOBBY",
	"STARTING",
	"STARTED",
	"SETUP",
	"STRIFE",
	"FINISHED"
	)

ENUM( "PieceType",
	"Road",
	"Village",
	"City",
	"Robber"
	)