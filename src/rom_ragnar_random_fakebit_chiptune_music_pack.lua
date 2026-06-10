local rom_ragnar_random_fakebit_chiptune_music_pack = {
  love.audio.newSource('share/ragnar_random_fakebit_chiptune_music_pack_01_super_mushroom_eater.ogg', 'stream'),
  love.audio.newSource('share/ragnar_random_fakebit_chiptine_music_pack_06_-_fire_breathing_turtle_boss.ogg', 'stream')
}

rom_ragnar_random_fakebit_chiptune_music_pack[1]:setLooping(true)
rom_ragnar_random_fakebit_chiptune_music_pack[2]:setLooping(true)

return rom_ragnar_random_fakebit_chiptune_music_pack
