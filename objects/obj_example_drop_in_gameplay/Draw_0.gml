var _i = 0;
repeat(INPUT_MAX_PLAYERS)
{
    var _string = "Player " + string(_i+1) + ":\n";
    
    if (input_player_connected(_i))
    {
        if (input_source_using(INPUT_GAMEPAD, 1))
        {
            _string += input_verb_get_icon("left", _i) + "/" + input_verb_get_icon("right", _i) + "/" + input_verb_get_icon("up", _i) + "/" + input_verb_get_icon("down", _i) + " = Move\n";
            _string += input_verb_get_icon("aim_left", _i) + "/" + input_verb_get_icon("aim_right", _i) + "/" + input_verb_get_icon("aim_up", _i) + "/" + input_verb_get_icon("aim_down", _i) + " = Aim\n";
            _string += input_verb_get_icon("shoot", _i, 0) + "/" + input_verb_get_icon("shoot", _i, 1) + " = Shoot\n";
            _string += input_verb_get_icon("pause", _i) + " = Go Back\n";
        }
        else
        {
            _string += input_verb_get_icon("left", _i, 1) + "/" + input_verb_get_icon("right", _i, 1) + "/" + input_verb_get_icon("up", _i, 1) + "/" + input_verb_get_icon("down", _i, 1) + " = Move\n";
            _string += "Mouse = Aim\n";
            _string += input_verb_get_icon("shoot", _i) + " = Shoot\n";
            _string += input_verb_get_icon("pause", _i) + " = Go Back\n";
        }
    }
    else
    {
        _string += "Not connected!\n";
    }
    
    switch(_i)
    {
        case 0:
            draw_set_halign(fa_left);
            draw_set_valign(fa_top);
            draw_text(10, 10, _string);
        break;
        
        case 1:
            draw_set_halign(fa_right);
            draw_set_valign(fa_top);
            draw_text(room_width-10, 10, _string);
        break;
        
        case 2:
            draw_set_halign(fa_left);
            draw_set_valign(fa_bottom);
            draw_text(10, room_height-10, _string);
        break;
        
        case 3:
            draw_set_halign(fa_right);
            draw_set_valign(fa_bottom);
            draw_text(room_width-10, room_height-10, _string);
        break;
    }
    
    ++_i;
}

draw_set_halign(fa_left);
draw_set_valign(fa_top);