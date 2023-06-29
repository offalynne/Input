if (input_check_pressed("accept"))
{
    b.active(!b.get_active());
    c.active(!c.get_active());
}

test_x += input_check_opposing("left", "right");
test_y += input_check_opposing("up", "down");