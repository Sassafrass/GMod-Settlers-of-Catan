
AddCSLuaFile("cl_init.lua")
AddCSLuaFile("shared.lua")
include("shared.lua")

function ENT:Initialize()
	
	self.BaseClass.Initialize( self )
	
	self:SetModel( "models/mrgiggles/sog/house.mdl" )
	
end

function ENT:SetCorner(corner)
	self.dt.Corner = corner
end

function ENT:Upgrade()
	local city = ents.Create("CatanPieceCity")
	
	city:SetPlayer(self:GetPlayer())
	city:SetCorner(self:GetCorner())
	
	city:SetPos(self:GetPos()) -- Needed or not?
	
	self:Remove()
	
	return city
end
