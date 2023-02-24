input_tick();

if not (input_check(["left", "right", "up", "down"]))
{
    quick = false;
}
else
{
    var _direction = input_direction(0, "left", "right", "up", "down");
    
    if (input_xy_quick_pressed("left", "right", "up", "down")) quick = true;
    
    var _speed = quick? 5 : 3;
    x += lengthdir_x(_speed, _direction);
    y += lengthdir_y(_speed, _direction);
}
