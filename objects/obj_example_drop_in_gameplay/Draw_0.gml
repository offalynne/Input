var _i = 0;
repeat(INPUT_MAX_PLAYERS)
{
    var _string = "Player " + string(_i+1) + ":\n";
    
    if (input_player_connected(_i))
    {
        if (input_source_using(INPUT_GAMEPAD, 1))
        {
            _string += input_binding_get_icon(input_binding_get("left", _i), _i) + "/" + input_binding_get_icon(input_binding_get("right", _i), _i) + "/" + input_binding_get_icon(input_binding_get("up", _i), _i) + "/" + input_binding_get_icon(input_binding_get("down", _i), _i) + " = Move\n";
            _string += input_binding_get_icon(input_binding_get("aim_left", _i), _i) + "/" + input_binding_get_icon(input_binding_get("aim_right", _i), _i) + "/" + input_binding_get_icon(input_binding_get("aim_up", _i), _i) + "/" + input_binding_get_icon(input_binding_get("aim_down", _i), _i) + " = Aim\n";
            _string += input_binding_get_icon(input_binding_get("shoot", _i, 0), _i) + "/" + input_binding_get_icon(input_binding_get("shoot", _i, 1), _i) + " = Shoot\n";
            _string += input_binding_get_icon(input_binding_get("pause", _i), _i) + " = Go Back\n";
        }
        else
        {
            _string += input_binding_get_icon(input_binding_get("left", _i, 1), _i) + "/" + input_binding_get_icon(input_binding_get("right", _i, 1), _i) + "/" + input_binding_get_icon(input_binding_get("up", _i, 1), _i) + "/" + input_binding_get_icon(input_binding_get("down", _i, 1), _i) + " = Move\n";
            _string += "Mouse = Aim\n";
            _string += input_binding_get_icon(input_binding_get("shoot", _i), _i) + " = Shoot\n";
            _string += input_binding_get_icon(input_binding_get("pause", _i), _i) + " = Go Back\n";
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