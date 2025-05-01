// Feather disable all

/// Sets a binding for a player, overwriting the binding that was already there. If `forGamepad`
/// is specified, the binding will be set for gamepad devices, otherwise the binding will be set
/// for the keyboard and mouse device (`INPUT_KBM`). The alternate index parameter can be used
/// to set multiple parallel bindings for one verb.
/// 
/// N.B. If you would like to specify a thumbstick binding that heads left or up, use the negative
///      value of that binding e.g. `-gp_axislv` is an upwards push on the left thumbstick.
/// 
/// @param {Bool} forGamepad
/// @param {Enum.INPUT_VERB,Real} verbIndex
/// @param {Any} binding
/// @param {Real} [alternate=0]
/// @param {Real} [playerIndex=0]

function InputBindingSet(_forGamepad, _verbIndex, _binding, _alternate = 0, _playerIndex = 0)
{
    static _playerArray = __InputSystemPlayerArray();
    
    __INPUT_VALIDATE_PLAYER_INDEX
    
    with(_playerArray[_playerIndex])
    {
        var _bindingArray = _forGamepad? __gamepadBindingArray : __kbmBindingArray;
        var _alternateArray = _bindingArray[_verbIndex];
        
        //Pad array with `undefined`
        if (_alternate > array_length(_alternateArray))
        {
            var _i = array_length(_alternateArray);
            repeat((_alternate - 1) - array_length(_alternateArray))
            {
                _alternateArray[@ _i] = undefined;
                ++_i;
            }
        }
        
        var _prevBinding = _alternateArray[_alternate];
        _alternateArray[@ _alternate] = _binding;
        
        if (_forGamepad && (_prevBinding != _binding) && (__InputBindingIsThumbstick(_binding) || __InputBindingIsThumbstick(_binding)))
        {
            __UpdateClusterThresholds();
        }
    }
}