
ENT.Type = "anim"
ENT.Base = "catanpiece"
ENT.PieceType = PieceType.Road

function ENT:SetupDataTables()
	self.BaseClass.SetupDataTables(self)
	self:DTVar( "Entity", 2, "Edge" )
end

function ENT:GetEdge()
	return self.dt.Edge
end
