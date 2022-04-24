input_tick();
input_source_hotswap_tick();

if (input_check_pressed("up + down")) show_debug_message("up + down");
if (input_check_pressed("konami")) show_debug_message(string(current_time) + "    +30 lives!");
if (input_check_pressed("sweep right->up")) show_debug_message("sweep right->up!");
if (input_check_pressed("power attack right")) show_debug_message("power attack right!");
