local piece = require('src.piece')

local falling_piece = piece:new{
  gravity_timer = 0,
  gravity = .03,
end

function falling_piece:update(dt, grid)
  self.gravity_timer = self.gravity_timer + dt * self.gravity
  if self.gravity_timer > 1 then
    self.gravity_timer = 0
    if not self:drop_one_row(grid) then
  end
end

-- Constructor.
function falling_piece:new(o)
  o = o or {}
  setmetatable(o, self)
  self.__index = self
  return o
end

return falling_piece
