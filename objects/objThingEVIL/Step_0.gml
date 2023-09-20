//chase the player directly
if instance_exists(objPlayer)
{
eDir = point_direction(x,y,objPlayer.x,objPlayer.y)
var speedInc = (maxSpeed - minSpeed) / intThingCount
spd = minSpeed + (speedInc * (intThingCount - instance_number(objThing)))
xspd = lengthdir_x(spd, eDir)
yspd = lengthdir_y(spd, eDir)
x += xspd
y += yspd
}
if (place_meeting(x,y, objPlayer)) == true
{
--objPlayer.hp
	if objPlayer.hp == 0
	{
	instance_destroy(objPlayer)
	audio_play_sound(sndDie,1,0)
	alarm_set(0,60)
	}
}