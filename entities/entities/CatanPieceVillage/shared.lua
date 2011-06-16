
ENT.Type = "anim"
ENT.Base = "catanpiece"

function ENT:SetupDataTables()
	self.BaseClass.SetupDataTables(self)
	self:DTVar( "Entity", 2, "Corner" )
end

function ENT:GetCorner()
	return self.dt.Corner
end
