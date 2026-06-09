local _ = require('src.const_berbasoft')
local rom_imagefonts = require('src.rom_imagefonts')
local berbasoft_i = require('src.berbasoft_i')
local berbasoft_o = require('src.berbasoft_o')
local berbasoft_j = require('src.berbasoft_j')
local berbasoft_l = require('src.berbasoft_l')
local berbasoft_t = require('src.berbasoft_t')
local berbasoft_s = require('src.berbasoft_s')
local berbasoft_z = require('src.berbasoft_z')
local polyomino = require('src.polyomino')
local piece = require('src.piece')

local eyepiece = piece:new{
  color = BERBASOFT_BLOCKS_COLOR_NAME_I,
  structures = berbasoft_i,
}
local ohhpiece = piece:new{
  color = BERBASOFT_BLOCKS_COLOR_NAME_O,
  structures = berbasoft_o,
}
local jaypiece = piece:new{
  color = BERBASOFT_BLOCKS_COLOR_NAME_J,
  structures = berbasoft_j,
}
local ellpiece = piece:new{
  color = BERBASOFT_BLOCKS_COLOR_NAME_L,
  structures = berbasoft_l,
}
local teepiece = piece:new{
  color = BERBASOFT_BLOCKS_COLOR_NAME_T,
  structures = berbasoft_t,
}
local esspiece = piece:new{
  color = BERBASOFT_BLOCKS_COLOR_NAME_S,
  structures = berbasoft_s,
}
local zeepiece = piece:new{
  color = BERBASOFT_BLOCKS_COLOR_NAME_Z,
  structures = berbasoft_z,
}

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

local bag = {
  pieces = {},
  x = 256,
  y = -16,
}

function bag:init()
  self.pieces = {}
  for i = 1, 7 do
    local position = love.math.random(#self.pieces + 1)  -- Randomize insert position.
    table.insert(
      self.pieces, position, i == 1 and ellpiece:new() or i == 2 and esspiece:new() or i == 3 and eyepiece:new() or i == 4 and jaypiece:new() or i == 5 and ohhpiece:new() or i == 6 and teepiece:new() or i == 7 and zeepiece:new()
    )
  end
  return self
end

function bag:paint()
  love.graphics.setFont(rom_imagefonts[2])
  love.graphics.printf(CHARMAP, self.x, self.y, 64 - 1, 'left')
  love.graphics.setFont(rom_imagefonts[1])
  love.graphics.print('NEXT', self.x + 20, self.y + 16)
  for x = #self.pieces, 1, -1 do
    local y = (#self.pieces - x) * 16
    self.pieces[x]:paint_icon(self.x + 24, self.y + 28 + y)
  end
end

function bag:pop()
  local newpiece = table.remove(self.pieces)
  if #self.pieces == 0 then
    self:init()
  end
  return newpiece
end

function bag:rotate_queue(n)
  for i = 1, n do
    local pop = table.remove(self.pieces)
    table.insert(self.pieces, 1, pop)
  end
end

function bag:new(o)
  o = o or {}
  setmetatable(o, self)
  self.__index = self
  return o:init()
end

return bag
