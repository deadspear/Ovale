local __exports = LibStub:NewLibrary("ovale/BaseState", 10000)
if not __exports then return end
local __class = LibStub:GetLibrary("tslib").newClass
local __State = LibStub:GetLibrary("ovale/State")
local OvaleState = __State.OvaleState
local __Ovale = LibStub:GetLibrary("ovale/Ovale")
local Ovale = __Ovale.Ovale
local aceEvent = LibStub:GetLibrary("AceEvent-3.0", true)
local GetTime = GetTime
local BaseStateData = __class(nil, {
    constructor = function(self)
        self.currentTime = nil
        self.inCombat = nil
        self.combatStartTime = nil
    end
})
local BaseStateBase = OvaleState:RegisterHasState(Ovale:NewModule("BaseState", aceEvent), BaseStateData)
local BaseState = __class(BaseStateBase, {
    IsInCombat = function(self, atTime)
        return self:GetState(atTime).inCombat
    end,
    InitializeState = function(self)
        self.next.defaultTarget = "target"
    end,
    ResetState = function(self)
        local now = GetTime()
        self.next.currentTime = now
        self.next.inCombat = self.current.inCombat
        self.next.combatStartTime = self.current.combatStartTime or 0
        self.next.defaultTarget = self.current.defaultTarget
    end,
    CleanState = function(self)
    end,
})
__exports.baseState = BaseState()
OvaleState:RegisterState(__exports.baseState)
