if state = 0 && instance_number(objThing) = 0
{
	state = 1
	sprite_index = sprPortalActive
}

if state = 1 && place_meeting(x,y,objPlayer)
{room_goto(destination)}