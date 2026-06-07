local _ = require('src.const_berbasoft')
local piece = require('src.piece')

local zeepiece = piece:new{
  color = BERBASOFT_BLOCKS_COLOR_NAME_Z,
  structures = {
    {
      {' ', ' ', ' ', ' '},
      {'Z', 'Z', ' ', ' '},
      {' ', 'Z', 'Z', ' '},
      {' ', ' ', ' ', ' '},
    },
    {
      {' ', 'Z', ' ', ' '},
      {'Z', 'Z', ' ', ' '},
      {'Z', ' ', ' ', ' '},
      {' ', ' ', ' ', ' '},
    },
  },
}

function zeepiece:new(o)
  o = o or {}
  setmetatable(o, self)
  self.__index = self
  return o
end

return zeepiece
