
ENT.Type = "anim"
ENT.Base = "base_anim"

ENT.AdjacentTiles = {}
ENT.ConnectedEdges = {}

function ENT:SetupDataTables()
	self:DTVar( "Int", 0, "X" )
	self:DTVar( "Int", 1, "Y" )
	self:DTVar( "Entity", 0, "Board" )
	self:DTVar( "Entity", 1, "Piece" )
end

function ENT:GetPiece()
	return self.dt.Piece
end

function ENT:GetBoard()
	return self.dt.Board
end

function ENT:GetX()
	return self.dt.X
end

function ENT:GetY()
	return self.dt.Y
end