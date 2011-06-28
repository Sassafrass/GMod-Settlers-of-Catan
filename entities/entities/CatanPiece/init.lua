
AddCSLuaFile("cl_init.lua")
AddCSLuaFile("shared.lua")
include("shared.lua")

function ENT:Initialize()
	-- self:DrawShadow(false)
	self:SetMoveType( MOVETYPE_NONE )
end

function ENT:SetPlayer( CPl )
	
	self.dt.Player = CPl
	self:SetColor( CPl:GetCColor() )
	
end

function ENT:SetSocket( socket )
	
	self.dt.Socket = socket
	
end

function ENT:SetBoard( board )
	
	self.dt.Board = board
	
end