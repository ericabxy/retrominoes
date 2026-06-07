local _ = require('src.const_berbasoft')
local piece = require('src.piece')

local ellpiece = piece:new{
  color = BERBASOFT_BLOCKS_COLOR_NAME_L,
  structures = {
    {
      {' ', ' ', ' ', ' '},
      {'L', 'L', 'L', ' '},
      {'L', ' ', ' ', ' '},
      {' ', ' ', ' ', ' '},
    },
    {
      {' ', 'L', ' ', ' '},
      {' ', 'L', ' ', ' '},
      {' ', 'L', 'L', ' '},
      {' ', ' ', ' ', ' '},
    },
    {
      {' ', ' ', 'L', ' '},
      {'L', 'L', 'L', ' '},
      {' ', ' ', ' ', ' '},
      {' ', ' ', ' ', ' '},
    },
    {
      {'L', 'L', ' ', ' '},
      {' ', 'L', ' ', ' '},
      {' ', 'L', ' ', ' '},
      {' ', ' ', ' ', ' '},
    },
  },
  hue = 7
}

function ellpiece:new(o)
  o = o or {}
  setmetatable(o, self)
  self.__index = self
  return o
end

return ellpiece
