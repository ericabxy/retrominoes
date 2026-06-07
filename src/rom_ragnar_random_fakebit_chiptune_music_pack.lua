local bgm_01_super_mushroom_eater = love.audio.newSource('share/ragnar_random_fakebit_chiptune_music_pack_01_super_mushroom_eater.ogg', 'stream')
bgm_01_super_mushroom_eater:setLooping(true)

local rom_ragnar_random_fakebit_chiptune_music_pack = {}

function rom_ragnar_random_fakebit_chiptune_music_pack:bgm1(play)
  if play and not bgm_01_super_mushroom_eater:isPlaying() then love.audio.play(bgm_01_super_mushroom_eater) end
  if not play and bgm_01_super_mushroom_eater:isPlaying() then love.audio.stop(bgm_01_super_mushroom_eater) end
end

return rom_ragnar_random_fakebit_chiptune_music_pack
