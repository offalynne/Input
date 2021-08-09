input_tick();

if (assigning)
{
    if (input_assignment_tick(3, 3, VERB.CANCEL))
    {
        //Source assignment aborted
        assigning = false;
    }
    
    if (input_players_connected() == 3)
    {
        if (input_check_pressed(VERB.CONFIRM, 0) || input_check_pressed(VERB.CONFIRM, 0) || input_check_pressed(VERB.CONFIRM, 0))
        {
            //We had three players connect and one of them pressed Confirm
            assigning = false;
            success   = true;
        }
    }
}