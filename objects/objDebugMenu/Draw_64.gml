var player = instance_find(objPlayer, 0); // Find the player instance

if (player != noone) {
draw_text(x-340,y-80,player.mDir)
draw_text(x-340,y-64,player.yspd)
draw_text(x-340,y-48,player.grounded)
draw_text(x-340,y-32,player.image_index)
draw_text(x-340,y-16,player.layer)
draw_text(x-340,y,player.initmDirDive)
draw_text(x-340,y+16,player.mDirDive)
draw_text(x-340,y+32,player.canDive)

if player.state = player.stateDive 
{
draw_text(x-300,y-80,player.shift)
	if player.shift != 0
{draw_text(x-300,y-60,player.shiftBefore)}
}
}