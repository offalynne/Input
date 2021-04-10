input_tick();

if (!all_assigned)
{
    input_assignment_tick(3, 3, VERB.CANCEL);
    
    if (input_players_connected() == 3)
    {
        if (input_check_pressed(VERB.CONFIRM, 0)) all_assigned = true;
    }
}