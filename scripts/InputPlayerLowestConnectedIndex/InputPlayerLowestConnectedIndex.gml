// Feather disable all

/// Returns the index of the first (lowest index) player with a connected device. If no players
/// have a connected device then this function returns `undefined`. This is useful to easily
/// identify a "main" player in a game with multiple local players.

function InputPlayerLowestConnectedIndex()
{
    static _system = __InputSystem();
    
    return _system.__lowestConnectedPlayerIndex;
}