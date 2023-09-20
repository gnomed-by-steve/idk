if (global.currentSong != global.queuedSong)
{
    if (global.currentSong != noone)
	{
		audio_stop_sound(global.currentSong)
	}
	
    audio_play_sound(global.queuedSong, 1, true)
    
    global.currentSong = global.queuedSong
}