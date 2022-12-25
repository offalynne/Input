/// @desc    Returns the vector represented by the sum of the verb values
/// @param   leftVerb
/// @param   rightVerb
/// @param   upVerb
/// @param   downVerb
/// @param   [playerIndex=0]
/// @param   [mostRecent=false]

function input_xy(_verb_l, _verb_r, _verb_u, _verb_d, _player_index = 0, _most_recent = false)
{
    if (INPUT_2D_CHECKER_STATIC_RESULT)
    {
        static _result = {
            x: 0,
            y: 0,
        };
    }
    else
    {
        var _result = {
            x: 0,
            y: 0,
        };
    }
    
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
    
    //If any of the verbs have been consumed then set their value to 0, otherwise use the raw value from the binding
    var _value_l = _verb_struct_l.__inactive? 0.0 : _verb_struct_l.raw;
    var _value_r = _verb_struct_r.__inactive? 0.0 : _verb_struct_r.raw;
    var _value_u = _verb_struct_u.__inactive? 0.0 : _verb_struct_u.raw;
    var _value_d = _verb_struct_d.__inactive? 0.0 : _verb_struct_d.raw;
    
    //Check to see if any the verbs are non-analogue (and are being pressed)
    var _any_non_analogue = false;
    
    if (((_value_l > 0.0) && !_verb_struct_l.raw_analogue)
    ||  ((_value_r > 0.0) && !_verb_struct_r.raw_analogue)
    ||  ((_value_u > 0.0) && !_verb_struct_u.raw_analogue)
    ||  ((_value_d > 0.0) && !_verb_struct_d.raw_analogue))
    {
        _any_non_analogue = true;
        
        //If we *do* have some non-analogue buttons pressed, then find all the analogue values and set them to zero
        //This means that if the player presses on the dpad whilst also using an analogue stick we ignore the thumbstick and use the dpad input instead
        if (_verb_struct_u.raw_analogue) _value_u = 0.0;
        if (_verb_struct_d.raw_analogue) _value_d = 0.0;
        if (_verb_struct_l.raw_analogue) _value_l = 0.0;
        if (_verb_struct_r.raw_analogue) _value_r = 0.0;
    }
    
    //Calculate the actual raw x/y values
    var _dx = _value_r - _value_l;
    var _dy = _value_d - _value_u;
    
    if (_most_recent)
    {
        if ((_value_l > 0.0) && (_value_r > 0.0)) { _dx = ((_verb_struct_l.press_time > _verb_struct_r.press_time)? -_value_l : _value_r); }
        if ((_value_u > 0.0) && (_value_d > 0.0)) { _dy = ((_verb_struct_u.press_time > _verb_struct_d.press_time)? -_value_u : _value_d); }
    }
    
    //Calculate the displacement
    var _d = sqrt(_dx*_dx + _dy*_dy);
    
    //If the displacement is exactly zero then skip then early-out
    if (_d <= 0.0)
    {
        _result.x = 0;
        _result.y = 0;
        return _result;
    }
    
    //Scale down the x/y values if we want to clamp output values between 0.0 and 1.0
    if (INPUT_2D_CLAMP || !_any_non_analogue)
    {
        _dx /= max(1, _d);
        _dy /= max(1, _d);
        _d = min(1, _d);
    }
    
    if (_any_non_analogue)
    {
        //No need to do a lot of maths if we have non-analogue input, just output the answer
        _result.x = _dx;
        _result.y = _dy;
        return _result;
    }
    
    //Approximate average of axis thresholds across all active verbs
    var _active_count  = 0;
    var _min_threshold = 0.0;
    var _max_threshold = 0.0;
    
    if (_value_l > 0.0) { _active_count++;   _min_threshold += _verb_struct_l.min_threshold;   _max_threshold += _verb_struct_l.max_threshold; }
    if (_value_r > 0.0) { _active_count++;   _min_threshold += _verb_struct_r.min_threshold;   _max_threshold += _verb_struct_r.max_threshold; }
    if (_value_u > 0.0) { _active_count++;   _min_threshold += _verb_struct_u.min_threshold;   _max_threshold += _verb_struct_u.max_threshold; }
    if (_value_d > 0.0) { _active_count++;   _min_threshold += _verb_struct_d.min_threshold;   _max_threshold += _verb_struct_d.max_threshold; }
    
    //Catch an edge case
    if (_active_count <= 0.0)
    {
        _result.x = 0;
        _result.y = 0;
        return _result;
    }
    
    _min_threshold /= _active_count;
    _max_threshold /= _active_count;
    
    //Apply the min/max thresholds for fully analogue input
    var _coeff = clamp((_d - _min_threshold) / (_max_threshold - _min_threshold), 0.0, 1.0);
    _dx *= _coeff;
    _dy *= _coeff;
    
    if (INPUT_2D_XY_AXIS_BIAS > 0)
    {
        var _divisor = INPUT_2D_XY_AXIS_BIAS_DIAGONALS? 45 : 90;
        
        var _direction = point_direction(0, 0, _dx, _dy);
        var _dir_mod = (_direction mod _divisor) / _divisor;
        _dir_mod = clamp((_dir_mod - 0.5*0.999*INPUT_2D_XY_AXIS_BIAS) / (1 - 0.999*INPUT_2D_XY_AXIS_BIAS), 0, 1);
        _dir_mod = _dir_mod*_dir_mod*(3 - 2*_dir_mod); //Smooth step babyyyy
        _direction = _divisor*((_direction div _divisor) + _dir_mod);
        
        var _distance = point_distance(0, 0, _dx, _dy);
        _dx = lengthdir_x(_distance, _direction);
        _dy = lengthdir_y(_distance, _direction);
        
        /*
        //Implementation from https://github.com/Minimuino/thumbstick-deadzones/blob/master/README.md
        //It is not consistent in magnitude around the circle making it unsuitable for our use case
        
        var _abs_dx = abs(_dx);
        var _abs_dy = abs(_dy);
        
        var _dead_x = _min_threshold*abs(_abs_dy); //Base our deadzone on where the opposite axis is
        var _dead_y = _min_threshold*abs(_abs_dx);
        
        _dx = sign(_dx) * max(0, (_abs_dx - _dead_x) / (1 -  _dead_x));
        _dy = sign(_dy) * max(0, (_abs_dy - _dead_y) / (1 -  _dead_y));
        */
    }
    
    //Spit out the answer!
    _result.x = _dx;
    _result.y = _dy;
    return _result;
}