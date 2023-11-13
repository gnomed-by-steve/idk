mspd = 2
sspd = mspd*2
mDir = 0
mDirDive = 0
initmDirDive = 0
intRange = 64
anim_state = 0
timer = 0

yspd = 0
grounded = 0
jump = -6
jumpMod = 2.5
grav = 0.4
yspdMax = 15

canDive = false

stateFree = function()
{
	
	//door
	var currentDoor = instance_place(x,y,objDoor)
	if intKey && currentDoor
	{
		room_goto(currentDoor.destination)
	}
	
	//movement code
	var xmove = keyright - keyleft
	var ymove = keyup - keydown

	//sets the direction
	if (xmove != 0) //don't update if still
	{
		mDir = point_direction(0, 0, xmove, 0)
		anim_state = 1	
	}
	else anim_state = 0
	
	if xmove != 0 || ymove != 0 //don't update if still
	{mDirDive = point_direction(0, 0, xmove, ymove)} // dive direction

	//clears our current speed
	var xspd = mspd*xmove

	//sprinting
	if sprintkeyheld && xspd != 0
	{anim_state = 2; xspd = sspd*xmove}

	//jumping
	if jumpkey = 1 && grounded = 1 && xspd = 0 && !keyup
	{yspd += jump}
	if yspd < 0 && (!jumpkeyheld)
	{yspd = max(yspd, jump/jumpMod)}
	if grounded = 0
	{xspd = 0; anim_state = 0}

	//gravity
	yspd += grav

	//vertical clamp
	yspd = clamp(yspd, -yspdMax, yspdMax)

	//diving?
	if canDive = 1 && sprintkeyheld && jumpkey && xmove != 0
	{
		initxspd = xspd
		initmDirDive = mDirDive
		yy = y
		shift = 0
		t = 0
		amplitude = 0
		frequency = 0.5
		
		switch initmDirDive {
			case 0:
			
			amplitude = 36
			frequency = 0.75
			initmDirDive += 90
			
			break;
			
			case 180:
			
			amplitude = 36
			frequency = 0.75
			initmDirDive -= 90
			
			break;
			
			case 315:
			
			amplitude = 200
			initmDirDive += 90
			frequency = 0.5
			
			break;
			
			case 225:
			
			amplitude = 200
			initmDirDive -= 90
			frequency = 0.5
			
			break;
			
		}
		
		fallStateInitiator = pi/frequency
		increment = degtorad(6);  //radians //WHAT THE FUCK DOES THIS MEAN //Still don't know what this means
		state = stateDive
	}
	
	//collision code
	var vertColInst = instance_place(x, y+yspd, objGround)
	if vertColInst
	{
		switch vertColInst.layer
		{
			case 1:
		
				while abs(yspd) > 0.1
					{
						yspd *= 0.5
						if !vertColInst y += yspd
					}
					
				grounded = 1
				yspd = 0
		
			break;
		
			case 2:
			
				if vertColInst.y - vertColInst.sprite_height/2 > round(y + sprite_height/2) && !keydown
				{
					
					while abs(yspd) > 0.1
						{
							yspd *= 0.5
							if !vertColInst y += yspd
						}
						
					grounded = 1
					yspd = 0
				
				}
				
				else 
				{grounded = 0}
			
			break;
		
		}
	} else {grounded = 0}
	
	var horizColInst = instance_place(x+xspd, y, objGround)
	if horizColInst
	{
		switch horizColInst.layer
		{
			case 1:
			
				while abs(xspd) > 0.1
					{
						xspd *= 0.5
						if !horizColInst x += xspd
					}
				xspd = 0
			break;
			
			case 2:
			
			break;
		}
	}
	
	if grounded = 1 
	{canDive = 1}
	else
	{canDive = 0}
	
	//movement application
	x += xspd
	y += yspd

}

stateDive = function()
{
	grounded = 0
	canDive = 0
	
	//What the fuck?
	t += increment
	tBefore = t - increment
	tAfter = t + increment
	shift = abs(amplitude * sin(t*frequency));
	shiftBefore = abs(amplitude * sin(tBefore*frequency));
	shiftAfter = abs(amplitude * sin(tAfter*frequency));
	
	xspd = initxspd
	yspd = lengthdir_y(shift, initmDirDive)
	yspdAfter = lengthdir_y(shiftAfter, initmDirDive)
	
	//collision code
	var vertColInst = instance_place(x, yy+yspdAfter, objGround)
	if vertColInst
	{
		switch vertColInst.layer
		{
			case 1:
			
				y = vertColInst.y - vertColInst.sprite_height/2
				grounded = 1
		
			break;
		
			case 2:
			
				if vertColInst.y - vertColInst.sprite_height/2 > round(y + sprite_height/2) && !keydown
				{
					y = vertColInst.y - vertColInst.sprite_height/2
					grounded = 1
				}
			
			break;
		
		}
	}
	var horizColInst = instance_place(x+xspd, y, objGround)
	if horizColInst
	{
		switch horizColInst.layer
		{
			case 1:
			
				while abs(xspd) > 0.1
					{
						xspd *= 0.5
						if !horizColInst x += xspd
					}
				xspd = 0
			break;
			
			case 2:
			
			break;
		}
	}
	
	if grounded == 1
	{state = stateFree}
	if t > fallStateInitiator
	{state = stateFall}
	
	x += xspd
	y = yy + yspd
	
}

stateFall = function()
{
	yspd = round(shift-shiftBefore)
	
	//collision code
	var vertColInst = instance_place(x, y+yspd, objGround)
	if vertColInst
	{
		switch vertColInst.layer
		{
			case 1:
		
				while abs(yspd) > 0.1
					{
						yspd *= 0.5
						if !vertColInst y += yspd
					}
					
				grounded = 1
				yspd = 0
		
			break;
		
			case 2:
			
				if vertColInst.y - vertColInst.sprite_height/2 > round(y + sprite_height/2) && !keydown
				{
					
					while abs(yspd) > 0.1
						{
							yspd *= 0.5
							if !vertColInst y += yspd
						}
						
					grounded = 1
					yspd = 0
				
				}
				
				else 
				{grounded = 0}
			
			break;
		
		}
	} else {grounded = 0}
	
	var horizColInst = instance_place(x+xspd, y, objGround)
	if horizColInst
	{
		switch horizColInst.layer
		{
			case 1:
			
				while abs(xspd) > 0.1
					{
						xspd *= 0.5
						if !horizColInst x += xspd
					}
				xspd = 0
			break;
			
			case 2:
			
			break;
		}
	}
	
	if grounded = 1
	{state = stateFree}
	
	y += yspd
	x += xspd
	
}

state = stateFree