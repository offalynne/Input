/// @desc    Returns whther the analogue inputs registered a quick tap this frame
///          Only analogue inputs can trigger quick taps. This function will return <false> if any digital input is used
/// 
/// @param   leftVerb
/// @param   rightVerb
/// @param   upVerb
/// @param   downVerb
/// @param   [playerIndex=0]

function input_xy_quick_pressed(_verb_l, _verb_r, _verb_u, _verb_d, _player_index = 0)
{
    if (!is_struct(_player_index))
    {
        __INPUT_VERIFY_PLAYER_INDEX
        
        //Grab the player's verbs
        var _player_verbs_struct = global.__input_players[_player_index].__verb_state_dict;
    }
    else
    {
        //Secret feature that's used internally!
        //If you provide a player struct instead of an integer index then we pull the verbs struct from that instead
        var _player_verbs_struct = _player_index.__verb_state_dict;
    }
    
    //And pull out verb structs for each verb name passed into the function
    var _verb_struct_l = _player_verbs_struct[$ _verb_l];
    var _verb_struct_r = _player_verbs_struct[$ _verb_r];
    var _verb_struct_u = _player_verbs_struct[$ _verb_u];
    var _verb_struct_d = _player_verbs_struct[$ _verb_d];
    
    //Check to see if we've been given bad verb names
    if (!is_struct(_verb_struct_l)) __input_error("Left verb not recognised (", _verb_l, ")");
    if (!is_struct(_verb_struct_r)) __input_error("Right verb not recognised (", _verb_r, ")");
    if (!is_struct(_verb_struct_u)) __input_error("Up verb not recognised (", _verb_u, ")");
    if (!is_struct(_verb_struct_d)) __input_error("Down verb not recognised (", _verb_d, ")");
    
    //If any of the verbs have been consumed then we cannot perform a quick tap
    if (_verb_struct_l.__inactive || _verb_struct_r.__inactive || _verb_struct_u.__inactive || _verb_struct_d.__inactive) return false;
    
    var _value_l = _verb_struct_l.raw;
    var _value_r = _verb_struct_r.raw;
    var _value_u = _verb_struct_u.raw;
    var _value_d = _verb_struct_d.raw;
    
    //Check to see if any the verbs are non-analogue (and are being pressed). If so, we cannot perform a quick tap
    if (((_value_l > 0.0) && !_verb_struct_l.raw_analogue)
    ||  ((_value_r > 0.0) && !_verb_struct_r.raw_analogue)
    ||  ((_value_u > 0.0) && !_verb_struct_u.raw_analogue)
    ||  ((_value_d > 0.0) && !_verb_struct_d.raw_analogue))
    {
        return false;
    }
    
    //Approximate average of axis thresholds across all active verbs
    var _active_count  = 0;
    var _min_threshold = 0.0;
    var _max_threshold = 0.0;
    
    if (_value_l > 0.0) { _active_count++;   _min_threshold += _verb_struct_l.min_threshold;   _max_threshold += _verb_struct_l.max_threshold; }
    if (_value_r > 0.0) { _active_count++;   _min_threshold += _verb_struct_r.min_threshold;   _max_threshold += _verb_struct_r.max_threshold; }
    if (_value_u > 0.0) { _active_count++;   _min_threshold += _verb_struct_u.min_threshold;   _max_threshold += _verb_struct_u.max_threshold; }
    if (_value_d > 0.0) { _active_count++;   _min_threshold += _verb_struct_d.min_threshold;   _max_threshold += _verb_struct_d.max_threshold; }
    
    _min_threshold /= _active_count;
    _max_threshold /= _active_count;
    
    //Calculate the actual raw x/y values
    var _dx = _value_r - _value_l;
    var _dy = _value_d - _value_u;
    
    //Calculate the displacement
    var _d = sqrt(_dx*_dx + _dy*_dy);
    
    //Can only be a quick tap if we're at the maximum threshold
    if (_d < _max_threshold) return false;
    
    //Normalise the vector so we can it for a dot product later on
    _dx /= _d;
    _dy /= _d;
    
    //Grab all of our history structs so we can figure out the movement of the thumbstick over the last few frames
    var _history_l = _verb_struct_l.__raw_history_array;
    var _history_r = _verb_struct_r.__raw_history_array;
    var _history_u = _verb_struct_u.__raw_history_array;
    var _history_d = _verb_struct_d.__raw_history_array;
    
    //Can only be a quick tap if we were below the max threshold last frame
    var _hx = _history_r[1] - _history_l[1];
    var _hy = _history_d[1] - _history_u[1];
    if (sqrt(_hx*_hx + _hy*_hy) >= _max_threshold) return false;
    
    var _i = 1;
    repeat(INPUT_QUICK_BUFFER)
    {
        var _hx = _history_r[_i] - _history_l[_i];
        var _hy = _history_d[_i] - _history_u[_i];
        
        if ((sqrt(_hx*_hx + _hy*_hy) < _min_threshold) //This historic point was within the deadzone
        ||  (dot_product(_dx, _dy, _hx, _hy) < -_min_threshold)) //Catches edge cases where the thumbstick travels across the deadzone in a single frame
        {
            //We have been below the minimum threshold
            return true;
        }
        
        ++_i;
    }
    
    return false;
}