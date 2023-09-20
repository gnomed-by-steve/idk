var player = instance_find(objPlayer, 0); // Find the player instance

if (player != noone) {
	xTo = player.x
	yTo = player.y
}

x += (xTo - x)/25
y += (yTo - y)/25

camera_set_view_pos(
	view_camera[0],
	floor(x-(camWidth*0.5)),
	floor(y-(camHeight*0.5)),
	)