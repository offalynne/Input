if (input_check_pressed("pause"))
{
    pause = !pause;
    input_binding_scan_abort();
}

if (pause)
{
    //Only allow the player to navigate the menu if we're not rebinding anything
    if (!input_binding_scan_in_progress())
    {
        //Move the menu selection up and down, example for how to use 'opposing' checkers
        menu_selection += input_check_opposing_pressed("up", "down") + input_check_opposing_repeat("up", "down");
        
        //Make sure we wrap around the menu
        menu_selection = (menu_selection + 5) mod 5;
        
        //Start the rebinding process when the player selects an option
        if (input_check_pressed("accept"))
        {
            switch(menu_selection)
            {
                case 0: rebinding_verb = "left";   break;
                case 1: rebinding_verb = "right";  break;
                case 2: rebinding_verb = "up";     break;
                case 3: rebinding_verb = "down";   break;
                case 4: rebinding_verb = "accept"; break;
            }
            
            //Start binding. We specify some code to execute when a new binding is inputted by the player
            //We use the basic input_binding_set_safe() function here but input_binding_set() can be used too for more complex situations
            input_binding_scan_start(function(_binding)
            {
                input_binding_set_safe(rebinding_verb, _binding);
            });
        }
    }
}