local ellpiece = require('src.ellpiece')
local ohhpiece = require('src.ohhpiece')
local jaypiece = require('src.jaypiece')
local esspiece = require('src.esspiece')
local zeepiece = require('src.zeepiece')
local teepiece = require('src.teepiece')
local eyepiece = require('src.eyepiece')

local sequence = {
  pieces = {},
}

function sequence:init()
  self.pieces = {}
  for i = 1, 7 do
    local position = love.math.random(#self.pieces + 1)
    table.insert(
      self.pieces, position, i == 1 and ellpiece:new() or i == 2 and esspiece:new() or i == 3 and eyepiece:new() or i == 4 and jaypiece:new() or i == 5 and ohhpiece:new() or i == 6 and teepiece:new() or i == 7 and zeepiece:new()
    )
  end
  return self
end

function sequence:pop()
  local newpiece = table.remove(self.pieces)
  if #self.pieces == 0 then
    self:init()
  end
  return newpiece
end

function sequence:new(o)
  o = o or {}
  setmetatable(o, self)
  self.__index = self
  return o:init()
end

return sequence
