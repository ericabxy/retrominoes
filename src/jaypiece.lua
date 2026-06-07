local rom_buch_arcade_pack = require('src.rom_buch_arcade_pack')
local _ = require('src.const_berbasoft')
local piece = require('src.piece')

local x00 = rom_buch_arcade_pack.block0[1]
local x01 = rom_buch_arcade_pack.block1[1]
local x02 = rom_buch_arcade_pack.block2[1]
local x03 = rom_buch_arcade_pack.block3[1]
local x04 = rom_buch_arcade_pack.block4[1]
local x05 = rom_buch_arcade_pack.block5[1]
local x06 = rom_buch_arcade_pack.block6[1]
local x07 = rom_buch_arcade_pack.block7[1]

local jaypiece = piece:new{
  color = BERBASOFT_BLOCKS_COLOR_NAME_J,
  structures = {
    {
      {' ', ' ', ' ', ' '},
      {'J', 'J', 'J', ' '},
      {' ', ' ', 'J', ' '},
      {' ', ' ', ' ', ' '},
    },
    {
      {' ', 'J', ' ', ' '},
      {' ', 'J', ' ', ' '},
      {'J', 'J', ' ', ' '},
      {' ', ' ', ' ', ' '},
    },
    {
      {'J', ' ', ' ', ' '},
      {'J', 'J', 'J', ' '},
      {' ', ' ', ' ', ' '},
      {' ', ' ', ' ', ' '},
    },
    {
      {' ', 'J', 'J', ' '},
      {' ', 'J', ' ', ' '},
      {' ', 'J', ' ', ' '},
      {' ', ' ', ' ', ' '},
    },
  },
  hue = 18
}

function jaypiece:new(o)
  o = o or {}
  setmetatable(o, self)
  self.__index = self
  return o
end

return jaypiece
