local _ = require('src.const_libretro')
local _ = require('src.const_berbasoft')
local ram_sound_system = require('src.ram_sound_system')
local rom_imagefonts = require('src.rom_imagefonts')
local block = require('src.block')
local playfield = require('src.playfield')
local bag = require('src.bag')

local CONTROLLER_NUMBER = 1
local TIMER_LIMIT = 0.5
local player_settings_music = true
local player_settings_music_string = 'ON'
local player_settings_sound = true
local player_settings_sound_string = 'ON'
local timer = 0
local thispiece = false
local nextpiece = bag:new()
local playfield0 = playfield:new()
local gameover = false

function restart_game()
  timer = 0
  playfield0 = playfield:new{ highest_score = math.max(playfield0.highest_score, playfield0.current_score) }
  thispiece = nextpiece:pop()
  ram_sound_system.start_music()
  gameover = false
end

function love.load()
  love.graphics.setBackgroundColor(27, 38, 50)
end

function love.update(dt)
  -- Do greyout animation.
  if gameover then gameover = not playfield0:animate_greyout(dt) end
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
    
    if not thispiece:drop_one_row(playfield0) then
      ram_sound_system.piece_drop()
      playfield0:affix_piece(thispiece)
      thispiece = nextpiece:pop()
      if not thispiece:can_move(thispiece.x, thispiece.y, playfield0) then
        ram_sound_system.stop_music()
        thispiece = false
        gameover = true
      end
    end
  end
  playfield0:clear_completed_rows()
end

function love.draw()
  love.graphics.setColor(255, 255, 255)
  playfield0:draw(5, -3)
  if thispiece then thispiece:draw(5, -3) end
  nextpiece:paint(280, 12)
  love.graphics.setFont(rom_imagefonts[1])
  love.graphics.print('L   R', 274, 16)
  ram_sound_system.draw()
end

function love.joystickpressed(n, b)
  n, b = n + 1, b + 1
  if n == CONTROLLER_NUMBER and (b == RETRO_DEVICE_ID_JOYPAD_B or b == RETRO_DEVICE_ID_JOYPAD_X) and thispiece then thispiece:reverse(playfield0)
  elseif n == CONTROLLER_NUMBER and b == RETRO_DEVICE_ID_JOYPAD_SELECT then
    ram_sound_system.toggle_settings(thispiece)
  elseif n == CONTROLLER_NUMBER and b == RETRO_DEVICE_ID_JOYPAD_START and not thispiece then restart_game()
  elseif n == CONTROLLER_NUMBER and b == RETRO_DEVICE_ID_JOYPAD_DOWN and thispiece then
    if thispiece:move_down(playfield0) then timer = 0 end
  elseif n == CONTROLLER_NUMBER and b == RETRO_DEVICE_ID_JOYPAD_LEFT and thispiece then thispiece:move_left(playfield0)
  elseif n == CONTROLLER_NUMBER and b == RETRO_DEVICE_ID_JOYPAD_RIGHT and thispiece then thispiece:move_right(playfield0)
  elseif n == CONTROLLER_NUMBER and (b == RETRO_DEVICE_ID_JOYPAD_A or b == RETRO_DEVICE_ID_JOYPAD_Y) and thispiece then thispiece:rotate(playfield0)
  elseif n == CONTROLLER_NUMBER and b == RETRO_DEVICE_ID_JOYPAD_L then nextpiece:rotate_queue(#nextpiece.pieces - 1)
  elseif n == CONTROLLER_NUMBER and b == RETRO_DEVICE_ID_JOYPAD_R then nextpiece:rotate_queue(1)
  end
end
