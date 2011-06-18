
ENT.Type = "anim"
ENT.Base = "catanpiece"
ENT.PieceType = PieceType.Village

function ENT:SetupDataTables()
	self.BaseClass.SetupDataTables(self)
	self:DTVar( "Entity", 2, "Corner" )
end

function ENT:GetCorner()
	return self.dt.Corner
end
