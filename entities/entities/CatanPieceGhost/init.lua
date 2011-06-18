
AddCSLuaFile("cl_init.lua")
AddCSLuaFile("shared.lua")
include("shared.lua")

function ENT:Initialize()
	-- self:DrawShadow(false)
	self:SetMoveType( MOVETYPE_NONE )
end

function ENT:Setup( PType )
	
	self.PType = PType
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

function ENT:SetPlayer( CPl )
	
	self.dt.Player = CPl
	local r, g, b, a = CPl:GetCColor()
	self:SetColor( r, g, b, 200 )
	
end

function ENT:Think()
	
	local c = self:GetPlayer()
	local pos = c.trPos
	local nodraw = true
	
	if( pos ) then
		
		if( self.PType == PieceType.Village ) then
			
			local vert = self:GetBoard():GetVertexAt( self:GetBoard():WorldToVertex( pos ) )
			if( vert ) then
				
				nodraw = false
				self:SetPos( vert:GetPos() )
				self:SetAngles( vert:GetAngles() )
				
			end
			
		end
		
	end
	
	self:SetNoDraw( nodraw )
	
end