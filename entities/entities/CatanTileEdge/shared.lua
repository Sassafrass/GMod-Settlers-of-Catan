
ENT.Type = "anim"
ENT.Base = "catantilesocket"

--[[
	Vertexs - 2 Vertexs per edge
	]]

function ENT:GetAdjacentVertexs()
	
	local vertexs = {}
	if( self:GetY() % 3 == 0 ) then
		vertexs[ 1 ] = self:GetBoard():GetVertexAt( self:GetX(), self:GetY() * 2 / 3 - 1 )
		vertexs[ 2 ] = self:GetBoard():GetVertexAt( self:GetX(), self:GetY() * 2 / 3 )
	elseif( (self:GetY() - 1) % 3 == 0 ) then
		vertexs[ 1 ] = self:GetBoard():GetVertexAt( self:GetX(), (self:GetY() - 1) * 2 / 3 )
		vertexs[ 2 ] = self:GetBoard():GetVertexAt( self:GetX() + 1, (self:GetY() - 1) * 2 / 3 + 1 )
	else
		vertexs[ 1 ] = self:GetBoard():GetVertexAt( self:GetX(), (self:GetY() - 2) * 2 / 3 )
		vertexs[ 2 ] = self:GetBoard():GetVertexAt( self:GetX(), (self:GetY() - 2) * 2 / 3 + 1 )
	end
	return vertexs
	
end

--[[
	Edges - 4 Edges per edge
	]]

function ENT:GetAdjacentEdges()
	
	local edges = {}
	if( (self:GetY() - 1) % 3 == 0 ) then
		edges[ 1 ] = self:GetBoard():GetEdgeAt( self:GetX(), self:GetY() + 1 )
		edges[ 2 ] = self:GetBoard():GetEdgeAt( self:GetX(), self:GetY() - 1 )
		edges[ 3 ] = self:GetBoard():GetEdgeAt( self:GetX() + 1, self:GetY() + 2 )
		edges[ 4 ] = self:GetBoard():GetEdgeAt( self:GetX() + 1, self:GetY() + 1 )
	elseif( self:GetY() % 3 == 0 ) then
		edges[ 1 ] = self:GetBoard():GetEdgeAt( self:GetX() - 1, self:GetY() - 2 )
		edges[ 2 ] = self:GetBoard():GetEdgeAt( self:GetX(), self:GetY() - 1 )
		edges[ 3 ] = self:GetBoard():GetEdgeAt( self:GetX(), self:GetY() + 2 )
		edges[ 4 ] = self:GetBoard():GetEdgeAt( self:GetX(), self:GetY() + 1 )
	else
		edges[ 4 ] = self:GetBoard():GetEdgeAt( self:GetX(), self:GetY() + 1 )
		edges[ 1 ] = self:GetBoard():GetEdgeAt( self:GetX() - 1, self:GetY() - 1 )
		edges[ 2 ] = self:GetBoard():GetEdgeAt( self:GetX(), self:GetY() - 1 )
		edges[ 3 ] = self:GetBoard():GetEdgeAt( self:GetX(), self:GetY() - 2 )
	end
	
	return edges
	
end