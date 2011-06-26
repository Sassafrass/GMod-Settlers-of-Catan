
ENT.Type = "anim"
ENT.Base = "catantilesocket"

--[[
	Vertexs
	]]

function ENT:GetAdjacentVertexs()
	
	local vertexs = {}
	vertexs[ 1 ] = self:GetVertex1()
	vertexs[ 2 ] = self:GetVertex2()
	vertexs[ 3 ] = self:GetVertex3()
	
	return vertexs
	
end

function ENT:GetVertex1()
	if( self:GetY() % 2 == 0 ) then
		return self:GetBoard():GetVertexAt( self:GetX(), self:GetY() - 1 )
	else
		return self:GetBoard():GetVertexAt( self:GetX() - 1, self:GetY() - 1 )
	end
end

function ENT:GetVertex2()
	if( self:GetY() % 2 == 0 ) then
		return self:GetBoard():GetVertexAt( self:GetX(), self:GetY() + 1 )
	else
		return self:GetBoard():GetVertexAt( self:GetX(), self:GetY() + 1 )
	end
end

function ENT:GetVertex3()
	if( self:GetY() % 2 == 0 ) then
		return self:GetBoard():GetVertexAt( self:GetX() + 1, self:GetY() + 1 )
	else
		return self:GetBoard():GetVertexAt( self:GetX(), self:GetY() - 1 )
	end
end

--[[
	Edges
	]]

function ENT:GetAdjacentEdges()
	
	local edges = {}
	edges[ 1 ] = self:GetEdge1()
	edges[ 2 ] = self:GetEdge2()
	edges[ 3 ] = self:GetEdge3()
	
	return edges
	
end

function ENT:GetEdge1()
	if( self:GetY() % 2 == 0 ) then
		return self:GetBoard():GetEdgeAt( self:GetX(), self:GetY() / 2 * 3 )
	else
		return self:GetBoard():GetEdgeAt( self:GetX() - 1, (self:GetY() - 1) / 2 * 3 + 1 )
	end
end

function ENT:GetEdge2()
	if( self:GetY() % 2 == 0 ) then
		return self:GetBoard():GetEdgeAt( self:GetX(), self:GetY() / 2 * 3 + 1 )
	else
		return self:GetBoard():GetEdgeAt( self:GetX(), (self:GetY() - 1) / 2 * 3 + 2 )
	end
end

function ENT:GetEdge3()
	if( self:GetY() % 2 == 0 ) then
		return self:GetBoard():GetEdgeAt( self:GetX(), self:GetY() / 2 * 3 + 2 )
	else
		return self:GetBoard():GetEdgeAt( self:GetX(), (self:GetY() - 1) / 2 * 3 + 3 )
	end
end

--[[
	Tiles
	]]

function ENT:GetAdjacentTiles()
	
	local tiles = {}
	tiles[ 1 ] = self:GetTile1()
	tiles[ 2 ] = self:GetTile2()
	tiles[ 3 ] = self:GetTile3()
	
	return tiles
	
end

function ENT:GetTile1()
	if( self:GetY() % 2 == 0 ) then
		return self:GetBoard():GetTileAt( self:GetX(), self:GetY() / 2 )
	else
		return self:GetBoard():GetTileAt( self:GetX(), (self:GetY() - 1) / 2 + 1 )
	end
end

function ENT:GetTile2()
	if( self:GetY() % 2 == 0 ) then
		return self:GetBoard():GetTileAt( self:GetX() + 1, self:GetY() / 2 )
	else
		return self:GetBoard():GetTileAt( self:GetX(), (self:GetY() - 1) / 2 )
	end
end

function ENT:GetTile3()
	if( self:GetY() % 2 == 0 ) then
		return self:GetBoard():GetTileAt( self:GetX() + 1, self:GetY() / 2 + 1 )
	else
		return self:GetBoard():GetTileAt( self:GetX() + 1, (self:GetY() - 1) / 2 + 1 )
	end
end