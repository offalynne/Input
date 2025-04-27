// Feather disable all

/// @param {Enum.INPUT_THRESHOLD,Real} thresholdType
/// @param {Real} [playerIndex=0]

function InputPlayerGetMaxThreshold(_thresholdType, _playerIndex = 0)
{
    static _playerArray = __InputSystemPlayerArray();
    return _playerArray[_playerIndex].__thresholdMaxArray[_thresholdType];
}