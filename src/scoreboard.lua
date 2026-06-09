local rom_imagefonts = require('src.rom_imagefonts')

local scoreboard = {
  current_score = 0,
  highest_score = 0,
  x = 0,
  y = 20
}

function scoreboard:paint()
  love.graphics.setFont(rom_imagefonts[1])
  love.graphics.print('HISCORE ', self.x, self.y)
  love.graphics.print(self.highest_score, self.x, self.y + 9)
  love.graphics.print('SCORE', self.x, self.y + 24)
  love.graphics.print(self.current_score, self.x, self.y + 33)
end

function scoreboard:new(o)
  o = o or {}
  setmetatable(o, self)
  self.__index = self
  return o
end

return scoreboard
