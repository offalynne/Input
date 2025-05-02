// Feather disable all

/// @param {Real} [playerIndex=0]

function InputMotionSupported(_playerIndex = 0)
{
    __INPUT_VALIDATE_PLAYER_INDEX
    
    var _motionStruct = InputMotionGetDirect(InputPlayerGetDevice(_playerIndex));
    return (_motionStruct != undefined)? _motionStruct.__hasData : false;
}