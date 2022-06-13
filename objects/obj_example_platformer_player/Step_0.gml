//Figure out which direction to move, left or right
//input_check_opposing() returns -1, 0, or +1, making it perfect for controlling horizontal movement
//This function is *not* sensitive to analogue input, we'd need to use input_x() for that
var _direction = input_check_opposing("left", "right");
x_speed += x_acceleration*_direction;

//If the player has actively pressed a direction the store that direction
//This ensure that x_last_direction always contains
if (_direction != 0) x_last_direction = _direction;

//Do a little dash when the player press the "action" verb
//This is bound to the enter key, or the west face button on a gamepad (X for Xbox, square for PlayStation, Y for Switch)
if (input_check_pressed("action"))
{
    x_speed += x_dash_impulse*x_last_direction;
}

//Jump when the player presses the "special" verb
//This is bound to the space key, or the south face button on a gamepad (A for Xbox, cross for PlayStation, B for Switch)
//We also only want to jump when we're standing on the ground, but we check a little bit further below the player for the sake of gamefeel
if (input_check_pressed("accept") && instance_place(x, y + 3, obj_example_solid))
{
    y_speed += y_jump_impulse;
}

//Accelerate downwards because, yknow, this is a platformer
y_speed += y_gravity;

//Apply a resistive force to our speed
//I prefer damping over basic friction because it adds a bit of extra weight to the player
x_speed *= x_damping;
y_speed *= y_damping;

//Move in the x-axis using the old school granny step method
var _dx = sign(x_speed);
repeat(abs(x_speed))
{
    if (!place_meeting(x + _dx, y, obj_example_solid))
    {
        x += _dx;
    }
    else
    {
        x_speed = 0;
        break;
    }
}

//Move in the y-axis using the old school granny step method
var _dy = sign(y_speed);
repeat(abs(y_speed))
{
    if (!place_meeting(x, y + _dy, obj_example_solid))
    {
        y += _dy;
    }
    else
    {
        y_speed = 0;
        break;
    }
}

//Wrap around the room in case the player falls off of the level
if (x < 0) x += room_width;
if (x > room_width) x -= room_width;
if (y < 0) y += room_height;
if (y > room_height) y -= room_height;