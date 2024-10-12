# Player

&nbsp;

## …IsConnected

`InputPlayerIsConnected([playerIndex])`

<!-- tabs:start -->

#### **Description**

**Returns:** Boolean, whether a player's device is connected and available for use

|Name            |Datatype|Purpose                                             |
|----------------|--------|----------------------------------------------------|
|`[playerIndex]` |integer |Player to target. If not specified, player 0 is used|

Returns if the player is using a connected device. `INPUT_TOUCH` and `INPUT_KBM` will always be considered connected on a desktop and mobile platform respectively. `INPUT_GENERIC_DEVICE` will always be considered connected.

#### **Example**

```gml
//Draw an icon for each connected player
for(var _player = 0; _player < INPUT_MAX_PLAYERS; _player++)
{
    if (InputPlayerIsConnected(_player))
    {
        draw_sprite(sPlayerIcon, _player, x + 40*_player, y);
    }
    else
    {
        //But draw a different icon if they're disconnected
        draw_sprite(sPlayerDisconnectedIcon, 0, x + 40*_player, y);
    }
}
```

<!-- tabs:end -->

&nbsp;

## …ConnectedCount

`InputPlayerConnectedCount(verbIndex, [playerIndex])`

<!-- tabs:start -->

#### **Description**

**Returns:** Integer, the total number of connected players.

|Name|Datatype|Purpose|
|----|--------|-------|
|None|        |       |

Returns the total number of connected players.

<!-- tabs:end -->

&nbsp;

## …GetBlocked

`InputPlayerGetBlocked([playerIndex])`

<!-- tabs:start -->

#### **Description**

**Returns:** Boolean, whether the player has their input set as blocked

|Name           |Datatype|Purpose                                             |
|---------------|--------|----------------------------------------------------|
|`[playerIndex]`|intger  |Player to target. If not specified, player 0 is used|

Returns whether the player has their input set as blocked.

<!-- tabs:end -->

&nbsp;

## …GetDevice

`InputPlayerGetDevice([playerIndex])`

<!-- tabs:start -->

#### **Description**

**Returns:** Integer, the device index for the player

|Name           |Datatype|Purpose                                             |
|---------------|--------|----------------------------------------------------|
|`[playerIndex]`|intger  |Player to target. If not specified, player 0 is used|

Returns the device assigned to a player. This can be one of the following:
- `INPUT_NO_DEVICE`
- `INPUT_GENERIC_DEVICE`
- `INPUT_KBM`
- `INPUT_TOUCH`
- A native GameMaker gamepad index

#### **Example**

```gml
//Draw the player
draw_self();

//If they're using a gamepad and are holding the select button...
var _device = InputPlayerGetDevice(playerIndex);
if (InputDeviceIsGamepad(_device) && (InputDeviceGetGamepadValue(_device, vk_select)))
{
    //Then draw a gamepad icon above their head
    draw_sprite(sGamepadIcon, 0, x, y - 20);
}
```

<!-- tabs:end -->

&nbsp;

## …GetGamepadType

`InputPlayerGetGamepadType([playerIndex])`

<!-- tabs:start -->

#### **Description**

**Returns:** Integer, the gamepad type for the device that the player is using

|Name           |Datatype|Purpose                                             |
|---------------|--------|----------------------------------------------------|
|`[playerIndex]`|intger  |Player to target. If not specified, player 0 is used|

Returns the gamepad type of the currently connected gamepad for a player. If the player is not currently using a gamepad, this function will return `undefined`.

Game type will be a member of the `INPUT_GAMEPAD_TYPE_*` macros:
 - `INPUT_GAMEPAD_TYPE_UNKNOWN`
 - `INPUT_GAMEPAD_TYPE_XBOX`
 - `INPUT_GAMEPAD_TYPE_PS4`
 - `INPUT_GAMEPAD_TYPE_PS5`
 - `INPUT_GAMEPAD_TYPE_SWITCH`
 - `INPUT_GAMEPAD_TYPE_JOYCON_LEFT`
 - `INPUT_GAMEPAD_TYPE_JOYCON_RIGHT`

#### **Example**

```gml
/// @desc    Returns the gamepad icon sprite for the given player
/// @param   playerIndex

function GetGamepadIcon(_player_index)
{
    var _type = InputPlayerGetGamepadType(_player_index);
    switch(_type)
    {
        case INPUT_GAMEPAD_TYPE_UNKNOWN:
            var _sprite = sGamepadIconEmpty;
        break;

        case INPUT_GAMEPAD_TYPE_PSX:
        case INPUT_GAMEPAD_TYPE_PS4:
        case INPUT_GAMEPAD_TYPE_PS5:
            var _sprite = sGamepadIconPlayStation;
        break;

        case INPUT_GAMEPAD_TYPE_SWITCH:
            var _sprite = sGamepadIconSwitch;
        break;

        default:
            //Fall back on a generic Xbox-type gamepad icon
            var _sprite = sGamepadIconXbox;
        break;
    }

    return _sprite;
```

<!-- tabs:end -->

&nbsp;

## …GetGhost

`InputPlayerGetGhost([playerIndex])`

<!-- tabs:start -->

#### **Description**

**Returns:** Boolean, whether the player has their input set as blocked

|Name           |Datatype|Purpose                                             |
|---------------|--------|----------------------------------------------------|
|`[playerIndex]`|intger  |Player to target. If not specified, player 0 is used|

Returns whether a player is set as a ghost by `InputPlayerSetGhost()`.

#### **Example**

```gml
//Draw the player
draw_self();

//If this is a ghost player then it's AI controlled
//Draw an icon to represent this
if (InputPlayerGhostGet(playerIndex))
{
    draw_sprite(sAIPlayerIcon, 0, x, y - 18);
}
```

<!-- tabs:end -->

&nbsp;

## …GetInactive

`InputPlayerGetInactive([playerIndex])`

<!-- tabs:start -->

#### **Description**

**Returns:** Boolean, whether the player hasn't made an input recently

|Name           |Datatype|Purpose                                                                      |
|---------------|--------|-----------------------------------------------------------------------------|
|`duration`     |number  |How long to wait since the last input before returning the player as inactive|
|`[playerIndex]`|intger  |Player to target. If not specified, player 0 is used                         |

Returns whether a player is inactive i.e. has not pressed a button on their device. The `duration` parameter is measured in milliseconds and specifies the timeout duration.

#### **Example**

```gml
//Draw the player
draw_self();

//Draw an icon over the player's head if they're inactive
if (InputPlayerGetInactive(playerIndex))
{
    draw_sprite(sPlayerInactiveIcon, 0, x, y - 18);
}
```

<!-- tabs:end -->

&nbsp;

## …GetLastConnectedGamepadType

`InputPlayerGetLastConnectedGamepadType([playerIndex])`

<!-- tabs:start -->

#### **Description**

**Returns:** Integer, the gamepad type for the last device that the player was using

|Name           |Datatype|Purpose                                             |
|---------------|--------|----------------------------------------------------|
|`[playerIndex]`|intger  |Player to target. If not specified, player 0 is used|

Returns the gamepad type of the currently connected gamepad for a player or, if the player is not using a gamepad, returns the type for the last connected gamepad. If the player hash never used a gamepad, this function will return `undefined`.

Game type will be a member of the `INPUT_GAMEPAD_TYPE_*` macros:
 - `INPUT_GAMEPAD_TYPE_UNKNOWN`
 - `INPUT_GAMEPAD_TYPE_XBOX`
 - `INPUT_GAMEPAD_TYPE_PS4`
 - `INPUT_GAMEPAD_TYPE_PS5`
 - `INPUT_GAMEPAD_TYPE_SWITCH`
 - `INPUT_GAMEPAD_TYPE_JOYCON_LEFT`
 - `INPUT_GAMEPAD_TYPE_JOYCON_RIGHT`

<!-- tabs:end -->

&nbsp;

## …GetMetadata

`InputPlayerGetMetadata([playerIndex])`

<!-- tabs:start -->

#### **Description**

**Returns:** Any, the metadata for the player as set by `InputPlayerSetMetadata()`

|Name           |Datatype|Purpose                                                                      |
|---------------|--------|-----------------------------------------------------------------------------|
|`[playerIndex]`|intger  |Player to target. If not specified, player 0 is used                         |
|`[makeCopy]`   |boolean |Whether to return a copy of the metadata (`true`) or a reference to the metadata (`false`). If not specified, a reference to the metadata is returned|

Returns the metadata assigned to a player by `InputPlayerSetMetadata()`. If the `makeCopy` parameter is set to `true` then a copy of the metadata is returned; otherwise, the metadata is returned as a reference if the metadata is a struct or array.

<!-- tabs:end -->

&nbsp;

## …GetStatus

`InputPlayerGetStatus()`

<!-- tabs:start -->

#### **Description**

**Returns:** Integer, the player's connection status

|Name           |Datatype|Purpose                                             |
|---------------|--------|----------------------------------------------------|
|`[playerIndex]`|intger  |Player to target. If not specified, player 0 is used|

Returns the connection status of the player. This will be a member of the `INPUT_PLAYER_STATUS` enum:
- `INPUT_PLAYER_STATUS.DISCONNECTED`
- `INPUT_PLAYER_STATUS.NEWLY_DISCONNECTED`
- `INPUT_PLAYER_STATUS.NEWLY_CONNECTED`
- `INPUT_PLAYER_STATUS.CONNECTED`

#### **Example**

```gml
for(var _i = 0; _i < INPUT_MAX_PLAYERS; _i++)
{
	var _state = InputPlayerGetStatus(_i);

	if (_state == INPUT_PLAYER_STATUS.NEWLY_CONNECTED)
	{
	    //Pass the player index into the new oPlayer instance
	    instance_create_depth(oSpawn.x, oSpawn.y, oPlayer, { playerIndex: _i });
	}
	else if (_state == INPUT_PLAYER_STATUS.NEWLY_DISCONNECTED)
	{
		//Destroy the instance associated with the disconnected palyer
	    with(oPlayer)
	    {
	        if (playerIndex == _i) instance_destroy();
	    }
	}
}
```

<!-- tabs:end -->

&nbsp;

## …HasDevice

`InputPlayerHasDevice([playerIndex])`

<!-- tabs:start -->

#### **Description**

**Returns:** Boolean, whether the player has a device assigned

|Name           |Datatype|Purpose                                             |
|---------------|--------|----------------------------------------------------|
|`[playerIndex]`|intger  |Player to target. If not specified, player 0 is used|

Returns if the player has any device set (i.e. not `INPUT_NO_DEVICE`).

<!-- tabs:end -->

&nbsp;

## …HasDeviceCount

`InputPlayerHasDeviceCount([playerIndex])`

<!-- tabs:start -->

#### **Description**

**Returns:** Integer, the number of players with assigned devices

|Name|Datatype|Purpose|
|----|--------|-------|
|None|        |       |

Returns the total number of players who have a device set (i.e. not `INPUT_NO_DEVICE`). This is **not** the same as counting the number of connected players as a player might have been assigned a device but that device is no longer connected.

<!-- tabs:end -->