//Both move around if the rebinding handler is paused
if (!obj_example_rebinding.pause)
{
    //Move around using the 2D checkers
    //These automatically handle analogue input (thumbsticks) as well as on/off input (keyboard/dpad)
    x_speed += xy_acceleration*input_x("left", "right", "up", "down");
    y_speed += xy_acceleration*input_y("left", "right", "up", "down");
}

//Apply a resistive force to our speed
//I prefer damping over basic friction because it adds a bit of extra weight to the player
x_speed *= xy_damping;
y_speed *= xy_damping;

//Actually move the player
x += x_speed;
y += y_speed;

//Clamp the player to the room boundaries
x = clamp(x, sprite_width/2 , room_width  - sprite_width/2 );
y = clamp(y, sprite_height/2, room_height - sprite_height/2);