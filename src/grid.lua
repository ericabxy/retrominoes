local block = require('src.block')

-- Class table.
local grid = {
  xcount = 10,
  ycount = 15,
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
    end
  end
  return complete
end

function grid:draw(offset_x, offset_y)
  offset_x, offset_y = offset_x or 0, offset_y or 0
  love.graphics.setColor(85, 85, 85)
  love.graphics.rectangle('fill', offset_x * 16, offset_y * 16, self.xcount * 16, self.ycount * 16)
  for y = 1, self.ycount do
    for x = 1, self.xcount do
      if self.blocks[y][x] then
        self.blocks[y][x]:draw(x + offset_x, y + offset_y)
      end
    end
  end
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
