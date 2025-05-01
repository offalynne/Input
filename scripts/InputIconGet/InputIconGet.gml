// Feather disable all

/// Returns the icon data for the binding, as set by one of the `InputIconDefine*()` functions.
/// The icon data that is returned will correlate with the player's current device and gamepad
/// type.
/// 
/// @param {Enum.INPUT_VERB,Real} verbIndex
/// @param {Real} [alternate=0]
/// @param {Real} [playerIndex=0]

function InputIconGet(_verbIndex, _alternate = 0, _playerIndex = 0)
{
    __INPUT_VALIDATE_PLAYER_INDEX
    
    var _forGamepad = InputPlayerUsingGamepad(_playerIndex);
    return InputIconGetDirect(InputBindingGet(_forGamepad, _verbIndex, _alternate, _playerIndex),
                                 _forGamepad,
                                 InputPlayerGetLastConnectedGamepadType(_playerIndex));
}