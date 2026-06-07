local function block0 (h)
  h = h and h * 40 or 0
  return love.graphics.newQuad(268, 28 + h, 16, 16, 796, 1052)
end

local function block1 (h)
  h = h and h * 40 or 0
  return love.graphics.newQuad(564, 28 + h, 16, 16, 796, 1052)
end

local function block2 (h)
  h = h and h * 40 or 0
  return love.graphics.newQuad(508, 28 + h, 16, 16, 796, 1052)
end

local function block3 (h)
  h = h and h * 40 or 0
  return love.graphics.newQuad(400, 28 + h, 16, 16, 796, 1052)
end

local function block4 (h)
  h = h and h * 40 or 0
  return love.graphics.newQuad(544, 28 + h, 16, 16, 796, 1052)
end

local function block5 (h)
  h = h and h * 40 or 0
  return love.graphics.newQuad(344, 28 + h, 16, 16, 796, 1052)
end

local function block6 (h)
  h = h and h * 40 or 0
  return love.graphics.newQuad(364, 28 + h, 16, 16, 796, 1052)
end

local function block7 (h)
  h = h and h * 40 or 0
  return love.graphics.newQuad(472, 28 + h, 16, 16, 796, 1052)
end

local rom_buch_arcade_pack = {
  texture = love.graphics.newImage('share/arcadArne_sheet.png'),
  block0 = {},
  block1 = {},
  block2 = {},
  block3 = {},
  block4 = {},
  block5 = {},
  block6 = {},
  block7 = {}
}

for hue = 0, 26 do
  table.insert(rom_buch_arcade_pack.block0, block0(hue))
  table.insert(rom_buch_arcade_pack.block1, block1(hue))
  table.insert(rom_buch_arcade_pack.block2, block2(hue))
  table.insert(rom_buch_arcade_pack.block3, block3(hue))
  table.insert(rom_buch_arcade_pack.block4, block4(hue))
  table.insert(rom_buch_arcade_pack.block5, block5(hue))
  table.insert(rom_buch_arcade_pack.block6, block6(hue))
  table.insert(rom_buch_arcade_pack.block7, block7(hue))
end

return rom_buch_arcade_pack
