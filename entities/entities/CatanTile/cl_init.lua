
include("shared.lua")

function ENT:Initialize()
	
	if( not self:GetBoard().TileMatrix[ self:GetX() ] ) then
		
		self:GetBoard().TileMatrix[ self:GetX() ] = {}
		
	end
	
	self:GetBoard().TileMatrix[ self:GetX() ][ self:GetY() ] = self
	self:GetBoard().Tiles[ #self:GetBoard().Tiles + 1 ] = self
	
	local t = self:GetTokenValue()
	if( t > 0 ) then
		self.Chit = ClientsideModel( "models/mrgiggles/sog/token.mdl" )
		if( t < 8 ) then
			self.Chit:SetSkin( t - 2 )
		else
			self.Chit:SetSkin( t - 3 )
		end
		self.ChitRestPos = Vector( 0, 0, self:OBBMaxs().z )
		self.ChitHoverPos = Vector( 0, 0, self:OBBMaxs().z + 30 )
		self.Chit:SetPos( self:GetPos() )
		self.Chit:SetAngles( self:GetAngles() )
		self.ChitScale = 0.75
		self.Chit:SetModelScale( Vector() * self.ChitScale )
	end
	
end


surface.CreateFont ( "coolvetica", 40, 400, true, false, "CV20", true )
function ENT:Draw()
	
	-- local board = self:GetBoard()
	-- if( not board ) then return end
	
	self:DrawModel()
	
	if( not self.Chit ) then return end
	
	-- local tr = GetPlayerTrace()
	-- if( not tr ) then
		
		-- self.Chit:SetPos( LerpVector( 0.5, self.Chit:GetPos(), self:LocalToWorld( self.ChitRestPos ) ) )
		-- self.Chit:SetAngles( LerpAngle( 0.5, self.Chit:GetAngles(), self:GetAngles() ) )
		-- self.Chit:SetModelScale( Vector() * Lerp( 0.5, self.ChitScale, 0.75 ) )
		-- return
		
	-- end
	
	-- local x, y = board:WorldToTile( tr )
	-- if( board:GetTileAt( x, y ) == self ) then
		
		-- self.Chit:SetPos( LerpVector( 0.5, self.Chit:GetPos(), self:LocalToWorld( self.ChitHoverPos ) ) )
		-- local ang = ( self.Chit:GetPos() - GAMEMODE.View.origin ):Angle()
		-- ang:RotateAroundAxis( ang:Forward(), 90 )
		-- ang:RotateAroundAxis( ang:Right(), 90 )
		-- self.Chit:SetAngles( LerpAngle( 0.5, self.Chit:GetAngles(), ang ) )
		-- self.Chit:SetModelScale( Vector() * Lerp( 0.5, self.ChitScale, 1 ) )
		
	-- else
		
		self.Chit:SetPos( LerpVector( 0.5, self.Chit:GetPos(), self:LocalToWorld( self.ChitRestPos ) ) )
		self.Chit:SetAngles( LerpAngle( 0.5, self.Chit:GetAngles(), self:GetAngles() ) )
		self.Chit:SetModelScale( Vector() * Lerp( 0.5, self.ChitScale, 0.75 ) )
	
	-- end
	
end

-- hook.Add( "HUDPaint", "CatanTile.HUDPaint", function()
	
	-- local CPl = LocalCPlayer()
	-- if( not ValidEntity( CPl ) ) then return end
	
	-- local CGame = CPl:GetGame()
	-- if( not ValidEntity( CGame ) ) then return end
	
	-- local board = CGame:GetBoard()
	-- if( not ValidEntity( board ) ) then return end
	
	-- local tr = GetPlayerTrace()
	-- if( not tr ) then return end
	-- surface.SetFont( "CV20" )
	-- local w, h = surface.GetTextSize( "" )
	-- local x, y = board:WorldToEdge( tr )
	
	-- draw.DrawText( tostring( math.Round( x, 2 ) .. ", " .. math.Round( y, 2 ) ), "CV20", gui.MouseX(), gui.MouseY(), color_white, TEXT_ALIGN_CENTER )
	
-- end )

-- local Vector_Up = Vector( 0, 0, 15 )
-- hook.Add( "PostDrawOpaqueRenderables", "CatanTile.PostDrawOpaqueRenderables", function()
	
	-- local CPl = LocalCPlayer()
	-- if( not ValidEntity( CPl ) ) then return end
	
	-- local CGame = CPl:GetGame()
	-- if( not ValidEntity( CGame ) ) then return end
	
	-- local board = CGame:GetBoard()
	-- if( not ValidEntity( board ) ) then return end
	
	-- local tr = GetPlayerTrace()
	-- if( not tr ) then return end
	-- surface.SetFont( "CV20" )
	
	-- for _, ent in pairs( ents.FindByClass( "CatanTile" ) ) do
		-- local ang = ( ent:GetPos() - GAMEMODE.View.origin ):Angle()
		-- cam.Start3D2D( ent:GetPos() + Vector_Up, Angle( 0, ang.y-90, 90-ang.p ), 0.33 )
			
			-- local ok, err = pcall( ent.DebugDraw, ent, tr )
			
		-- cam.End3D2D()
	-- end
	
	-- for _, ent in pairs( ents.FindByClass( "CatanTileVertex" ) ) do
		-- local ang = ( ent:GetPos() - GAMEMODE.View.origin ):Angle()
		-- cam.Start3D2D( ent:GetPos() + Vector_Up, Angle( 0, ang.y-90, 90-ang.p ), 0.33 )
			
			-- local ok, err = pcall( ent.DebugDraw, ent, tr )
			
		-- cam.End3D2D()
	-- end
	
	-- for _, ent in pairs( ents.FindByClass( "CatanTileEdge" ) ) do
		-- local ang = ( ent:GetPos() - GAMEMODE.View.origin ):Angle()
		-- cam.Start3D2D( ent:GetPos() + Vector_Up, Angle( 0, ang.y-90, 90-ang.p ), 0.33 )
			
			-- local ok, err = pcall( ent.DebugDraw, ent, tr )
			
		-- cam.End3D2D()
	-- end
	
-- end )

function ENT:DebugDraw( tr )
	
	local w, h = surface.GetTextSize( "" )
	draw.DrawText( tostring( self:GetX() ) .. ", " .. tostring( self:GetY() ), "CV20", 0, 0, color_white, TEXT_ALIGN_CENTER )
	-- draw.DrawText( tostring( TerrainName( self:GetTerrain() ) ), "CV20", 0, h + 2, color_white, TEXT_ALIGN_CENTER )
	
end