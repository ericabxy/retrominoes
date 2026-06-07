local block = require('src.block')

local EMPTY = ' '

local piece = {
  rotation = 1,
  structures = {
    {
      {' ', ' ', ' ', ' '},
      {' ', '.', '.', ' '},
      {' ', ' ', ' ', ' '},
      {' ', ' ', ' ', ' '},
    },
    {
      {' ', ' ', ' ', ' '},
      {' ', '.', ' ', ' '},
      {' ', '.', ' ', ' '},
      {' ', ' ', ' ', ' '},
    },
  },
  hue = 1,
  xcount = 4,
  ycount = 4,
  x = 3,
  y = -1,
}

function piece:can_move(test_x, test_y, inert)
  for y = 1, #self.structures[self.rotation] do
    for x = 1, #self.structures[self.rotation][y] do
      if self.structures[self.rotation][y][x] ~= EMPTY
        and not inert:is_empty_at(test_x + x, test_y + y)
      then
        return false
      end
    end
  end
  return true
end

function piece:draw(offset_x, offset_y)
  for y = 1, #self.structures[self.rotation] do
    for x = 1, #self.structures[self.rotation][y] do
      local thisblock = block:new{
        letter = self.structures[self.rotation][y][x],
        hue = self.hue
      }
      if thisblock.letter ~= ' ' then
        thisblock:draw(x + self.x + offset_x, y + self.y + offset_y)
      end
    end
  end
end

function piece:get_block_at(x, y)
  if self.structures[self.rotation][y][x] == ' ' then return end
  return block:new{ letter = self.structures[self.rotation][y][x], hue = self.hue }
end

function piece:new(o)
  o = o or {}
  setmetatable(o, self)
  self.__index = self
  return o
end

return piece
