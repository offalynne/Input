# Functions (Binding Scan)

&nbsp;

## …binding_scan_start

`input_binding_scan_start(successCallback, [failureCallback], [sourceFilter], [playerIndex])`

<!-- tabs:start -->

#### **Description**

**Returns:** N/A (`undefined`)

|Name               |Datatype                         |Purpose                                                                                                                 |
|-------------------|---------------------------------|------------------------------------------------------------------------------------------------------------------------|
|`successCallback`  |method                           |Callback function to execute when the binding scan process completes successfully                                       |
|`[failureCallback]`|method                           |Callback function to execute when the binding scan process fails. If not specified, no function is executed upon failure|
|`[sourceFilter]`   |array of [sources](Input-Sources)|[Input sources](Input-Sources) to listen to. If not specified, all of the chosen player's current sources are used      |
|`[playerIndex]`    |integer                          |Player to target. If not specified, player 0 is targeted                                                                |

This function will scan for input from a player and then execute a callback when a new, valid input was detected. The success callback is passed a single argument which is the new binding that corresponds to the detected input. After you receive the new binding in the success callback, you should then set that binding for the desired verb using `input_binding_set_safe()` (or `input_binding_set()` if you want to live dangerously).

Bindings that have not been emitted by [sources](Input-Sources) defined by the `sourceFilter` argument will be ignored.

If something unexpected happens (for example, the player's gamepad is disconnected) then this function will attempt to execute the failure callback. The failure callback is given a single argument too, though this time the value is an error code from the `INPUT_BINDING_SCAN_EVENT` enum. Error codes that this function can return are as follows:

|Name                 |Meaning                                                                                                                                                                      |
|---------------------|-----------------------------------------------------------------------------------------------------------------------------------------------------------------------------|
|`.SOURCE_INVALID`    |Player's source is invalid, usually because they have no sources assigned or their gamepad has been disconnected                                                             |
|`.SOURCE_CHANGED`    |The player's source (or sources) have been modified                                                                                                                          |
|`.PLAYER_IS_GHOST`   |Player is a ghost and cannot receive hardware input                                                                                                                          |
|`.SCAN_TIMEOUT`      |Either the player didn't enter a new binding or a stuck key prevented the system from working. The timeout period is defined by [`INPUT_BINDING_SCAN_TIMEOUT`](Config-Macros)|
|`.LOST_FOCUS`        |The application lost focus                                                                                                                                                   |
|`.PLAYER_DISCONNECTED`        |The player disconnected                                                                                                                                                   |
|`.ABORTED`           |Binding scan was aborted early due to `input_binding_scan_abort()` being called                                                                                              |

#### **Example**

```gml
//Start a binding scan
input_binding_scan_start(function(_binding)
{
	//On success, set a binding and show positive feedback
	input_binding_set_safe(oSettings.verbToSet, _binding);
	display_prompt("Binding set");
},
function(_result)
{
	//On failure, show negative feedback
	display_prompt("Failed to set binding");
})
```

<!-- tabs:end -->

&nbsp;

## …binding_scan_abort

`input_binding_scan_abort([playerIndex])`

<!-- tabs:start -->

#### **Description**

**Returns:** N/A (`undefined`)

|Name           |Datatype|Purpose                                                 |
|---------------|--------|--------------------------------------------------------|
|`[playerIndex]`|integer |Player to target. If not specified, player 0 is targeted|

Aborts binding scanning for the given player.

#### **Example**

```gml
//Track the network state
static _networkState = undefined;

//If the network state has changed...
if (_networkState != os_is_network_connected(false))
{
	//Update the tracked network state
	_networkState = os_is_network_connected(false);

	//Abort the binding scan process
	input_binding_scan_abort();

	//Show a network state prompt
	network_state_changed();
}
```

<!-- tabs:end -->

&nbsp;

## …binding_scan_in_progress

`input_binding_scan_in_progress([playerIndex])`

<!-- tabs:start -->

#### **Description**

**Returns:** Boolean, whether the given player is currently scanning for bindings

|Name           |Datatype|Purpose                                                 |
|---------------|--------|--------------------------------------------------------|
|`[playerIndex]`|integer |Player to target. If not specified, player 0 is targeted|

#### **Example**

```gml
//If we're scanning for a binding...
if (input_binding_scan_in_progress())
{
	//Then show a rotating spinner to indicate that the game is waiting for input
	draw_sprite_ext(spr_pending, 0, x, y, 1, 1, current_time/12, c_white, 1);
}
```

<!-- tabs:end -->

&nbsp;

## …binding_scan_time_remaining

`input_binding_scan_time_remaining([playerIndex])`

<!-- tabs:start -->

#### **Description**

**Returns:** Number, the amount of time left on the rebinding operation in milliseconds

|Name           |Datatype|Purpose                                                 |
|---------------|--------|--------------------------------------------------------|
|`[playerIndex]`|integer |Player to target. If not specified, player 0 is targeted|

The maximum value this function can return is `INPUT_BINDING_SCAN_TIMEOUT`. If no binding scan is active, this function returns `0`.

#### **Example**

```gml
//If we're scanning for a new binding...
if (input_binding_scan_in_progress())
{
	//Draw a progress bar to indicate there is a timeout active
	var _perc = input_binding_scan_time_remaining() / INPUT_BINDING_SCAN_TIMEOUT;
	draw_rectangle(x, y, x + 120*_perc, y + 30, false);
	draw_rectangle(x, y, x + 120, y + 30, true);
}
```

<!-- tabs:end -->

&nbsp;

## …binding_scan_set_params

`input_binding_scan_set_params([ignoreArray], [allowArray], [sourceFilter], [playerIndex])`

<!-- tabs:start -->

#### **Description**

**Returns:** N/A (`undefined`)

|Name            |Datatype|Purpose                                                                                                                                                    |
|----------------|--------|-----------------------------------------------------------------------------------------------------------------------------------------------------------|
|`[ignoreArray]` |array   |Array of keyboard keys (`vk_*`, `"A"`), mouse buttons (`mb_*`), or gamepad constants (`gp_*`) to explicitly disallow being scanned                         |
|`[allowArray]`  |array   |Array of keyboard keys (`vk_*`, `"A"`), mouse buttons (`mb_*`), or gamepad constants (`gp_*`) to explicitly scan for, excluding all other possible bindings|
|`[sourceFilter]`|array   |Array of sources to scan. If not specified, the sources currently assigned to the target player will be scanned                                            |
|`[playerIndex]` |integer |Player to target. If not specified, player 0 is targeted                                                                                                   |

This function sets up arrays of potential bindings to ignore or allow. This allows the developer to filter out potentially problematic rebindings that could interfere with stable operation.

?> If a constant appears in both lists, the "ignore" array takes precedence and the binding will be ignored.

!> Unfortunately, earlier versions of GameMaker don't have a constant for mouse wheel up/down. Instead, to specify that mouse wheel bindings should be ignore/allowed, please use the strings `"mouse wheel up"` and `"mouse wheel down"` in lieu of constants.

#### **Example**

```gml
//Only allow bindings from gamepads, and only scan for face buttons and shoulder buttons
input_binding_scan_set_params([], //Don't block anything since we're using the allow array
[
	gp_face1, gp_face2, gp_face3, gp_face4,
	gp_shoulderl,  gp_shoulderr,
	gp_shoulderlb, gp_shoulderrb,
],
INPUT_GAMEPAD);
```

<!-- tabs:end -->

&nbsp;

## …binding_scan_get_params

`input_binding_scan_get_params([playerIndex])`

<!-- tabs:start -->

#### **Description**

**Returns:** Struct, the binding scanning parameters set by `input_binding_scan_set_params()`

|Name           |Datatype|Purpose                                                 |
|---------------|--------|--------------------------------------------------------|
|`[playerIndex]`|integer |Player to target. If not specified, player 0 is targeted|

The struct returned by this function has three elements (`.ignore_array` `.allow_array` `.source_filter`) which corresponds to the values passed to `input_binding_scan_set_params()`. Editing the content in the returned struct will not implictly change behaviour for binding scanning, and the order of elements in arrays returned by this function may not exactly match what was set via `input_binding_scan_set_params()`.

<!-- tabs:end -->

&nbsp;

## …binding_scan_clear_params

`input_binding_scan_clear_params([playerIndex])`

<!-- tabs:start -->

#### **Description**

**Returns:** N/A (`undefined`)

|Name           |Datatype|Purpose                                                 |
|---------------|--------|--------------------------------------------------------|
|`[playerIndex]`|integer |Player to target. If not specified, player 0 is targeted|

Clears the parameters set for binding scanning for the given player. No bindings are ignored, no bindings are explicitly allowed.

<!-- tabs:end -->