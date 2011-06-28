
ENT.Type = "anim"
ENT.Base = "base_anim"

function ENT:SetupDataTables()
	self:DTVar( "Entity", 0, "Player" )
	self:DTVar( "Entity", 1, "Board" )
	self:DTVar( "Entity", 2, "Socket" )
end

function ENT:GetPlayer()
	return self.dt.Player
end

function ENT:GetBoard()
	return self.dt.Board
end

function ENT:GetSocket()
	return self.dt.Socket
end