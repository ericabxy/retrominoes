local _ = require('src.const_berbasoft')
local piece = require('src.piece')

local esspiece = piece:new{
  color = BERBASOFT_BLOCKS_COLOR_NAME_S,
  structures = {
    {
      {' ', ' ', ' ', ' '},
      {' ', 'S', 'S', ' '},
      {'S', 'S', ' ', ' '},
      {' ', ' ', ' ', ' '},
    },
    {
      {'S', ' ', ' ', ' '},
      {'S', 'S', ' ', ' '},
      {' ', 'S', ' ', ' '},
      {' ', ' ', ' ', ' '},
    },
  },
  hue = 16
}

function esspiece:new(o)
  o = o or {}
  setmetatable(o, self)
  self.__index = self
  return o
end

return esspiece
