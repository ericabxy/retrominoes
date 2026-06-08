local rom_imagefonts = require('src.rom_imagefonts')
local ellpiece = require('src.ellpiece')
local ohhpiece = require('src.ohhpiece')
local jaypiece = require('src.jaypiece')
local esspiece = require('src.esspiece')
local zeepiece = require('src.zeepiece')
local teepiece = require('src.teepiece')
local eyepiece = require('src.eyepiece')

local CHARMAP = [[
0BB0
D00C
D00C
D00C
D00C
D00C
D00C
D00C
D00C
0EE0
]]

local sequence = {
  pieces = {},
  x = 256,
  y = -16,
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

function sequence:paint()
  love.graphics.setFont(rom_imagefonts[2])
  love.graphics.printf(CHARMAP, self.x, self.y, 64 - 1, 'left')
  love.graphics.setFont(rom_imagefonts[1])
  love.graphics.print('NEXT', self.x + 20, self.y + 16)
  for x = #self.pieces, 1, -1 do
    local y = (#self.pieces - x) * 16
    self.pieces[x]:paint_icon(self.x + 24, self.y + 28 + y)
  end
end

function sequence:pop()
  local newpiece = table.remove(self.pieces)
  if #self.pieces == 0 then
    self:init()
  end
  return newpiece
end

function sequence:rotate_queue(n)
  for i = 1, n do
    local pop = table.remove(self.pieces)
    table.insert(self.pieces, 1, pop)
  end
end

function sequence:new(o)
  o = o or {}
  setmetatable(o, self)
  self.__index = self
  return o:init()
end

return sequence
