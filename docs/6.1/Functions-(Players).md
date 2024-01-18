# Functions (Players)

&nbsp;

The functions on this page relate to player properties - whether they're connected, what sort of gamepad they're using, how many players are playing and so on.

If you're looking for a way to control what [source](Input-Sources) a player is using, including turning hotswapping on and off, please read the [source functions](Functions-(Sources)) documentation. If you're looking for a way to change a player's [binding profile](Profiles) then the [profile functions](Functions-(Profiles)) page will be helpful for you.

&nbsp;

## …player_connected

`input_player_connected([playerIndex], [includeGhost=true])`

<!-- tabs:start -->

#### **Description**

**Returns:** Boolean, whether any of the player's [sources](Input-Sources) are connected and available for use

|Name            |Datatype|Purpose                                                 |
|----------------|--------|--------------------------------------------------------|
|`[playerIndex]` |integer |Player to target. If not specified, player 0 is used    |
|`[includeGhost]`|boolean |Whether to treat ghosts as connected. Defaults to `true`|

If the player's sole source is a gamepad and that gamepad is [incompatible with SDL2](Controller-Mapping?id=controller-blacklist) then this function will return `false`.

#### **Example**

```gml
//Draw an icon for each connected player
for(var _player = 0; _player < INPUT_MAX_PLAYERS; _player++)
{
    if (input_player_connected(_player))
    {
        draw_sprite(spr_player_icon, _player, x + 40*_player, y);
    }
    else
    {
        //But draw a 
        draw_sprite(spr_player_disconnected_icon, 0, x + 40*_player, y);
    }
}
```

<!-- tabs:end -->

&nbsp;

## …player_connected_count

`input_player_connected_count([includeGhosts])`

<!-- tabs:start -->

#### **Description**

**Returns:** Integer, the number of players with connected devices

|Name             |Datatype|Purpose                                                 |
|-----------------|--------|--------------------------------------------------------|
|`[includeGhosts]`|boolean |Whether to treat ghosts as connected. Defaults to `true`|

#### **Example**

```gml
//Grab the max number of players from the .JOIN source mode parameters
var _max_players = input_join_params_get().max_players;

//Build a string reporting the number of players connected, and then draw it
var _string = string(input_players_connected_count()) + "/" + string(_max_players) + " players connected";
draw_text(x, y, _string);
```

<!-- tabs:end -->

&nbsp;

## …players_using_source

`input_players_using_source(source, [firstPlayer])`

<!-- tabs:start -->

#### **Description**

**Returns:** Integer or array of integers, players using the indicated source(s)

|Name           |Datatype|Purpose                                                 |
|---------------|--------|--------------------------------------------------------|
|`source`       |[Source](Input-Sources)|[Input source](Input-Sources) to check   |
|`[firstPlayer]`|boolean |Whether to return only the first player using the source instead of an array of players. Defaults to `false`|

#### **Example**

```gml
var _keyboard_players = input_players_using_source(INPUT_KEYBOARD);
draw_text(10, 10, string(array_count(_keyboard_players)) + " players are using the keyboard source");
```

<!-- tabs:end -->

&nbsp;

## …players_get_status

`input_players_get_status()`

<!-- tabs:start -->

#### **Description**

**Returns:** Struct, detailing the state of player connection and disconnection

|Name|Datatype|Purpose|
|----|--------|-------|
|None|        |       |

This function returns a struct that describes the state of each player's connectivity, following the formatting below. This data is useful for detecting a change in player state wherein the game may need to create a new instance for that player or show a disconnection warning.

!> Do not edit the struct that this function returns! You may encounter undefined behaviour if you do.

```
{
    any_changed: <boolean that indicates whether anything has changed at all>
    new_connections: [
        <array of player indexes that are newly connected this step>
    ],
    new_disconnections: [
        <array of player indexes that are newly disconnected this step>
    ],
    players: [
        <array of values from the INPUT_STATUS enum, one for each player up to INPUT_MAX_PLAYERS>
    ],
}
```

The `INPUT_STATUS` enum contains the following members:

|Name                 |Purpose                                         |
|---------------------|------------------------------------------------|
|`.NEWLY_DISCONNECTED`|Player has been disconnected this frame         |
|`.DISCONNECTED`      |Player is disconnected (for at least two frames)|
|`.NEWLY_CONNECTED`   |Player has been connected this frame            |
|`.CONNECTED`         |Player is connected (for at least two frames)   |

#### **Example**

```gml
//Pick up incoming new players and outgoing old users
var _status = input_players_get_status();
if (_status.any_changed)
{
    //Iterate over new players and create a new player instance for each
    for(var _i = 0; _i < array_length(_status.new_connections); _i++)
    {
        var _new_player = _status.new_connections[_i];

        //Pass the player index into the new obj_player instance
        instance_create_depth(obj_spawn.x, obj_spawn.y, obj_player, {player_index: _new_player});
    }

    //Find any obj_player instances for disconnected players and destroy them
    for(var _i = 0; _i < array_length(_status.new_disconnections); _i++)
    {
        var _old_player = _status.new_disconnections[_i];
        with(obj_player)
        {
            if (player_index == _old_player) instance_destroy();
        }
    }
}
```

<!-- tabs:end -->

&nbsp;

## …player_get_gamepad

`input_player_get_gamepad([playerIndex], [binding])`

<!-- tabs:start -->

#### **Description**

**Returns:** Integer, a [gamepad](https://manual.yoyogames.com/#t=GameMaker_Language%2FGML_Reference%2FGame_Input%2FGamePad_Input%2FGamepad_Input.htm) index

|Name           |Datatype                     |Purpose                                                                                                                                                                                                    |
|---------------|-----------------------------|-----------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------|
|`[playerIndex]`|integer                      |Player to target. If not specified, player 0 is used                                                                                                                                                       |
|`[binding]`    |[binding](Verbs-and-Bindings)|Binding to return the gamepad for. This is only valid in [multidevice mode](Input-Sources?id=input_source_modemultidevice). If no binding is provided then the player's first connected gamepad is returned|

This function will return `-1` if the player has no connected gamepad. If you provide a [binding](Verbs-and-Bindings) to check, and Input is running in [multidevice mode](Input-Sources?id=input_source_modemultidevice), then this function will return the gamepad index for the specific gamepad associated with the provided binding.

?> If the player has multiple gamepad [sources](Input-Sources) assigned to them, and no binding is provided, then this function will return the index of the first connected gamepad.

#### **Example**

```gml
//Draw the player
draw_self();

//If they're using a gamepad and are holding the select button...
var _gamepad = input_player_get_gamepad(player_index);
if ((_gamepad >= 0) && (input_gamepad_check(_gamepad, vk_select)))
{
    //Then draw a gamepad icon above their head
    draw_sprite(spr_gamepad_icon, 0, x, y - 20);
}
```

<!-- tabs:end -->

&nbsp;

## …player_get_gamepad_type

`input_player_get_gamepad_type([playerIndex], [binding])`

<!-- tabs:start -->

#### **Description**

**Returns:** String, a constant indicating the player's [gamepad type constant](Library-Constants#gamepad-types)

|Name           |Datatype                     |Purpose                                                                                                                                                                                                    |
|---------------|-----------------------------|-----------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------|
|`[playerIndex]`|integer                      |Player to target. If not specified, player 0 is used                                                                                                                                                       |
|`[binding]`    |[binding](Verbs-and-Bindings)|Binding to return the gamepad for. This is only valid in [multidevice mode](Input-Sources?id=input_source_modemultidevice). If no binding is provided then the player's first connected gamepad is returned|

If the player has no connected gamepad then this function will return `INPUT_GAMEPAD_TYPE_UNKNOWN`. If you provide a [binding](Verbs-and-Bindings) to check, and Input is running in [multidevice mode](Input-Sources?id=input_source_modemultidevice), then this function will return the [gamepad type constant](Library-Constants#gamepad-types) for the specific gamepad associated with the provided binding.

[XInput](https://wikipedia.org/wiki/DirectInput#XInput) controllers will typically return `INPUT_GAMEPAD_TYPE_XBOX_ONE` whereas any unrecognised gamepad will return `INPUT_GAMEPAD_TYPE_UNKNOWN`. Xbox Series X/S controllers will return `INPUT_GAMEPAD_TYPE_XBOX_ONE` owing to similarities across console generations, and that Xbox One gamepads are forwards compatible.

?> If the player has multiple gamepad [sources](Input-Sources) assigned to them, and no binding is provided, then this function will return the type for the first connected gamepad.

#### **Example**

```gml
/// @desc    Returns the gamepad icon sprite for the given player
/// @param   playerIndex

function get_gamepad_icon(_player_index)
{
    var _type = input_player_get_gamepad_type(_player_index);
    switch(_type)
    {
        case INPUT_GAMEPAD_TYPE_UNKNOWN:
            var _sprite = spr_gamepad_icon_empty;
        break;

        case INPUT_GAMEPAD_TYPE_PSX:
        case INPUT_GAMEPAD_TYPE_PS4:
        case INPUT_GAMEPAD_TYPE_PS5:
            var _sprite = spr_gamepad_icon_ps;
        break;

        case INPUT_GAMEPAD_TYPE_SWITCH:
            var _sprite = spr_gamepad_icon_switch;
        break;

        default:
            //Fall back on a generic Xbox-type gamepad icon
            var _sprite = spr_gamepad_icon_xbox;
        break;
    }

    return _sprite;
```

<!-- tabs:end -->

&nbsp;

## …player_get_invalid_gamepad_bindings

`input_player_get_invalid_gamepad_bindings([playerIndex])`

<!-- tabs:start -->

#### **Description**

**Returns:** Array of structs, gamepad bindings that are invalid due to the gamepad lacking certain mapped inputs

|Name           |Datatype|Purpose                                             |
|---------------|--------|----------------------------------------------------|
|`[playerIndex]`|integer |Player to target. If not specified, player 0 is used|

This functions checks to see whether the current bindings for the given player are valid. Any bindings that are found to be invalid are stored and returned as an array. If there are no invalid bindings, this function will return an empty array.

An invalid binding occurs when the player's gamepad lacks a button or axis that the current binding scheme requires. For example, single Switch Joy-Cons lack a dpad; if the player has a verb mapped to one of the dpad buttons then that verb is no longer accessible if the player uses a single Joy-Con to play.

Single Switch Joy-Cons are far from the only gamepad with fewer buttons than a "standard" Xbox / PlayStation controller. How you respond to devices that lack certain buttons is up to you.

The array returned by this function contains structs. Each struct contains two member variables:

|Name       |Description                                                                                                                                                                        |
|-----------|-----------------------------------------------------------------------------------------------------------------------------------------------------------------------------------|
|`verb`     |[Verb](Verbs-and-Bindings) that contains the invalid binding                                                                       |
|`alternate`|[Alternate index](Verbs-and-Bindings) for the invalid binding                                                                      |
|`gm`       |[Virtual button/axis constant](https://manual.yoyogames.com/#t=GameMaker_Language%2FGML_Reference%2FGame_Input%2FGamePad_Input%2FGamepad_Input.htm) that is missing from the player's gamepad|

#### **Example**

```gml
//Show a warning message in the UI if the player has some invalid bindings set up
var _invalid_array = input_player_get_invalid_gamepad_bindings();
if (array_length(_invalid_array) > 0)
{
    draw_sprite(spr_warning, 0, x, y);
    draw_text(x + 24, y + 4, "Incompatible bindings found");
}
```

<!-- tabs:end -->

&nbsp;

## …player_ghost_set

`input_player_ghost_set(state, [playerIndex])`

<!-- tabs:start -->

#### **Description**

**Returns:** N/A (`undefined`)

|Name           |Datatype|Purpose                                              |
|---------------|--------|-----------------------------------------------------|
|`state`        |boolean |Whether the player should be set to ghost mode or not|
|`[playerIndex]`|integer |Player to target. If not specified, player 0 is used |

Ghost mode prevents any sources being assigned to this player, but the player is always considered connected. This is useful for a number of things in your game:
- Representing remote players in networked multiplayer
- AI-controlled players
- Replaying gameplay e.g. showing gameplay for the best track time in a racing game

You may pass the GameMaker keyword `all` as the player index to set the ghost state for all players.

!> When you set a player to ghost mode, all [sources](Input-Sources) assigned to the target player are cleared.

?> To manually pipe input to a ghost player, please use [`input_verb_set()`](Functions-(Further-Verbs)?id=verb_set).

#### **Example**

```gml
if (input_check_pressed("accept", 0))
{
    //If P1 wants to start the game, set any disconnected players to ghosts
    //(This code presumes all players are initially in a non-ghost state)

    var _start = input_player_connected_count(false);
    for(var _i = _start; _i < INPUT_MAX_PLAYERS; _i++)
    {
        input_player_ghost_set(true, _i);
    }

    room_goto(rm_gameplay);
}
else if (input_check_pressed("cancel"))
{
    //Ensure all players are non-ghosts if we cancel
    input_player_ghost_set(false, all);
}
```

<!-- tabs:end -->

&nbsp;

## …player_ghost_get

`input_player_ghost_get([playerIndex])`

<!-- tabs:start -->

#### **Description**

**Returns:** Boolean, whether the player is in ghost mode

|Name           |Datatype|Purpose                                              |
|---------------|--------|-----------------------------------------------------|
|`[playerIndex]`|integer |Player to target. If not specified, player 0 is used |

#### **Example**

```gml
//Draw the player
draw_self();

//If this is a ghost player then it's AI controlled
//Draw an icon to represent this
if (input_player_ghost_get(player_index))
{
    draw_sprite(spr_ai_player_icon, 0, x, y - 18);
}
```

<!-- tabs:end -->

&nbsp;

## …player_swap

`input_player_swap(playerIndexA, playerIndexB)`

<!-- tabs:start -->

#### **Description**

**Returns:** N/A (`undefined`)

|Name          |Datatype|Purpose                |
|--------------|--------|-----------------------|
|`playerIndexA`|integer |First player to target |
|`playerIndexB`|integer |Second player to target|

This function will swap over the two players with the given indices. This includes any player input state, bindings, source etc.

#### **Example**

```gml
//If P1 is disconnected...
if (!input_player_connected(0))
{
    //Then find the first connected player and swap them into the P1 slot
    for(var _i = 1; _i < INPUT_MAX_PLAYERS; _i++)
    {
        if (input_player_connected(_i))
        {
            input_player_swap(0, _i);

            //Make sure we break out of the loop!
            break;
        }
    }

    //If P1 *still* isn't connected then throw up a disconnection modal
    if (!input_player_connected(0))
    {
        show_disconnection_modal();
    }
}
```

<!-- tabs:end -->

&nbsp;

## …player_gamepad_type_override_set

`input_player_gamepad_type_override_set(gamepadType, [playerIndex])`

<!-- tabs:start -->

#### **Description**

**Returns:** N/A (`undefined`)

|Name           |Datatype|Purpose                                              |
|---------------|--------|-----------------------------------------------------|
|`gamepadType`  |string  |[Gamepad type](Library-Constants#gamepad-types)  to use for icon getters                 |
|`[playerIndex]`|integer |Player to target. If not specified, player 0 is used |

This function forces the icon getter functions (`input_verb_get_icon()` and `input_binding_get_icon()`) to use a specific [gamepad type](Library-Constants#gamepad-types)  when the player is using a gamepad. Use a gamepad type of `undefined` to not force a gamepad type.

!> `input_player_gamepad_type_override_set()` only changes what icons are displayed. It doesn't change the value returned from `input_player_get_gamepad_type()`.

#### **Example**

```gml
//Get the current override type for the player
var _override = input_player_gamepad_type_override_get();

//Convert it to a number for the purposes of scrolling
switch(_override)
{
    case undefined:
        var _index = 0;
    break;

    case INPUT_GAMEPAD_TYPE_PSX:
    case INPUT_GAMEPAD_TYPE_PS4:
    case INPUT_GAMEPAD_TYPE_PS5:
        _var _index = 2;
    break;

    case INPUT_GAMEPAD_TYPE_SWITCH:
        _var _index = 3;
    break;

    default:
        var _index = 1;
    break;
}

//Allow scrolling by pressing the left/right verbs
_index = (_index + input_opposing_press("left", "right")) mod 4;

//Convert back to a type
switch(_index)
{
    case 0: var _type = undefined;                   break;
    case 1: var _type = INPUT_GAMEPAD_TYPE_XBOX_ONE; break;
    case 2: var _type = INPUT_GAMEPAD_TYPE_PS5;      break;
    case 3: var _type = INPUT_GAMEPAD_TYPE_SWITCH;   break;
}

//Set the type override
input_player_gamepad_type_override_set(_type);

//And finally draw the override type to the screen
var _display = (_type == undefined)? "unset" : _type;
draw_text(x, y, _display);
```

<!-- tabs:end -->

&nbsp;

## …player_gamepad_type_override_get

`input_player_gamepad_type_override_get([playerIndex])`

<!-- tabs:start -->

#### **Description**

**Returns:** String, what [gamepad type constant](Library-Constants#gamepad-types)  override has been set (or `undefined` if none has been set)

|Name           |Datatype|Purpose                                              |
|---------------|--------|-----------------------------------------------------|
|`[playerIndex]`|integer |Player to target. If not specified, player 0 is used |

#### **Example**

```gml
//If we're in debug mode, show some gamepad type info
if (debug_mode)
{
    //The resulting gamepad type shown to the player
    var _shown_type  = input_player_get_gamepad_type();

    //The type set as the override via the Settings menu
    var _override_type = input_player_gamepad_type_override_get();

    //The detected type for the hardware itself (the ground truth)
    var _hardware_type = input_gamepad_get_type(input_player_get_gamepad());

    //Format the string and draw it!
    var _string = "gamepad = " + _shown_type + " (" + string(_override_type) + " overrides " + _hardware_type + ")";
    draw_text(x, y, _string);
}
```

<!-- tabs:end -->
