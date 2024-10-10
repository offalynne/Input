// Feather disable all

/// Sets parameters for the party joining system.
/// 
/// The `joinVerb` parameter indicates which verb should be activated by a player in to join the
/// party. This will be respected no matter what device that player is using e.g. if the join
/// verb is mapped to `gp_face1` on gamepad and `vk_space` on keyboard then pressing those buttons
/// will cause the player to join the party.
/// 
/// The `minPlayers` and `maxPlayers` parameters control how many players should be in the party
/// for the party to be considered "ready" (as returned by InputPartyGetReady()).
/// 
/// The `fillEmptyPlayers` parameters will cause players to drop down to lower numbered player
/// slots if they are available.
/// 
/// If the `abortCallback` parameter is set to a valid function then the abort feature will be
/// enabled, which works as follows: If there are zero players in a party and the leave verb is
/// activated on a device then that device is assigned to player 0 (the user of that device becomes
/// player 0) and the abort callback is executed. If the `hotswapOnAbort` parameter is set to
/// `true` then hotswapping will be turned on when aborting.
/// 
/// If `leaveVerb` is set to `undefined` then players will not have a way to leave the party. This
/// is useful if you'd like to make a custom method for a player to leave a party. Setting
/// `leaveVerb` to `undefined` also disables aborting the party.
/// 
/// @param {Enum.INPUT_VERB,Real} joinVerb
/// @param {Real} minPlayers
/// @param {Real} maxPlayers
/// @param {Bool} fillEmptyPlayers
/// @param {Enum.INPUT_VERB,Real,Undefined} [leaveVerb]
/// @param {Method,Undefined} [abortCallback]
/// @param {Bool} hotswapOnAbort

function InputPartySetParams(_joinVerb, _minPlayers, _maxPlayers, _fillEmpty, _leaveVerb = undefined, _abortCallback = undefined, _hotswapOnAbort)
{
    static _system = __InputPartySystem();
    with(_system)
    {
        __minPlayers     = clamp(_minPlayers, 0, INPUT_MAX_PLAYERS);
        __maxPlayers     = clamp(_maxPlayers, 0, INPUT_MAX_PLAYERS);
        __fillEmpty      = _fillEmpty;
        __joinVerb       = _joinVerb;
        __leaveVerb      = _leaveVerb;
        __abortCallback  = _abortCallback;
        __hotswapOnAbort = _hotswapOnAbort;
    }
}