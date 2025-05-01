// Feather disable all

/// Must be called from within a INPUT_PLUG_IN_CALLBACK.UPDATE_PLAYER callback.
/// 
/// @param verbIndex
/// @param [prevHeld]
/// @param [valueRaw]
/// @param [valueClamp]
/// @param [pressFrame]
/// @param [playerIndex=0]

function InputPlugInVerbStateSet(_verbIndex, _prevHeld = undefined, _valueRaw = undefined, _valueClamp = undefined, _pressFrame = undefined, _playerIndex = 0)
{
    static _system = __InputSystem();
    static _playerArray = __InputSystemPlayerArray();
    
    __INPUT_VALIDATE_PLAYER_INDEX
    
    if (_system.__plugInCurrentCallback != INPUT_PLUG_IN_CALLBACK.UPDATE_PLAYER)
    {
        __InputError("Cannot call InputPlugInVerbStateSet() outside of a INPUT_PLUG_IN_CALLBACK.UPDATE_PLAYER callback");
    }
    
    with(_playerArray[_playerIndex].__verbStateArray[_verbIndex])
    {
        if (_prevHeld != undefined) __prevHeld = _prevHeld;
        if (_valueRaw != undefined) __valueRaw = _valueRaw;
        
        if (_valueClamp != undefined)
        {
            __valueClamp = _valueClamp;
            __held = (_valueClamp > 0);
        }
        
        if (_pressFrame != undefined) __pressFrame = _pressFrame;
    }
}