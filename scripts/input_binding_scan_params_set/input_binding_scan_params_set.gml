// Feather disable all
/// @desc    Sets parameters when scanning for bindings for a particular player
///          These parameters persist between scans
/// 
/// If a constant appears in both lists, the “ignore” array takes precedence and the binding will be ignored
/// 
/// @param   [ignoreArray]     Array of keyboard keys (vk_*, "A"), mouse buttons (mb_*), or gamepad constants (gp_*) to explicitly disallow being scanned
/// @param   [allowArray]      Array of keyboard keys (vk_*, "A"), mouse buttons (mb_*), or gamepad constants (gp_*) to explicitly scan for, excluding all other possible bindings
/// @param   [sourceFilter]    Array of sources to scan. If not specified, the sources currently assigned to the target player will be scanned
/// @param   [playerIndex=0]   Player to target. If not specified, player 0 is targeted

function input_binding_scan_params_set(_ignore_array = undefined, _allow_array = undefined, _source_filter = undefined, _player_index = 0)
{
    __INPUT_GLOBAL_STATIC_LOCAL  //Set static _global
    __INPUT_VERIFY_PLAYER_INDEX
    
    if (is_numeric(_source_filter))
    {
        __input_error("Usage of input_binding_scan_params_set() has changed. Please refer to documentation for details");
    }
    
    //Fic minor misuse of allow/ignore arrays
    if (!is_array(_allow_array ) && (_allow_array  != undefined)) _allow_array  = [_allow_array ];
    if (!is_array(_ignore_array) && (_ignore_array != undefined)) _ignore_array = [_ignore_array];
    
    var _ignore_struct = undefined;
    var _allow_struct  = undefined;
    
    if (is_array(_ignore_array)) //"Ignore" array used if there's no allow array
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
    
    if (is_array(_allow_array)) //"Allow" array takes precedence
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
    
    with(_global.__players[_player_index])
    {
        if (!is_undefined(_source_filter) && !is_array(_source_filter))
        {
            //If we've been given a basic piece of data, wrap it in an array
            _source_filter = [_source_filter];
        }
        
        __rebind_ignore_struct = _ignore_struct;
        __rebind_allow_struct  = _allow_struct;
        __rebind_source_filter = _source_filter;
    }
}
