
ENT.Type = "anim"
ENT.Base = "catantilesocket"

--[[
	Vertexs
	]]

function ENT:GetAdjacentVertexs()
	
	local vertexs = {}
	vertexs[ 1 ] = self:GetVertex1()
	vertexs[ 2 ] = self:GetVertex2()
	
	return vertexs
	
end

function ENT:GetVertex1()
	if( self:GetY() % 3 == 0 ) then
		return self:GetBoard():GetVertexAt( self:GetX(), self:GetY() * 2 / 3 - 1 )
	else
		return self:GetBoard():GetVertexAt( self:GetX(), (self:GetY() - 1) * 2 / 3 )
	end
end

function ENT:GetVertex2()
	if( self:GetY() % 3 == 0 ) then
		return self:GetBoard():GetVertexAt( self:GetX(), self:GetY() * 2 / 3 )
	else
		return self:GetBoard():GetVertexAt( self:GetX(), (self:GetY() - 1) * 2 / 3 + 1 )
	end
end