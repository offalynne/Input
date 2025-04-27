// Feather disable all

/// Returns a name for a verb's binding. If a name for a binding cannot be found, this function
/// will return `missingBindingName` (which is `"???"` by default). You can override the gamepad
/// type by setting `forceGamepadType` which is useful if you would like to allow players to set
/// gamepad icons manually.
/// 
/// @param {Bool} forGamepad
/// @param {Enum.PAWPRINT_VERB,Real} verbIndex
/// @param {Real} [alternate=0]
/// @param {Real} [playerIndex=0]
/// @param {Real} [forceGamepadType]
/// @param {Real} [missingBindingName="???"]
/// 
/// If `forGamepad` is set to `true` then one of the following will be returned. This is an
/// exhaustive list and you will probably not need to support every single one of these return
/// values. Please see `__PawprintCreateGamepadBindingNameLookup()` for the specific mappings.
/// 
///   - `"thumbstick l left"`
///   - `"thumbstick l up"`
///   - `"thumbstick l right"`
///   - `"thumbstick l down"`
///   - `"thumbstick l click"`
///   - `"thumbstick r left"`
///   - `"thumbstick r up"`
///   - `"thumbstick r right"`
///   - `"thumbstick r down"`
///   - `"thumbstick r click"`
///   - `"shoulder l"`
///   - `"shoulder r"`
///   - `"trigger l"`
///   - `"trigger r"`
///   - `"dpad up"`
///   - `"dpad down"`
///   - `"dpad left"`
///   - `"dpad right"`
///   - `"face south"`
///   - `"face east"`
///   - `"face west"`
///   - `"face north"`
///   - `"select"`
///   - `"start"`
///   - `"home"`
///   - `"paddle r"`
///   - `"paddle l"`
///   - `"paddle rb"`
///   - `"paddle lb"`
///   - `"paddle r"`
///   - `"paddle l"`
///   - `"paddle rb"`
///   - `"paddle lb"`
///   - `"extra 1"`
///   - `"extra 2"`
///   - `"extra 3"`
///   - `"extra 4"`
///   - `"extra 5"`
///   - `"extra 6"`
///   - `"touchpad"`
/// 
/// If `forGamepad` is set to `false` then one of the following will be returned under the
/// assumption that the player is using an English Latin keyboard:
///   
///   - For numbers and letters, the label for the keyboard key
///   - `"scroll lock"`
///   - `"caps lock"`
///   - `"num lock"`
///   - `"left meta"`
///   - `"right meta"`
///   - `"clear"`
///   - `"menu"`
///   - `"print screen"`
///   - `"pause break"`
///   - `"escape"`
///   - `"backspace"`
///   - `"space"`
///   - `"enter"`
///   - `"arrow up"`
///   - `"arrow down"`
///   - `"arrow left"`
///   - `"arrow right"`
///   - `"tab"`
///   - `"right alt"`
///   - `"left alt"`
///   - `"alt"`
///   - `"right shift"`
///   - `"left shift"`
///   - `"shift"`
///   - `"right ctrl"`
///   - `"left ctrl"`
///   - `"ctrl"`
///   - `"f1"`
///   - `"f2"`
///   - `"f3"`
///   - `"f4"`
///   - `"f5"`
///   - `"f6"`
///   - `"f7"`
///   - `"f8"`
///   - `"f9"`
///   - `"f10"`
///   - `"f11"`
///   - `"f12"`
///   - `"numpad /"`
///   - `"numpad *"`
///   - `"numpad -"`
///   - `"numpad +"`
///   - `"numpad ."`
///   - `"numpad 0"`
///   - `"numpad 1"`
///   - `"numpad 2"`
///   - `"numpad 3"`
///   - `"numpad 4"`
///   - `"numpad 5"`
///   - `"numpad 6"`
///   - `"numpad 7"`
///   - `"numpad 8"`
///   - `"numpad 9"`
///   - `"delete"`
///   - `"insert"`
///   - `"home"`
///   - `"page up"`
///   - `"page down"`
///   - `"end"`

function PawprintVerbGetBindingName(_forGamepad, _verbIndex, _alternate = 0, _playerIndex = 0, _forceGamepadType = undefined, _missingBindingName = "???")
{
    static _playerArray             = __PawprintSystemPlayerArray();
    static _gamepadButtonNameLookup = __PawprintSystem().__gamepadButtonNameLookup;
    static _kbmBindingNameMap       = __PawprintSystem().__kbmBindingNameMap;
    
    with(_playerArray[_playerIndex])
    {
        if (_forGamepad)
        {
            return _gamepadButtonNameLookup[_forceGamepadType ?? __lastConnectedGamepadType][? __gamepadBindingArray[_verbIndex][_alternate]] ?? _missingBindingName;
        }
        else
        {
            var _binding = __kbmBindingArray[_verbIndex][_alternate];
            return _kbmBindingNameMap[? _binding] ?? chr(_binding);
        }
    }
}