// Feather disable all

/// Returns the connection status of the player. This will be a member of INPUT_PLAYER_STATUS:
/// - INPUT_PLAYER_STATUS.DISCONNECTED
/// - INPUT_PLAYER_STATUS.NEWLY_DISCONNECTED
/// - INPUT_PLAYER_STATUS.NEWLY_CONNECTED
/// - INPUT_PLAYER_STATUS.CONNECTED
/// 
/// @param playerIndex

function InputPlayerGetStatus(_playerIndex)
{
    static _playerArray = __InputSystemPlayerArray();
    return _playerArray[_playerIndex].__status;
}