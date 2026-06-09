local ram_sound_system = require('src.ram_sound_system')
local block = require('src.block')

local EMPTY = ' '

local polyomino = {
  structures = {
    {
      {' ', ' ', ' ', ' '},
      {' ', 'I', 'I', ' '},
      {' ', ' ', ' ', ' '},
      {' ', ' ', ' ', ' '},
    },
    {
      {' ', ' ', ' ', ' '},
      {' ', 'I', ' ', ' '},
      {' ', 'I', ' ', ' '},
      {' ', ' ', ' ', ' '},
    },
  },
  rotation = 1,
  n_lines = 4,
  n_width = 4,
  value = 0,  -- Bonus points to score when this polyomino lands successfully.
  hue = 1,
  x = 8,
  y = 1,
}

function polyomino:can_move(test_x, test_y, grid, r)
  r = r or self.rotation
  for y = 1, #self.structures[r] do
    for x = 1, #self.structures[r][y] do
      if self.structures[r][y][x] ~= EMPTY
        and not grid:is_empty_at(test_x + x, test_y + y)
      then
        return false
      end
    end
  end
  return true
end

function polyomino:drop_one_row(grid)
  local testy = self.y + 1
  if self:can_move(self.x, testy, grid) then
    self.y = testy
    return true
  end
end

function polyomino:get_block_at(x, y)
  if self.structures[self.rotation][y][x] == ' ' then return end
  return block:new{ letter = self.structures[self.rotation][y][x], hue = self.hue }
end

function polyomino:move_down(grid)
  local testy = self.y + 1
  if self:can_move(self.x, testy, grid) then
    self.y = testy
    return true
  end
end

function polyomino:move_left(grid)
  local testx = self.x - 1
  if self:can_move(self.x - 1, self.y, grid) then
    self.x = self.x - 1
    return true
  end
end

function polyomino:move_right(grid)
  if self:can_move(self.x + 1, self.y, grid) then
    self.x = self.x + 1
    return true
  end
end

function polyomino:paint()
  for y = 1, #self.structures[self.rotation] do
    for x = 1, #self.structures[self.rotation][y] do
      local thisblock = block:new{
        letter = self.structures[self.rotation][y][x],
        hue = self.hue
      }
      if thisblock.letter ~= ' ' then
        thisblock:draw(x + self.x, y + self.y)
      end
    end
  end
end

function polyomino:paint_icon(ox, oy)
  ox, oy = ox or 0, oy or 0
  for y = 1, #self.structures[self.rotation] do
    for x = 1, #self.structures[self.rotation][y] do
      local letter = self.structures[self.rotation][y][x]
      if letter ~= ' ' then
        love.graphics.setColor(self.color)
        love.graphics.rectangle('fill', ox + (x - 1) * 4, oy + (y - 1) * 4, 4, 4)
      end
    end
  end
end

-- Rotate counterclockwise (widderschynnes).
function polyomino:reverse(grid)
  local testr = self.rotation + 1
  if testr > #self.structures then testr = 1 end
  if self:can_move(self.x, self.y, grid, testr) then
    ram_sound_system.sfx_rotate()
    self.rotation = testr
    return true
  end
end

-- Rotate clockwise (deosil).
function polyomino:rotate(grid)
  local testr = self.rotation - 1
  if testr < 1 then testr = #self.structures end
  if self:can_move(self.x, self.y, grid, testr) then
    ram_sound_system.sfx_rotate()
    self.rotation = testr
    return true
  end
end

function polyomino:new(o)
  o = o or {}
  setmetatable(o, self)
  self.__index = self
  return o
end

return polyomino
