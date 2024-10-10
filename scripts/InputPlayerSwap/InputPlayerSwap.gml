// Feather disable all

/// Swaps player indexes over including: bindings, device, verb state, and metadata.
/// 
/// @param {Real} playerIndexA
/// @param {Real} playerIndexB

function InputPlayerSwap(_playerIndexA, _playerIndexB)
{
    static _playerArray = __InputSystemPlayerArray();
    
    //Do the ol' swaperoo
    var _originalA = _playerArray[_playerIndexA];
    var _originalB = _playerArray[_playerIndexB];
    
    _originalA.__playerIndex = _playerIndexB;
    _originalB.__playerIndex = _playerIndexA;
    
    _playerArray[@ _playerIndexA] = _originalB;
    _playerArray[@ _playerIndexB] = _originalA;
}
