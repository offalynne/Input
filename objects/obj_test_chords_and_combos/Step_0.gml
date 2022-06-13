if (input_check("up + down"))
{
    last_combo = concat(current_time, ": up + down");
}

if (input_check_pressed("konami"))
{
    last_combo = concat(current_time, ": +30 lives");
}

if (input_check_pressed("sweep right->up"))
{
    last_combo = concat(current_time, ": sweep right->up");
}

if (input_check_pressed("power attack right"))
{
    last_combo = concat(current_time, ": power attack right");
}

if (input_check_pressed("fireball"))
{
    last_combo = concat(current_time, ": fireball");
}