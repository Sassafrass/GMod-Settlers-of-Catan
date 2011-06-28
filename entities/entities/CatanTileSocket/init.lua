
AddCSLuaFile("cl_init.lua")
AddCSLuaFile("shared.lua")
include("shared.lua")

function ENT:Initialize()
	
	self:DrawShadow( false )
	
end

function ENT:SetPiece( piece )
	self.dt.Piece = piece
	piece:SetPos( self:GetPos() )
	piece:SetAngles( self:GetAngles() )
	piece:SetSocket( self )
end

function ENT:SetX( x )
	self.dt.X = x
end

function ENT:SetY( y )
	self.dt.Y = y
end

function ENT:SetBoard( board )
	self.dt.Board = board
end