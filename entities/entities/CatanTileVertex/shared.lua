
ENT.Type = "anim"
ENT.Base = "catantilesocket"

--[[
	Vertexs
	]]

function ENT:GetAdjacentVertexs()
	
	local vertexs = {}
	if( self:GetY() % 2 == 0 ) then
		vertexs[ 1 ] = self:GetBoard():GetVertexAt( self:GetX(), self:GetY() - 1 )
		vertexs[ 2 ] = self:GetBoard():GetVertexAt( self:GetX(), self:GetY() + 1 )
		vertexs[ 3 ] = self:GetBoard():GetVertexAt( self:GetX() + 1, self:GetY() + 1 )
	else
		vertexs[ 1 ] = self:GetBoard():GetVertexAt( self:GetX() - 1, self:GetY() - 1 )
		vertexs[ 2 ] = self:GetBoard():GetVertexAt( self:GetX(), self:GetY() + 1 )
		vertexs[ 3 ] = self:GetBoard():GetVertexAt( self:GetX(), self:GetY() - 1 )
	end
	
	return vertexs
	
end

--[[
	Edges
	]]

function ENT:GetAdjacentEdges()
	
	local edges = {}
	if( self:GetY() % 2 == 0 ) then
		edges[ 1 ] = self:GetBoard():GetEdgeAt( self:GetX(), self:GetY() / 2 * 3 )
		edges[ 2 ] = self:GetBoard():GetEdgeAt( self:GetX(), self:GetY() / 2 * 3 + 1 )
		edges[ 3 ] = self:GetBoard():GetEdgeAt( self:GetX(), self:GetY() / 2 * 3 + 2 )
	else
		edges[ 1 ] = self:GetBoard():GetEdgeAt( self:GetX() - 1, (self:GetY() - 1) / 2 * 3 + 1 )
		edges[ 2 ] = self:GetBoard():GetEdgeAt( self:GetX(), (self:GetY() - 1) / 2 * 3 + 2 )
		edges[ 3 ] = self:GetBoard():GetEdgeAt( self:GetX(), (self:GetY() - 1) / 2 * 3 + 3 )
	end
	
	return edges
	
end

--[[
	Tiles
	]]

function ENT:GetAdjacentTiles()
	
	local tiles = {}
	if( self:GetY() % 2 == 0 ) then
		tiles[ 1 ] = self:GetBoard():GetTileAt( self:GetX(), self:GetY() / 2 )
		tiles[ 2 ] = self:GetBoard():GetTileAt( self:GetX() + 1, self:GetY() / 2 )
		tiles[ 3 ] = self:GetBoard():GetTileAt( self:GetX() + 1, self:GetY() / 2 + 1 )
	else
		tiles[ 1 ] = self:GetBoard():GetTileAt( self:GetX(), (self:GetY() - 1) / 2 + 1 )
		tiles[ 2 ] = self:GetBoard():GetTileAt( self:GetX(), (self:GetY() - 1) / 2 )
		tiles[ 3 ] = self:GetBoard():GetTileAt( self:GetX() + 1, (self:GetY() - 1) / 2 + 1 )
	end
	
	return tiles
	
end