local rom_imagefonts = require('src.rom_imagefonts')
local ram_sound_system = require('src.ram_sound_system')
local block = require('src.block')

local CLEARVALUES = { 40, 100, 300, 1200 }
local CHARMAP = [[
000C800000000002D00C
000C800000000002D00C
000C800000000002D00C
EEEF800000000002D00C
FFFF800000000002D00C
FFFF800000000002D00C
FFFF800000000002D00C
FFFF800000000002D00C
FFFF800000000002FEEF
FFFF800000000002FFFF
FFFF800000000002FFFF
FFFF800000000002FFFF
BBBF800000000002F000
000C800000000002F000
000C800000000002FFFF
]]

-- Class table.
local grid = {
  current_score = 0,
  highest_score = 0,
  xcount = 10,
  ycount = 18,
  blocks = {},
}

-- Initialization
function grid:init()
  for y = 1, self.ycount do
    self.blocks[y] = {}
    for x = 1, self.xcount do
      self.blocks[y][x] = false
    end
  end
  return self
end

-- Transfer an active piece to the fixed grid.
function grid:affix_piece(p)
  for y = 1, p.ycount do
    for x = 1, p.xcount do
      local thisblock = p:get_block_at(x, y)
      if thisblock then
        self.blocks[p.y + y][p.x + x] = thisblock
      end
    end
  end
end

function grid:clear_completed_rows()
  local lines_cleared = 0
  local complete
  for y = 1, self.ycount do
    complete = true
    for x = 1, self.xcount do
      if not self.blocks[y][x] then
        complete = false
        break
      end
    end
    if complete then
      for remove_y = y, 2, -1 do
        for remove_x = 1, self.xcount do
          self.blocks[remove_y][remove_x] =
          self.blocks[remove_y - 1][remove_x]
        end
      end
      for remove_x = 1, self.xcount do
        self.blocks[1][remove_x] = nil
      end
      lines_cleared = lines_cleared + 1
    end
  end
  if complete then
    ram_sound_system.line_clear()
    self.current_score = self.current_score + CLEARVALUES[lines_cleared]
  end
  return totalscore
end

function grid:draw(offset_x, offset_y)
  love.graphics.setFont(rom_imagefonts[2])
  love.graphics.printf(CHARMAP, 0, 0, 319, 'left')
  love.graphics.setFont(rom_imagefonts[1])
  love.graphics.print('HISCORE', 0, 0)
  love.graphics.print(self.highest_score, 0, 9)
  love.graphics.print('SCORE', 0, 24)
  love.graphics.print(self.current_score, 0, 33)
  offset_x, offset_y = offset_x or 0, offset_y or 0
  for y = 1, self.ycount do
    for x = 1, self.xcount do
      if self.blocks[y][x] then
        self.blocks[y][x]:draw(x + offset_x, y + offset_y)
      end
    end
  end
end

function grid:grey_out_block_at(x, y)
  local thisblock = self.blocks[y][x]
end

function grid:is_empty_at(x, y)
  if x < 1 or x > self.xcount then return end
  if y < 1 or y > self.ycount then return end
  if not self.blocks[y][x] then return true end
end

function grid:new(o)
  o = o or {}
  setmetatable(o, self)
  self.__index = self
  return o:init()
end

return grid
