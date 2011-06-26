
AddCSLuaFile("cl_init.lua")
AddCSLuaFile("shared.lua")
include("shared.lua")

function ENT:Initialize()
	
	self.BaseClass.Initialize( self )
	
	self:SetModel( "models/mrgiggles/sog/road.mdl" )
	
end

function ENT:SetEdge(edge)
	self.dt.Edge = edge
end
