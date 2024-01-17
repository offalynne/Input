//Feather disable all

if (input_check_pressed("accept"))
{
    b.active(!b.get_active());
    c.active(!c.get_active());
}

if (a.pressed())
{
    i.momentary(!i.get_momentary());
}

//test_x += 6*input_check_opposing("left", "right");
//test_y += 6*input_check_opposing("up", "down");

test_x += 6*input_x("left", "right", "up", "down");
test_y += 6*input_y("left", "right", "up", "down");