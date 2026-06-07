local sound_neutral6 = love.audio.newSource('share/sfx_sound_neutral6.wav', 'static')
local sound_neutral8 = love.audio.newSource('share/sfx_sound_neutral8.wav', 'static')
local sound_neutral11 = love.audio.newSource('share/sfx_sound_neutral11.wav', 'static')

local rom_sound_effects_8_bit_style = {}

function rom_sound_effects_8_bit_style:piece_rotate()
  if not sound_neutral8:isPlaying() then love.audio.play(sound_neutral8) end
end

function rom_sound_effects_8_bit_style:piece_drop()
  if not sound_neutral6:isPlaying() then love.audio.play(sound_neutral6) end
end

function rom_sound_effects_8_bit_style:line_clear()
  if not sound_neutral11:isPlaying() then love.audio.play(sound_neutral11) end
end

return rom_sound_effects_8_bit_style
