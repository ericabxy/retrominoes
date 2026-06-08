local block = require('src.block')
local piece = require('src.piece')

-- Class table.
local domino = piece:new{
  name = '*',
  structures = {
    {
      { ' ', ' ' },
      { '*', '*' }
    },
    {
      { '*', ' ' },
      { '*', ' ' }
    },
    {
      { '*', '*' },
      { ' ', ' ' }
    },
    {
      { ' ', '*' },
      { ' ', '*' }
    }
  }
}

-- Initialization.
function tetromino:init()
  return self
end

function tetromino:new(o)
  o = o or {}
  setmetatable(o, self)
  self.__index = self
  return o:init()
end

return tetromino
