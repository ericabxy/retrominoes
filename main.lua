local _ = require('src.const_libretro')
local _ = require('src.const_berbasoft')
local block = require('src.block')
local grid = require('src.grid')
local rom_sound_effects_8_bit_style = require('src.rom_sound_effects_8_bit_style')
local rom_ragnar_random_fakebit_chiptune_music_pack = require('src.rom_ragnar_random_fakebit_chiptune_music_pack')
local sequence = require('src.sequence')

local CONTROLLER_NUMBER = 1
local thispiece = false
local nextpiece = sequence:new()

function love.load()
  inert = grid:new()
  
  timer = 0
  timer_limit = 0.5
end

function love.update(dt)
  if not thispiece then return end
  timer = timer + dt
  if love.joystick.isDown(CONTROLLER_NUMBER, RETRO_DEVICE_ID_JOYPAD_DOWN) then timer = timer + dt * 5 end
  if timer >= timer_limit then
    timer = 0
    
    if not thispiece:drop_one_row(inert) then
      rom_sound_effects_8_bit_style:piece_drop()
      for y = 1, thispiece.ycount do
        for x = 1, thispiece.xcount do
          local thisblock = thispiece:get_block_at(x, y)
          if thisblock then
            inert.blocks[thispiece.y + y][thispiece.x + x] = thisblock
          end
        end
      end
      thispiece = nextpiece:pop()
    end
  end
  if inert:clear_completed_rows() then rom_sound_effects_8_bit_style:line_clear() end
end

function love.draw()
  inert:draw(5, 0)
  if not thispiece then return end
  thispiece:draw(5, 0)
end

function love.joystickpressed(n, b)
  n, b = n + 1, b + 1
  if n == CONTROLLER_NUMBER and b == RETRO_DEVICE_ID_JOYPAD_START then
    if not thispiece then thispiece = nextpiece:pop() end
    rom_ragnar_random_fakebit_chiptune_music_pack:bgm1(true)
  end
  if not thispiece then return end
  if n == CONTROLLER_NUMBER and (b == RETRO_DEVICE_ID_JOYPAD_B or b == RETRO_DEVICE_ID_JOYPAD_X) then
    thispiece:rotate_counterclockwise(inert)
  elseif n == CONTROLLER_NUMBER and b == RETRO_DEVICE_ID_JOYPAD_DOWN then
    local testy = thispiece.y + 1
    if thispiece:can_move(thispiece.x, testy, inert) then
      thispiece.y = testy
    end
  elseif n == CONTROLLER_NUMBER and b == RETRO_DEVICE_ID_JOYPAD_LEFT then
    local testx = thispiece.x - 1
    if thispiece:can_move(testx, thispiece.y, inert) then
      thispiece.x = testx
    end
  elseif n == CONTROLLER_NUMBER and b == RETRO_DEVICE_ID_JOYPAD_RIGHT then
    local testx = thispiece.x + 1
    if thispiece:can_move(testx, thispiece.y, inert) then
      thispiece.x = testx
    end
  elseif n == CONTROLLER_NUMBER and (b == RETRO_DEVICE_ID_JOYPAD_A or b == RETRO_DEVICE_ID_JOYPAD_Y) then
    thispiece:rotate_clockwise(inert)
  end
end
