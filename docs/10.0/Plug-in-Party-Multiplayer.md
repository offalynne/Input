# Plug-in: Party Multiplayer

&nbsp;

The Party Multiplayer Plug-in handles automatic assigment of devices to players for multiplayer. 

&nbsp;

## …PartySetJoin

`InputPartySetJoin(joinVerb, minPlayers, maxPlayers, fillEmptyPlayers, leaveVerb, abortCallback, hotswapOnAbort)`

<!-- tabs:start -->

#### **Description**

**Returns:** N/A (`undefined`)

|Name               |Datatype |Purpose |
|-------------------|---------|--------|
|`joinVerb`         |integer  |Verb which is checked for a player to join the party. This will be respected no matter what device that player is using e.g. if the join verb is mapped to `gp_face1` on gamepad and `vk_space` on keyboard then pressing those buttons will cause the player to join the party|
|`minPlayers`       |integer  |How many players minimum should be in the party for the party to be considered "ready" as returned by `InputPartyGetReady()1|
|`maxPlayers`       |integer  |How many players maximum should be in the party for the party to be considered "ready" as returned by InputPartyGetReady()1|
|`fillEmptyPlayers` |boolean  |Whether players drop down to lower numbered player slots if they are available|
|`leaveVerb`        |integer  |Verb which is checked for a player to leave the party. If not set, or set to `undefined`, players will not have a way to leave the party. This is useful if you'd like to make a custom method for a player to leave a party. Setting `leaveVerb` to `undefined` also disables aborting the party|
|`abortCallback`    |method   |If set to a valid function, the abort feature will be enabled: If there are zero players in a party and the leave verb is activated on a device then that device is assigned to player 0 (the user of that device becomes player 0) and the abort callback is executed|
|`hotswapOnAbort`   |boolean  |Whether hotswapping will be turned on when aborting|

#### **Example**

```gml
if (InputCheck(INPUT_VERB.START))
{
	room_goto_next();
	InputPartySetJoin(INPUT_VERB.JOIN, 2, 4, true, INPUT_VERB.LEAVE, function() { room_goto_previous() }, true);
}
```
<!-- tabs:end -->

&nbsp;

## …PartyGetJoin

`InputPartyGetJoin()`

<!-- tabs:start -->

#### **Description**

**Returns:** ,

|Name           |Datatype|Purpose                                             |
|---------------|--------|----------------------------------------------------|

Returns 

#### **Example**

```gml
{
    
}
```
<!-- tabs:end -->

&nbsp;

## …PartySetParams

`InputPartySetParams()`

<!-- tabs:start -->

#### **Description**

**Returns:** ,

|Name           |Datatype|Purpose                                             |
|---------------|--------|----------------------------------------------------|

Returns 

#### **Example**

```gml
{
    
}
```
<!-- tabs:end -->

&nbsp;

## …PartyGetParams

`InputPartyGetParams()`

<!-- tabs:start -->

#### **Description**

**Returns:** ,

|Name           |Datatype|Purpose                                             |
|---------------|--------|----------------------------------------------------|

Returns 

#### **Example**

```gml
{
    
}
```
<!-- tabs:end -->

&nbsp;

## …PartyGetReady

`InputPartyGetReady()`

<!-- tabs:start -->

#### **Description**

**Returns:** ,

|Name           |Datatype|Purpose                                             |
|---------------|--------|----------------------------------------------------|

Returns 

#### **Example**

```gml
{
    
}
```
<!-- tabs:end -->