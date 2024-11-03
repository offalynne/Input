# Plug-in: Party Multiplayer

&nbsp;

The Party Multiplayer Plug-in handles automatic assigment of devices to players for multiplayer. 

&nbsp;

## …PartySetJoin

`InputPartySetJoin(state, [hotswapWhenOff])`

<!-- tabs:start -->

#### **Description**

**Returns:** N/A (`undefined`)

|Name               |Datatype |Purpose |
|-------------------|---------|--------|
|`state`            |boolean  |Whether party join state is enabled|
|`[hotswapWhenOff]` |boolean  |Whether hotswap is disabled when party join is disabled. Set to `true` if not specified|

Sets whether the party-joining system should be active

#### **Example**

 Sets whether the party-joining system should be active.

```gml
if (InputCheck(INPUT_VERB.START))
{
	InputPartySetJoin(true, false);
}
```
<!-- tabs:end -->

&nbsp;

## …PartyGetJoin

`InputPartyGetJoin()`

<!-- tabs:start -->

#### **Description**

**Returns:** Boolean, whether party joining is currently active

|Name|Datatype|Purpose|
|----|--------|-------|
|None|        |       |

Returns whether party joining is currently active.

#### **Example**

```gml
if (InputPartyGetJoin())
{
	for(var _i = 0; _i < 4; _i++)
	{
		draw_text(10, 10, "Player " + string(_i) + " press [JOIN]");
	}
}
```

<!-- tabs:end -->

&nbsp;

## …PartySetParams

`InputPartySetParams(joinVerb, minPlayers, maxPlayers, fillEmptyPlayers, leaveVerb, abortCallback, hotswapOnAbort)`

<!-- tabs:start -->

#### **Description**

**Returns:** N/A (`undefined`)

|Name               |Datatype |Purpose |
|-------------------|---------|--------|
|`joinVerb`         |integer  |Verb checked for a player to join the party. This will be respected no matter what device that player is using e.g. if the join verb is mapped to `gp_face1` on gamepad and `vk_space` on keyboard then pressing those buttons will cause the player to join the party|
|`minPlayers`       |integer  |How many players minimum should be in the party for the party to be considered "ready" as returned by `InputPartyGetReady()1|
|`maxPlayers`       |integer  |How many players maximum should be in the party for the party to be considered "ready" as returned by InputPartyGetReady()1|
|`fillEmptyPlayers` |boolean  |Whether players drop down to lower numbered player slots if they are available|
|`leaveVerb`        |integer  |Verb checked for a player to leave the party. If not set, or set to `undefined`, players will not have a way to leave the party. This is useful if you'd like to make a custom method for a player to leave a party. Setting `leaveVerb` to `undefined` also disables aborting the party|
|`abortCallback`    |method   |If set to a valid function, the abort feature will be enabled: If there are zero players in a party and the leave verb is activated on a device then that device is assigned to player 0 (the user of that device becomes player 0) and the abort callback is executed|
|`hotswapOnAbort`   |boolean  |Whether hotswapping will be turned on when aborting|

Sets parameters for the party joining system.

#### **Example**

```gml
if (InputCheck(INPUT_VERB.START))
{
	InputPartySetParams(INPUT_VERB.JOIN, 2, 4, true, INPUT_VERB.LEAVE, function() { room_goto_previous(); }, true);
	InputPartySetJoin(true);
	room_goto_next();
}
```
<!-- tabs:end -->

&nbsp;

## …PartyGetParams

`InputPartyGetParams()`

<!-- tabs:start -->

#### **Description**

**Returns:** Struct of party parameters

|Name|Datatype|Purpose|
|----|--------|-------|
|None|        |       |

This function returns a struct containing parameters set by `InputPartySetParams()` in a struct. This struct is static and should therefore only be used for temporary reading of data.

```
{
	joinVerb:       <integer indicating verb checked for a player to join the party>
	minPlayers:     <integer indicating how many players minimum should be in the party for the party to be considered "ready" as returned by `InputPartyGetReady()`>
	maxPlayers:     <integer indicating how many players maximum should be in the party for the party to be considered "ready" as returned by `InputPartyGetReady()`>
	fillEmpty:      <boolean indicating whether players drop down to lower numbered player slots if they are available>
	leaveVerb:      <integer indicating verb checked for a player to leave the party>
	abortCallback:  <function index for the `abortCallback` if any is set>
	hotswapOnAbort: <boolean indicating whether hotswapping will be turned on when aborting>
}
```

#### **Example**

```gml
if (global.debug)
{
	draw_text(10, 10, string_replace_all(json_stringify(InputPartyGetParams(), ",", "\n")));
}
```
<!-- tabs:end -->

&nbsp;

## …PartyGetReady

`InputPartyGetReady()`

<!-- tabs:start -->

#### **Description**

**Returns:** Boolean, whether enough players have joined the party to continue

|Name|Datatype|Purpose|
|----|--------|-------|
|None|        |       |

Returns whether enough players have joined the party to continue.

#### **Example**

```gml
if (InputPartyGetReady() && InputCheckPressed(INPUT_VERB.START))
{
	room_goto_next();
}
```
<!-- tabs:end -->