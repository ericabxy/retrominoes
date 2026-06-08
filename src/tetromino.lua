local block = require('src.block')
local piece = require('src.piece')

local berbasoft_pieces = {
  i = dofile('share/berbasoft_i'),
  o = dofile('share/berbasoft_o'),
  j = dofile('share/berbasoft_j'),
  l = dofile('share/berbasoft_l'),
  t = dofile('share/berbasoft_t'),
  s = dofile('share/berbasoft_s'),
  z = dofile('share/berbasoft_z'),
}

-- Class table.
local tetromino = piece:new{
  name = 'i',
}

-- Initialization.
function tetromino:init()
  self.structures = berbasoft_pieces[self.name]
  return self
end

function tetromino:new(o)
  o = o or {}
  setmetatable(o, self)
  self.__index = self
  return o:init()
end

return tetromino
