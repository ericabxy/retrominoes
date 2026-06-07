local rom_buch_arcade_pack = require('src.rom_buch_arcade_pack')

local colors = {
  [' '] = { 221.85, 221.85, 221.85 },
  I = { 119.85, 193.8, 239.7 },
  J = { 237.15, 232.05, 107.1 },
  L = { 124.95, 216.75, 193.8 },
  O = { 234.6, 175.95, 119.85 },
  S = { 211.65, 137.7, 237.15 },
  T = { 247.35, 147.9, 196.35 },
  Z = { 168.3, 211.65, 117.3 },
}

local quads = {
  [' '] = love.graphics.newQuad(780, 1028, 16, 16, 796, 1052),
  I = love.graphics.newQuad(268, 348, 16, 16, 796, 1052),
  J = love.graphics.newQuad(268, 748, 16, 16, 796, 1052),
  L = love.graphics.newQuad(268, 308, 16, 16, 796, 1052),
  O = love.graphics.newQuad(268, 708, 16, 16, 796, 1052),
  S = love.graphics.newQuad(268, 588, 16, 16, 796, 1052),
  T = love.graphics.newQuad(268, 548, 16, 16, 796, 1052),
  Z = love.graphics.newQuad(268, 28, 16, 16, 796, 1052),
}

local block = {
  texture = rom_buch_arcade_pack.texture,
  quad = love.graphics.newQuad(780, 1028, 16, 16, 796, 1052),
  color = { 221.85, 221.85, 221.85 },
  letter = ' ',
  size = 16,
  drawsize = 15,
  hue = 1,
}

function block:init()
  self.quad = rom_buch_arcade_pack.block0[self.hue]
  return self
end

function block:draw(x, y)
  love.graphics.draw(self.texture, self.quad, (x - 1) * self.size, (y - 1) * self.size)
end

function block:new(o)
  o = o or {}
  setmetatable(o, self)
  self.__index = self
  return o:init()
end

return block
