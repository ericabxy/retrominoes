local _ = require('src.const_berbasoft')
local piece = require('src.piece')

local eyepiece = piece:new{
  color = BERBASOFT_BLOCKS_COLOR_NAME_I,
  structures = {
    {
      {' ', ' ', ' ', ' '},
      {'I', 'I', 'I', 'I'},
      {' ', ' ', ' ', ' '},
      {' ', ' ', ' ', ' '},
    },
    {
      {' ', 'I', ' ', ' '},
      {' ', 'I', ' ', ' '},
      {' ', 'I', ' ', ' '},
      {' ', 'I', ' ', ' '},
    },
  },
  hue = 8
}

function eyepiece:new(o)
  o = o or {}
  setmetatable(o, self)
  self.__index = self
  return o
end

return eyepiece
