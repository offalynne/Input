/// @desc    Sets parameters when scanning for bindings for a particular player
///          These parameters persist between scans
/// 
/// @param   ignoreArray
/// @param   allowArray
/// @param   [playerIndex=0]

function input_binding_scan_set_params(_ignore_array, _allow_array, _player_index = 0)
{
    __input_initialize();
    __INPUT_VERIFY_PLAYER_INDEX
    
    //Fic minor misuse of allow/ignore arrays
    if (!is_array(_allow_array ) && (_allow_array  != undefined)) _allow_array  = [_allow_array ];
    if (!is_array(_ignore_array) && (_ignore_array != undefined)) _ignore_array = [_ignore_array];
    
    var _ignore_struct = undefined;
    var _allow_struct  = undefined;
    
    if (is_array(_ignore_array)) //Ignore used if there's no allow array
    {
        _ignore_struct = {};
        
        var _i = 0;
        repeat(array_length(_ignore_array))
        {
            var _value = _ignore_array[_i];
            if (is_string(_value) && (_value != "mouse wheel up") && (_value != "mouse wheel down")) _value = ord(_value);
            _ignore_struct[$ string(_value)] = true;
            ++_i;
        }
    }
    
    if (is_array(_allow_array)) //Allow takes precedence
    {
        _allow_struct = {};
        
        var _i = 0;
        repeat(array_length(_allow_array))
        {
            var _value = _allow_array[_i];
            if (is_string(_value) && (_value != "mouse wheel up") && (_value != "mouse wheel down")) _value = ord(_value);
            _allow_struct[$ string(_value)] = true;
            ++_i;
        }
    }
    
    with(global.__input_players[_player_index])
    {
        __rebind_ignore_struct = _ignore_struct;
        __rebind_allow_struct  = _allow_struct;
    }
}