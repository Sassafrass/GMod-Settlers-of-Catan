
GM.TurnManager = {}

ENUM( "TurnPlacement",
	"Backward",
	"Forward"
	)

ENUM( "TurnState",
	"Init",
	"Gather",
	"Trade",
	"Build"
	)

function GM.TurnManager:GetTurnManager(CGame)
    local Table = {}
    setmetatable(Table, self)
    self.__index = self
    Table.CGame = CGame
	Table.Players = table.Copy(CGame:GetPlayers())
	Table.PlayerCount = table.Count(Table.Players)
	Table.Turn = 1
	Table.TurnTotal = 0
	Table.TurnPhase = TurnState.Init
	Table.Playing = false
	Table.TurnFinished = false
	Table.InitilizationPhase = TurnPlacement.Backward
	Table.InitialRolls = {}
    return Table
end

function GM.TurnManager:SetupOrder()
	table.SortByMember(self.InitialRolls, "Roll")
	
	for k,v in pairs(self.Players) do
		if(self.InitialRolls[1].ply == v) then
			self.FirstTurn = k
			break
		end
	end
	
	self.LastTurn = self.FirstTurn + 1
	if(self.LastTurn > self.PlayerCount) then
		self.LastTurn = 1
	end
	
	self.Turn = self.FirstTurn
	
	self:StartTurn()
end

function GM.TurnManager:OnGameStarted()
	
	for k,v in pairs(self.Players) do
		v:RollDie()
	end
	
end

function GM.TurnManager:OnDiceRolled(CPlayer, Result)
	table.insert(self.InitialRolls, {ply = CPlayer, Roll = Result})
	if(table.Count(self.InitialRolls) == self.PlayerCount) then
		self:SetupOrder()
	end
end

function GM.TurnManager:GetActivePlayer()
	return self.Players[self.Turn]
end

function GM.TurnManager:FinishTurn()
	self.TurnFinished = true
end

function GM.TurnManager:IsTurnFinished()
	return self.TurnFinished
end

function GM.TurnManager:StartTurn()
	self.TurnFinished = false
	
	self.TurnTotal = self.TurnTotal + 1
	
	if(self.Turn == 0) then
		self.Turn = self.PlayerCount
	elseif(self.Turn > self.PlayerCount) then
		self.Turn = 1
	end
	
	self.CGame:OnTurnStart(self.Players[self.Turn])
	
	if(self.Playing) then
		self.TurnPhase = TurnState.Init
		self:NextPhase()
		
	else // Setting up the board
		self.CGame:PiecePlacement(self.Players[self.Turn], self.InitilizationPhase == TurnPlacement.Forward)
	end
end

function GM.TurnManager:NextPhase(TurnTotal, TurnPhase)
	if(TurnTotal and TurnPhase and (self.TurnTotal != TurnTotal or self.TurnPhase != TurnPhase)) then -- Timer stuff
		return
	end
	if(self.TurnPhase == TurnState.Build) then
		self:FinishTurn()
	else
		if(self.TurnPhase == TurnState.Init) then
			self.TurnPhase = TurnState.Gather
			self.CGame:GatherPhase()
		elseif(self.TurnPhase == TurnState.Gather) then
			self.TurnPhase = TurnState.Trade
			self.CGame:GatherPhase()
		elseif(self.TurnPhase == TurnState.Trade) then
			self.TurnPhase = TurnState.Build
			self.CGame:BuildPhase()
		end
		timer.Simple(5, self.NextPhase, self, self.TurnTotal, self.TurnPhase)
	end
end

function GM.TurnManager:Think()
	if(self.TurnFinished) then
		self:EndTurn()
		self:StartTurn()
	end
end

function GM.TurnManager:EndTurn()
	self.CGame:OnTurnEnd()
	if(self.Playing) then
		self.Turn = self.Turn + 1
	else
		if(self.InitilizationPhase == TurnPlacement.Forward) then
			if(self.Turn == self.FirstTurn) then
				self.Playing = true
				return
			else
				self.Turn = self.Turn + 1
			end
		else
			if(self.Turn == self.LastTurn) then
				self.InitilizationPhase = TurnPlacement.Forward
			else
				self.Turn = self.Turn - 1
			end
		end
	end
end