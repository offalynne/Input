// Feather disable all

/// @param {Enum.INPUT_THRESHOLD,Real} thresholdType
/// @param {Real} [playerIndex=0]

function InputPlayerGetMinThreshold(_thresholdType, _playerIndex = 0)
{
    static _playerArray = __InputSystemPlayerArray();
    return _playerArray[_playerIndex].__thresholdMinArray[_thresholdType];
}