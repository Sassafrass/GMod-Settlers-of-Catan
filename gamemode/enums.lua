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