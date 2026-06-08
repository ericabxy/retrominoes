local _ = require('src.const_berbasoft')
local piece = require('src.piece')

local teepiece = piece:new{
  color = BERBASOFT_BLOCKS_COLOR_NAME_T,
  structures = {
    {
      {' ', ' ', ' ', ' '},
      {'T', 'T', 'T', ' '},
      {' ', 'T', ' ', ' '},
      {' ', ' ', ' ', ' '},
    },
    {
      {' ', 'T', ' ', ' '},
      {' ', 'T', 'T', ' '},
      {' ', 'T', ' ', ' '},
      {' ', ' ', ' ', ' '},
    },
    {
      {' ', 'T', ' ', ' '},
      {'T', 'T', 'T', ' '},
      {' ', ' ', ' ', ' '},
      {' ', ' ', ' ', ' '},
    },
    {
      {' ', 'T', ' ', ' '},
      {'T', 'T', ' ', ' '},
      {' ', 'T', ' ', ' '},
      {' ', ' ', ' ', ' '},
    },
  },
  hue = 13
}

function teepiece:new(o)
  o = o or {}
  setmetatable(o, self)
  self.__index = self
  return o
end

return teepiece
