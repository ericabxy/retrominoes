local _ = require('src.const_berbasoft')
local piece = require('src.piece')

local ohhpiece = piece:new{
  color = BERBASOFT_BLOCKS_COLOR_NAME_O,
  structures = {
    {
      {' ', ' ', ' ', ' '},
      {' ', 'O', 'O', ' '},
      {' ', 'O', 'O', ' '},
      {' ', ' ', ' ', ' '},
    },
  },
  hue = 17
}

function ohhpiece:new(o)
  o = o or {}
  setmetatable(o, self)
  self.__index = self
  return o
end

return ohhpiece
