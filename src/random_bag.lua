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

local eyepiece = polyomino:new{
  color = BERBASOFT_BLOCKS_COLOR_NAME_I,
  structures = berbasoft_i,
}
local ohhpiece = polyomino:new{
  color = BERBASOFT_BLOCKS_COLOR_NAME_O,
  structures = berbasoft_o,
}
local jaypiece = polyomino:new{
  color = BERBASOFT_BLOCKS_COLOR_NAME_J,
  structures = berbasoft_j,
}
local ellpiece = polyomino:new{
  color = BERBASOFT_BLOCKS_COLOR_NAME_L,
  structures = berbasoft_l,
}
local teepiece = polyomino:new{
  color = BERBASOFT_BLOCKS_COLOR_NAME_T,
  structures = berbasoft_t,
}
local esspiece = polyomino:new{
  color = BERBASOFT_BLOCKS_COLOR_NAME_S,
  structures = berbasoft_s,
}
local zeepiece = polyomino:new{
  color = BERBASOFT_BLOCKS_COLOR_NAME_Z,
  structures = berbasoft_z,
}

local random_bag = {
  pieces = {},
  x = 0,
  y = 0,
}

function random_bag:init()
  self.pieces = {}
  for i = 1, 7 do
    local position = love.math.random(#self.pieces + 1)  -- Randomize insert position.
    table.insert(
      self.pieces, position, i == 1 and ellpiece:new() or i == 2 and esspiece:new() or i == 3 and eyepiece:new() or i == 4 and jaypiece:new() or i == 5 and ohhpiece:new() or i == 6 and teepiece:new() or i == 7 and zeepiece:new()
    )
  end
  return self
end

function random_bag:paint()
  love.graphics.setFont(rom_imagefonts[1])
  love.graphics.print('NEXT', self.x + 20, self.y + 16)
  for x = #self.pieces, 1, -1 do
    local y = (#self.pieces - x) * 16
    self.pieces[x]:paint_icon(self.x + 24, self.y + 28 + y)
  end
end

function random_bag:pop()
  local newpiece = table.remove(self.pieces)
  if #self.pieces == 0 then
    self:init()
  end
  return newpiece
end

function random_bag:rotate_queue(n)
  for i = 1, n do
    local pop = table.remove(self.pieces)
    table.insert(self.pieces, 1, pop)
  end
end

function random_bag:new(o)
  o = o or {}
  setmetatable(o, self)
  self.__index = self
  return o:init()
end

return random_bag
