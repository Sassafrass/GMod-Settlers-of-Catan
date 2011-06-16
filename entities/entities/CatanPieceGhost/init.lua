
AddCSLuaFile("cl_init.lua")
AddCSLuaFile("shared.lua")
include("shared.lua")

function GAMEMODE:CreateGhost( CBoard, CPlayer, PType )
	
	local g = ents.Create( "CatanPieceGhost" )
	g:SetNoDraw( true )
	g:SetBoard( CBoard )
	g:SetPlayer( CPlayer )
	g:Setup( PType )
	g:Spawn()
	g:Activate()
	
	return g
	
end

function ENT:Initialize()
	-- self:DrawShadow(false)
	self:SetMoveType( MOVETYPE_NONE )
end

ENUM( "PieceType",
	"Road",
	"Village",
	"City",
	"Robber"
	)

function ENT:Setup( PType )
	
	if( PType == PieceType.Road ) then
		
		self:SetModel( "models/mrgiggles/sog/road.mdl" )
		
	elseif( PType == PieceType.Village ) then
		
		self:SetModel( "models/mrgiggles/sog/house.mdl" )
		
	elseif( PType == PieceType.City ) then
		
		self:SetModel( "models/mrgiggles/sog/house_large.mdl" )
		
	elseif( PType == PieceType.City ) then
		
		self:SetModel( "models/mrgiggles/sog/robber.mdl" )
		
	end
	
end

function ENT:Think()
	
	local c = self:GetPlayer()
	local pos = c.trPos
	local nodraw = true
	
	if( pos ) then
		
		self:SetPos( pos )
		nodraw = false
		
	end
	
	self:SetNoDraw( nodraw )
	
end