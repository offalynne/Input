// Feather disable all

/// @param {Real} [playerIndex=0]

function InputMotionCalibrate(_playerIndex = 0)
{
    static _deviceMap = __InputMotionSystem().__deviceMap;
    
    __INPUT_VALIDATE_PLAYER_INDEX
    
    var _deviceStruct = _deviceMap[? InputPlayerGetDevice(_playerIndex)];
    if (_deviceStruct == undefined) return;
    
    _deviceStruct.__Calibrate();
}