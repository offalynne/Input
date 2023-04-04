//Set some rules for the aiming cursor
if (input_source_using(INPUT_GAMEPAD))
{
    //If we're using a gamepad, limit the cursor to 130px away from the player
    input_cursor_limit_circle(x, y, 130);
    
    //We also set an "elastic" rule so that the cursor automatically springs back towards the player
    //Since we've moved the elastic centre we also want to move the cursor itself by the same amount to keep the cursor in sync
    input_cursor_elastic_set(x, y, 0.2, undefined, true);
}
else
{
    //If we're not using the gamepad then remove both the limit and the elastic
    //This allows the cursor to move totally freely as you'd expect with mouse aiming
    input_cursor_elastic_remove();
    input_cursor_limit_remove();
}

//Move the point of aim if the cursor is far enough away from the player
//We perform this distance check so that we don't get twitching when using a gamepad
if (point_distance(x, y, input_cursor_x(), input_cursor_y()) > 10)
{
    aim_direction = point_direction(x, y, input_cursor_x(), input_cursor_y());
}

//Handle shooting
if (shoot_timer > 0)
{
    --shoot_timer;
}
else if (input_check("shoot"))
{
    shoot_timer = 10; //shoot_timer controls the rate of fire
    
    //The speed of the bullet is set in the Create event for obj_example_bullet
    with(instance_create_layer(x, y, "Bullets", obj_example_bullet))
    {
        creator   = other.id;
        direction = other.aim_direction;
    }
}

//Move around using the 2D checkers
//These automatically handle analogue input (thumbsticks) as well as on/off input (keyboard/dpad)
x_speed += xy_acceleration*input_x("left", "right", "up", "down");
y_speed += xy_acceleration*input_y("left", "right", "up", "down");

//Apply a resistive force to our speed
//I prefer damping over basic friction because it adds a bit of extra weight to the player
x_speed *= xy_damping;
y_speed *= xy_damping;

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

//Clamp the player to the room boundaries
x = clamp(x, sprite_width/2 , room_width  - sprite_width/2 );
y = clamp(y, sprite_height/2, room_height - sprite_height/2);