--- Imagefonts and tilesets for Retrominoes.
-- 1. From [Breakout Set](https://opengameart.org/content/breakout-set) by [Buch](https://opengameart.org/users/buch)
--    Licensed [CC0](https://creativecommons.org/publicdomain/zero/1.0/)
-- 2. From [Arcade Pack](https://opengameart.org/content/arcade-pack) by [Buch](https://opengameart.org/users/buch)
--    Licensed [CC0](https://creativecommons.org/publicdomain/zero/1.0/)
-- 3. From [Arcade Pack](https://opengameart.org/content/arcade-pack) by [Buch](https://opengameart.org/users/buch)
--    Licensed [CC0](https://creativecommons.org/publicdomain/zero/1.0/)

return {
  love.graphics.newImageFont('share/buch_breakout_set_imagefont.png', 'ABCDEFGHIJKLMNOPQRSTUVWXYZ  0123456789:!\' ', 1),
  love.graphics.newImageFont('share/arcadArne_sheet_imagefont.png', '0123456789ABCDEF', 0),
  love.graphics.newImageFont('share/arcadArne_sheet_imagefont_opaque.png', '0123456789ABCDEF', 0)
}
