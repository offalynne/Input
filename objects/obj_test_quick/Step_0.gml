input_tick();

var _direction = input_direction("left", "right", "up", "down");
if (_direction == undefined)
{
    quick = false;
}
else
{
    if (input_xy_quick_pressed("left", "right", "up", "down")) quick = true;
    
    var _speed = quick? 5 : 3;
    x += lengthdir_x(_speed, _direction);
    y += lengthdir_y(_speed, _direction);
}
