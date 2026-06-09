local rom_imagefonts = require('src.rom_imagefonts')
local rom_sound_effects = require('src.rom_sound_effects_8_bit_style')
local rom_ragnar_random_fakebit_chiptune_music_pack = require('src.rom_ragnar_random_fakebit_chiptune_music_pack')

local CHARMAP = [[
0BBB0
D000C
D000C
0EEE0
]]
local bgm_enabled_string = 'MUSIC ON'
local sfx_enabled_string = 'SOUND ON'
local bgm_enabled = true
local sfx_enabled = true

local ram_sound_system = { x = -16, y = 192 }

function ram_sound_system.enable_music(b, is_playing)
  bgm_enabled = b and true or false
  bgm_enabled_string = bgm_enabled and 'MUSIC ON' or 'MUSIC NO'
  if b and is_playing and not rom_ragnar_random_fakebit_chiptune_music_pack[1]:isPlaying() then
    love.audio.play(rom_ragnar_random_fakebit_chiptune_music_pack[1])
  end
  if not b and rom_ragnar_random_fakebit_chiptune_music_pack[1]:isPlaying() then
    love.audio.stop(rom_ragnar_random_fakebit_chiptune_music_pack[1])
  end
end

function ram_sound_system.enable_sound(b)
  sfx_enabled = b and true or false
  sfx_enabled_string = sfx_enabled and 'SOUND ON' or 'SOUND NO'
end

function ram_sound_system.start_music(b)
  if bgm_enabled and not rom_ragnar_random_fakebit_chiptune_music_pack[1]:isPlaying() then
    love.audio.play(rom_ragnar_random_fakebit_chiptune_music_pack[1])
  end
end

function ram_sound_system.stop_music(b)
  if rom_ragnar_random_fakebit_chiptune_music_pack[1]:isPlaying() then
    love.audio.stop(rom_ragnar_random_fakebit_chiptune_music_pack[1])
  end
end

function ram_sound_system.line_clear()
  if sfx_enabled and not rom_sound_effects.sound_neutral11:isPlaying() then love.audio.play(rom_sound_effects.sound_neutral11) end
end

function ram_sound_system.sfx_rotate()
  if sfx_enabled and not rom_sound_effects.sound_neutral8:isPlaying() then love.audio.play(rom_sound_effects.sound_neutral8) end
end

function ram_sound_system.piece_drop()
  if sfx_enabled and not rom_sound_effects.sound_neutral6:isPlaying() then love.audio.play(rom_sound_effects.sound_neutral6) end
end

function ram_sound_system.toggle_settings(is_playing)
  if bgm_enabled and sfx_enabled then ram_sound_system.enable_music(false, is_playing)
  elseif not bgm_enabled and sfx_enabled then ram_sound_system.enable_sound(false)
  elseif not bgm_enabled and not sfx_enabled then ram_sound_system.enable_music(true, is_playing)
  elseif bgm_enabled and not sfx_enabled then ram_sound_system.enable_sound(true)
  end
end

function ram_sound_system.draw()
--  love.graphics.setFont(rom_imagefonts[2])
--  love.graphics.printf(CHARMAP, ram_sound_system.x, ram_sound_system.y, 80 - 1, 'left')
  love.graphics.setFont(rom_imagefonts[1])
  love.graphics.print(bgm_enabled_string, ram_sound_system.x + 16, ram_sound_system.y + 24)
  love.graphics.print(sfx_enabled_string, ram_sound_system.x + 16, ram_sound_system.y + 33)
end

return ram_sound_system
