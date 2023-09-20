keyup = keyboard_check(vk_up)
keydown = keyboard_check(vk_down)
keyleft = keyboard_check(vk_left)
keyright = keyboard_check(vk_right)
intKey = keyboard_check_pressed(ord("Z"))
jumpkey = keyboard_check_pressed(vk_space)
jumpkeyheld = keyboard_check(vk_space)
sprintkey = keyboard_check_pressed(vk_shift)
sprintkeyheld = keyboard_check(vk_shift)

state();


// everything below applies to all states
// DO NOT FUCKING TOUCH

if y > room_height+sprite_height
{room_restart()}

//giant fucking animation system that sucks ass i hate this
switch anim_state
{
	case 0:
	image_index = 0
	timer = 0
	break
	
	case 1:
	++timer
	if timer < 2 
	{image_index = 1}
	else
	{timer = 2}
	image_speed = 1
	break
	
	case 2:
	++timer
	if timer < 1
	{image_index = 1}
	else
	{timer = 1}
	image_speed = 2
	break
}
switch mDir
{
	case 0:
	image_xscale = 1
	break
	
	case 180:
	image_xscale = -1
	break
}