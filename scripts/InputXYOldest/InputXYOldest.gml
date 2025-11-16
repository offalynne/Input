// Feather disable all

/// Returns along which axis, and what direction on that axis, the oldest held direction is
/// pointing in. This is helpful for games where the player will typically instead to move along
/// grid lines and off-axis movement is erroneous.
/// 
/// For example, if the player holds `left` and then subsequently presses and holds `up` then this
/// function will return `{ x: -1, y: 0}`. If the player releases `left` and keeps `up` held then
/// this function will return `{ x: 0, y: -1 }`. If the player relases `up` (so no verbs are held
/// then the function will return `{ x: 0, y: 0 }`.
/// 
/// This function returns a struct that contains two member variables `x` and `y`. These values
/// will always be either `0` `+1` or `-1` and only one axis cam be non-zero. This means this
/// function will never return diagonal directions. This function is instead for use with keyboard
/// or dpad input, or situations where a thumbstick should behave like a dpad.
/// 
/// Set the `preferX` parameter to `true` if the x-axis should be preferred if two verbs are
/// pressed on exactly the same frame. Set to `false` if the y-axis should be preferred.
/// 
/// @param {Enum.INPUT_CLUSTER,Real} clusterIndex
/// @param {Bool} preferX
/// @param {Real} [playerIndex=0]

function InputXYOldest(_clusterIndex, _preferX, _playerIndex = 0)
{
    static _playerArray = __InputSystemPlayerArray();
    static _clusterDefinitionArray = __InputSystem().__clusterDefinitionArray;
    
    static _result = {};
    
    __INPUT_VALIDATE_PLAYER_INDEX
    
    _result.x = 0;
    _result.y = 0;
    
    with(_playerArray[_playerIndex])
    {
        __INPUT_VALIDATE_CLUSTER_INDEX
        
        var _clusterDefinition = _clusterDefinitionArray[_clusterIndex];
        if (is_struct(_clusterDefinition))
        {
            //Pull raw verb values so we can apply thresholds in 2D
            var _verbStateArray = __verbStateArray;
            var _stateU = _verbStateArray[_clusterDefinition.__verbUp   ];
            var _stateR = _verbStateArray[_clusterDefinition.__verbRight];
            var _stateD = _verbStateArray[_clusterDefinition.__verbDown ];
            var _stateL = _verbStateArray[_clusterDefinition.__verbLeft ];
            
            var _pressU = _stateU.__held? _stateU.__pressFrame : infinity;
            var _pressR = _stateR.__held? _stateR.__pressFrame : infinity;
            var _pressD = _stateD.__held? _stateD.__pressFrame : infinity;
            var _pressL = _stateL.__held? _stateL.__pressFrame : infinity;
            
            var _pressMin = min(_pressU, _pressR, _pressD, _pressL);
            if (not is_infinity(_pressMin))
            {
                var _recentU = (_pressMin == _pressU);
                var _recentR = (_pressMin == _pressR);
                var _recentD = (_pressMin == _pressD);
                var _recentL = (_pressMin == _pressL);
                
                if (_preferX)
                {
                    if (_recentL)
                    {
                        if (not _recentR) _result.x = -1;
                    }
                    else if (_recentR)
                    {
                        if (not _recentL) _result.x = 1;
                    }
                    else if (_recentU)
                    {
                        if (not _recentD) _result.y = -1;
                    }
                    else if (_recentD)
                    {
                        if (not _recentU) _result.y = 1;
                    }
                }
                else
                {
                    if (_recentU)
                    {
                        if (not _recentD) _result.y = -1;
                    }
                    else if (_recentD)
                    {
                        if (not _recentU) _result.y = 1;
                    }
                    else if (_recentL)
                    {
                        if (not _recentR) _result.x = -1;
                    }
                    else if (_recentR)
                    {
                        if (not _recentL) _result.x = 1;
                    }
                }
            }
        }
    }
    
    return _result;
}