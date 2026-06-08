local font = require('src.rom_buch_breakout_set_imagefont')
local font2 = require('src.rom_buch_arcade_pack_imagefont')
local _ = require('src.const_libretro')
local _ = require('src.const_berbasoft')
local block = require('src.block')
local grid = require('src.grid')
local rom_sound_effects_8_bit_style = require('src.rom_sound_effects_8_bit_style')
local rom_ragnar_random_fakebit_chiptune_music_pack = require('src.rom_ragnar_random_fakebit_chiptune_music_pack')
local sequence = require('src.sequence')

local CONTROLLER_NUMBER = 1
local TIMER_LIMIT = 0.5
local timer = 0
local hiscore = 0
local score = 0
local thispiece = false
local nextpiece = sequence:new()
local grid_of_inert_blocks = grid:new()

function restart_game()
  rom_ragnar_random_fakebit_chiptune_music_pack:bgm1(true)
  grid_of_inert_blocks = grid:new()
  hiscore = math.max(score, hiscore)
  score = 0
  timer = 0
  thispiece = nextpiece:pop()
end

function love.load()
  love.graphics.setBackgroundColor(27, 38, 50)
end

function love.update(dt)
  -- Execute no game logic if game is not started.
  if not thispiece then return end
  -- Increment drop timer by time elapsed.
  timer = timer + dt
  -- Speed up timer if DOWN button is held.
  if love.joystick.isDown(CONTROLLER_NUMBER, RETRO_DEVICE_ID_JOYPAD_DOWN) then
    timer = timer + dt * 5
  end
  if timer >= TIMER_LIMIT then
    timer = 0
    
    if not thispiece:drop_one_row(grid_of_inert_blocks) then
      rom_sound_effects_8_bit_style:piece_drop()
      grid_of_inert_blocks:affix_piece(thispiece)
      thispiece = nextpiece:pop()
      if not thispiece:can_move(thispiece.x, thispiece.y, grid_of_inert_blocks) then
        rom_ragnar_random_fakebit_chiptune_music_pack.bgm1(false)
        thispiece = false
      end
    end
  end
  local value = grid_of_inert_blocks:clear_completed_rows()
  if value then score = score + value end
end

function love.draw()
  grid_of_inert_blocks:draw(5, -3)
  if thispiece then thispiece:draw(5, -3) end
  love.graphics.setColor(255, 255, 255)
  love.graphics.setFont(font2)
  love.graphics.printf([[
D00F800000000002FBBB
D00F800000000002D000
D00F800000000002D000
D00F800000000002D000
D00F800000000002D000
D00F800000000002FEEE
D00F800000000002FFFF
FEEF800000000002FFFF
FFFF800000000002FFFF
FFFF800000000002FFFF
FFFF800000000002FFFF
FFFF800000000002FFFF
FFFF800000000002FFFF
FFFF800000000002FFFF
FFFF800000000002FFFF
  ]], 0, 0, 319, 'left')
  love.graphics.setFont(font)
  love.graphics.print('HISCORE', 272, 24)
  love.graphics.print(hiscore, 272, 33)
  love.graphics.print('SCORE', 272, 56)
  love.graphics.print(score, 272, 65)
  nextpiece:paint(24, 0)
end

function love.joystickpressed(n, b)
  n, b = n + 1, b + 1
  if n == CONTROLLER_NUMBER and b == RETRO_DEVICE_ID_JOYPAD_START then
    if not thispiece then restart_game() end
  end
  if not thispiece then return end
  if n == CONTROLLER_NUMBER and (b == RETRO_DEVICE_ID_JOYPAD_B or b == RETRO_DEVICE_ID_JOYPAD_X) then
    thispiece:rotate_counterclockwise(grid_of_inert_blocks)
  elseif n == CONTROLLER_NUMBER and b == RETRO_DEVICE_ID_JOYPAD_DOWN then
    local testy = thispiece.y + 1
    if thispiece:can_move(thispiece.x, testy, grid_of_inert_blocks) then
      thispiece.y = testy
    end
  elseif n == CONTROLLER_NUMBER and b == RETRO_DEVICE_ID_JOYPAD_LEFT then
    local testx = thispiece.x - 1
    if thispiece:can_move(testx, thispiece.y, grid_of_inert_blocks) then
      thispiece.x = testx
    end
  elseif n == CONTROLLER_NUMBER and b == RETRO_DEVICE_ID_JOYPAD_RIGHT then
    local testx = thispiece.x + 1
    if thispiece:can_move(testx, thispiece.y, grid_of_inert_blocks) then
      thispiece.x = testx
    end
  elseif n == CONTROLLER_NUMBER and (b == RETRO_DEVICE_ID_JOYPAD_A or b == RETRO_DEVICE_ID_JOYPAD_Y) then
    thispiece:rotate_clockwise(grid_of_inert_blocks)
  end
end
