// Feather disable all

/// Registers a callback to be executed at a suitable time by the library. The callback type
/// should be a member of the `INPUT_PLUG_IN_CALLBACK` enum.
/// 
/// You may also specify a callback priority. Because many callbacks can be registered to any
/// particular callback type, and because code order might matter in some situations, it is useful
/// to be able to control what order callbacks are executed. Native library code always has a
/// priority of 0 and plug-ins cannot use a priority of 0. Higher priorities are executed first.
/// 
/// There are various different callback types that you can use. You will need to call
/// `InputPlugInRegisterCallback()` for each method you wish to attach. You may attach multiple
/// methods to the same callback (though we'd recommend using a different priority for each
/// callback to ensure execution order is consistent).
/// 
/// As previously mentioned, all of Input's internal code is executed with a priority of 0.
/// Callbacks with a higher priority are executed before internal code, callbacks with a lower
/// priority are executed after internal code. The table below describes what Input is doing itself
/// for each callback. Attaching a method before a callback allows you to set information that
/// Input will subsequently process. Attaching a method after a callback allows you to override
/// state that Input has set.
/// 
/// The table is organized, from top to bottom, in the rough order of execution per GameMaker step.
/// Not all callbacks will necessarily be executed every frame and some callbacks may be executed
/// multiple times a frame (for example, `.GAMEPAD_DISCONNECTED`). Some callbacks may be executed
/// at different times depending on other factors - the table is a guide.
/// 
/// |Enum member             |Purpose                                                                                         |
/// |------------------------|------------------------------------------------------------------------------------------------|
/// |`.COLLECT`              |Trigger the raw value collection for all players                                                |
/// |`.COLLECT_PLAYER`       |Reset and then collect raw values for each verb for a particular player                         |
/// |`.UPDATE`               |Updates the entire state of Input, including focus checks, gamepad state, and per-player updates|
/// |`.LOSE_FOCUS`           |Game window has lost focus                                                                      |
/// |`.GAIN_FOCUS`           |Game window has regained focus                                                                  |
/// |`.GAMEPAD_DISCONNECTED` |Gamepad has been disconnected                                                                   |
/// |`.GAMEPAD_CONNECTED`    |Gamepad has been connected                                                                      |
/// |`.UPDATE_PLAYER`        |Reset and then update state for every verb: press, press frame, held state, release             |
/// |`.PLAYER_DEVICE_CHANGED`|Player changed what device they've been assigned, either due to a hotswap or manual set         |
/// 
/// The method that you specify will be handed parameters, though what parameters specifically
/// depends on the callback type:
/// 
/// |Enum member             |Parameters                                      |
/// |------------------------|------------------------------------------------|
/// |`.COLLECT`              |(No parameters)                                 |
/// |`.UPDATE`               |(No parameters)                                 |
/// |`.GAMEPAD_DISCONNECTED` |Device index, Hardware disconnected             |
/// |`.GAMEPAD_CONNECTED`    |Device index                                    |
/// |`.PLAYER_DEVICE_CHANGED`|Player index, Old device index, New device index|
/// |`.COLLECT_PLAYER`       |Player index                                    |
/// |`.UPDATE_PLAYER`        |Player index                                    |
/// |`.LOSE_FOCUS`           |(No parameters)                                 |
/// |`.GAIN_FOCUS`           |(No parameters)                                 |
/// 
/// The `Hardware disconnected` parameter for the `.GAMEPAD_DISCONNECTED` will be set to `true` if
/// a gamepad was disconnected at a hardware level. If the gamepad has been disconnected instead by
/// `InputPlugInGamepadBlock()` then the callback will be executed with the `Hardware disconnected`
/// parameter set to `false`.
/// 
/// @param {Enum.INPUT_PLUG_IN_CALLBACK,Real} callbackType
/// @param {Real} [priority=-1]
/// @param {Method} method

function InputPlugInRegisterCallback(_callbackType, _priority = -1, _method)
{
    if (_priority == 0)
    {
        __InputError("Cannot use priority 0 for plug-ins");
    }
    
    __InputPlugInRegisterCallbackInternal(_callbackType, _priority, _method);
}