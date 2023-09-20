keyup = keyboard_check(vk_up)
keydown = keyboard_check(vk_down)
keyleft = keyboard_check(vk_left)
keyright = keyboard_check(vk_right)
intKey = keyboard_check_pressed(ord("Z"))
debugKey = keyboard_check_pressed(vk_f1)

if debugConfirm = 1 && debugKey = 1 && room = Room1
{
	room_goto(Room2)	
}

if debugKey = 1
{
	debugConfirm = !debugConfirm
}

if intKey = 1
{
	var x2 = x + lengthdir_x(intRange, mDir);
	var y2 = y + lengthdir_y(intRange, mDir);
	with (objThing) //Room1 Parameters, to kill objThings
	{
	    if collision_line(objPlayer.x, objPlayer.y, x2, y2, id, false, false)
		{
			--hp
			if hp = 0
			{
			instance_create_depth(x,y,depth,objKillConfirm)
			audio_play_sound(sndDie,1,false,1,0,random_range(-3,5))
			instance_destroy();
			}
		}
	}
	with (objThingNPC)
	{
	    if collision_line(objPlayer.x, objPlayer.y, x2, y2, id, false, false)
		{
		 initDialogue = 1
		}
	}
}


//movement code
var xmove = keyright - keyleft
var ymove = keydown - keyup

//sets the direction
if (xmove != 0 or ymove != 0) //makes the player not face right when you're doing nothing
{
mDir = point_direction( 0, 0, xmove, ymove)
}
//clears our current speed
var spd = 0

//checks if we're moving -1 or +1, or not at all (0)
var inputlevel = point_distance( 0, 0, xmove, ymove)

//makes our input level not go above 1 in case we're pressing both keys
inputlevel = clamp(inputlevel, 0, 1)

spd = mspd*inputlevel

xspd = lengthdir_x(spd, mDir)
yspd = lengthdir_y(spd, mDir)

image_angle = mDir
x += xspd
y += yspd