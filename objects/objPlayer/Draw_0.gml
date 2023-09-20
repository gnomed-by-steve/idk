draw_self()
if intKey = 1
{
	var x2 = x + lengthdir_x(intRange, mDir);
	var y2 = y + lengthdir_y(intRange, mDir);
	draw_line_color(x, y, x2, y2, c_red, c_yellow)
}
if !instance_exists(objThing) && room = Room1
{
	draw_text(700, 350, "GET TO THE PORTAL")
}
draw_text(12,32,debugConfirm)
if debugConfirm = 1 && room = Room1
{
	draw_text(600, 300, "This will skip Room1.\nFor weenie babies who are bad at this.")
}