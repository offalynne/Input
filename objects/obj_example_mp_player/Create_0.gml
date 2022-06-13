x_speed = 0;
y_speed = 0;

aim_direction = 0;

xy_acceleration = 0.9;

xy_damping = 0.90;

shoot_timer = 0;

//Remove the mouse cursor since it'll get in the way whilst aiming
window_set_cursor(cr_none);

//Checky hack to assign a player index
//We use this value to check inputs from the correct device
player = (instance_find(object_index, 0) == id)? 0 : 1;