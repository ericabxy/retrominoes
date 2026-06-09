local rom_imagefonts = require('src.rom_imagefonts')
local ram_sound_system = require('src.ram_sound_system')
local block = require('src.block')

local CLEARVALUES = { 200, 400, 800, 1600 }
local CHARMAP = [[
000C8000000000020000
000C8000000000020000
000C8000000000020000
EEEF8000000000020000
FFFF8000000000020000
FFFF8000000000020000
FFFF8000000000020000
FFFF8000000000020000
FFFF800000000002F00F
FFFF800000000002FFFF
FFFF800000000002FFFF
FFFF800000000002FFFF
BBBF800000000002F000
000C800000000002F000
000C800000000002FFFF
]]

local BACKGROUND_COLOR = { 27, 38, 50 }
local FOREGROUND_COLOR = { 255, 255, 255 }
local LINE_WIDTH = 8
local NUMBER_OF_LINES = 15

-- Class table.
local playfield = {
  animation_timer = 0,
  animation_frame = 1,
  animation_frame_x = 1,
  animation_frame_y = NUMBER_OF_LINES,
  n_width = LINE_WIDTH,
  n_lines = NUMBER_OF_LINES,
  blocks = {},
  xpos = 6,
  ypos = 0,
}

-- Initialization
function playfield:init()
  for y = 1, self.n_lines do
    self.blocks[y] = {}
    for x = 1, self.n_width do
      self.blocks[y][x] = false
    end
  end
  return self
end

-- Transfer an active piece to the fixed playfield.
function playfield:affix_piece(p)
  for y = 1, p.n_lines do
    for x = 1, p.n_width do
      local thisblock = p:get_block_at(x, y)
      if thisblock then
        self.blocks[-self.ypos + p.y + y][-self.xpos + p.x + x] = thisblock
      end
    end
  end
end

function playfield:animate_greyout(dt)
  if self.animation_frame_y < 1 then return true end
  self.animation_timer = self.animation_timer + dt * 1000
  if self.animation_timer > 10 then
    self.animation_timer = 0
    if self.animation_frame_x <= self.n_width then
      local thisblock = self.blocks[self.animation_frame_y][self.animation_frame_x]
      if thisblock then
        thisblock.hue = 25
        thisblock:init()
      end
      self.animation_frame_x = self.animation_frame_x + 1
    else
      self.animation_frame_x = 1
      self.animation_frame_y = self.animation_frame_y - 1
    end
  end
end

function playfield:clear_lines()
  local points = false
  local complete
  for y = 1, self.n_lines do
    complete = true
    for x = 1, self.n_width do
      if not self.blocks[y][x] then
        complete = false
        break
      end
    end
    if complete then
      for remove_y = y, 2, -1 do
        for remove_x = 1, self.n_width do
          self.blocks[remove_y][remove_x] =
          self.blocks[remove_y - 1][remove_x]
        end
      end
      for remove_x = 1, self.n_width do
        self.blocks[1][remove_x] = nil
      end
      points = points and points * 2 or 200
    end
  end
  if points then ram_sound_system.line_clear() end
  return points
end

function playfield:is_empty_at(x, y)
  x, y = x - self.xpos, y - self.ypos
  if x < 1 or x > self.n_width then return end
  if y < 1 or y > self.n_lines then return end
  if not self.blocks[y][x] then return true end
end

function playfield:paint()
  --love.graphics.setFont(rom_imagefonts[2])
  --love.graphics.printf(CHARMAP, 0, 0, 319, 'left')
  love.graphics.setColor(BACKGROUND_COLOR)
  love.graphics.rectangle('fill', self.xpos * 16, self.ypos * 16, self.n_width * 16, self.n_lines * 16)
  love.graphics.setColor(FOREGROUND_COLOR)
  for y = 1, self.n_lines do
    for x = 1, self.n_width do
      if self.blocks[y][x] then
        self.blocks[y][x]:draw(self.xpos + x, self.ypos + y)
      end
    end
  end
end

-- Constructor.
function playfield:new(o)
  o = o or {}
  setmetatable(o, self)
  self.__index = self
  return o:init()
end

return playfield
