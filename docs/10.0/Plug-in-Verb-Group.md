# Plug-in: Verb Group

&nbsp;

The verb group plug-in allows you to differentiate groups of verbs that should not affect one another when checking for collision. This is useful for separating sets of verbs that are contextually separate, such as verbs that are used in a menu and verbs that are used during gameplay. By putting menu verbs and gameplay verbs in two different groups, two identical bindings in two different groups can co-exist.

A verb can only be in many groups at a time and, once assigned a group, will only collide with other verbs in its group (or groups). If a verb is not assigned to a group then it may collide with all verbs, regardless of what group the colliding verb is in.

Additionally, verb groups can be activated and deactivated at will. This is useful to block off various interaction modes entirely.

&nbsp;

## Config

The verb group plug-in is configured by editing `__InputVerbGroupsConfig()`. The first step to configuring the plug-in is to add some verb groups that you're going to use. You can do this by editing the pre-existing `INPUT_VERB_GROUP` enum. For example, you may want a verb group enum set up like so:

```gml
enum INPUT_VERB_GROUP
{
    GAMEPLAY,
    MENU,
}
```

After you've added some verb groups, you'll want to call `InputVerbGroupDefine()` for each verb group. This might look like the following:

```gml
InputVerbGroupDefine(INPUT_VERB_GROUP.GAMEPLAY, [INPUT_VERB.WALK_FORWARDS, INPUT_VERB.WALK_BACK, INPUT_VERB.STRAFE_LEFT, INPUT_VERB.STRAFE_RIGHT, INPUT_VERB.SHOOT]);
InputVerbGroupDefine(INPUT_VERB_GROUP.MENU,     [INPUT_VERB.MENU_UP, INPUT_VERB.MENU_DOWN, INPUT_VERB.MENU_LEFT, INPUT_VERB.MENU_RIGHT, INPUT_VERB.ACCEPT, INPUT_VERB.CANCEL]);
```

Verbs can be assigned to any number of groups. If a verb isn't in *any* verb group then it will collide with all other verbs when using `InputBindingSetSafe()` and `InputBindingFindCollisions()`.

Finally, there is a single macro that you can toggle on and off to control verb group deactivation behavior:

|Name                              |Typical Value|Purpose                                                                                                                                                                                |
|----------------------------------|-------------|---------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------|
|`INPUT_VERB_GROUP_INACTIVE_ON_ANY`|`false`      |Whether verbs should be blocked if *any* of their verb groups are inactive. If you set this macro to `false` then a verb will only be blocked if *all* of its verb groups are inactive.|                                                      |

&nbsp;

## …Define

`InputVerbGroupDefine(verbGroupIndex, verbArray)`

<!-- tabs:start -->

#### **Description**

**Returns:** N/A (`undefined`)

|Name            |Datatype|Purpose                                          |
|----------------|--------|-------------------------------------------------|
|`verbGroupIndex`|integer |Verb group to define                             |
|`verbArray`     |integer |Array of verb indexes to assign to the verb group|

Defines a verb group and assigns verbs to it. A verb may be assigned to multiple verb groups. This function should only be called in the `__InputVerbGroupsConfig()` script. Assigning a verb to a verb group enables a few things:

1. Verbs in a verb group can be deactivated en masse by calling `InputVerbGroupSetActive()`. Deactivated verbs will have their raw value set to 0. If the verb is currently active (e.g. a player is holding down a keyboard key) then the verb will be considered "released" for a single frame after the verb group has been deactivated.

2. Verbs that have the same binding would normally be considered as colliding for the purposes of `InputBindingSetSafe()`. However, if two verbs share a binding but are in different verb groups then they will instead not collide. For example, if one verb in is the "gameplay" verb group and it shares a binding with a verb in the "menu" verb group then they won't collide.

!> If a verb has not been assigned to any verb group then it will be treated as though it is in every verb group for finding collisions.

#### **Example**

```gml

```

<!-- tabs:end -->

&nbsp;

## …SetActive

`InputVerbGroupSetActive(verbGroupIndex, state, [playerIndex=0], [exclusive=false])`

<!-- tabs:start -->

#### **Description**

**Returns:** N/A (`undefined`)

|Name            |Datatype|Purpose                                                                                                  |
|----------------|--------|---------------------------------------------------------------------------------------------------------|
|`verbGroupIndex`|integer |Verb group to target                                                                                     |
|`state`         |boolean |Whether to activate or deactivate the verb group                                                         |
|`[playerIndex]` |integer |Player to target. If not specified, player 0 is used                                                     |
|`[exclusive]`   |boolean |Defaults to `false`. If `state` and `exclusive` are `true` then all other verbs group will be deactivated|

Sets whether a verb group should be active or not. An inactive verb group will cause any verbs inside of it to have their raw value set to 0. If the verb is currently active (e.g. a player is holding down a keyboard key) then the verb will be considered "released" for a single frame after the verb group has been deactivated.

If the `exclusive` parameter is set to `true` then all other verb groups will be deactivated. This optional argument only applies when the `state` parameter is set to `true` (otherwise you might accidentally deactivate all verbs in your game!).

#### **Example**

```gml

```

<!-- tabs:end -->

&nbsp;

## …GetActive

`InputVerbGroupGetActive(verbGroupIndex, [playerIndex=0])`

<!-- tabs:start -->

#### **Description**

**Returns:** Boolean, if the verb group is active

|Name            |Datatype|Purpose                                             |
|----------------|--------|----------------------------------------------------|
|`verbGroupIndex`|integer |Verb group to target                                |
|`[playerIndex]` |integer |Player to target. If not specified, player 0 is used|

Returns if a verb group is active, which they are by default. A verb group can be deactivated by calling `InputVerbGroupSetActive()`.

#### **Example**

```gml

```

<!-- tabs:end -->

&nbsp;

## …ActivateAll

`InputVerbGroupActivateAll([playerIndex=0])`

<!-- tabs:start -->

#### **Description**

**Returns:** N/A (`undefined`)

|Name            |Datatype|Purpose                                             |
|----------------|--------|----------------------------------------------------|
|`[playerIndex]` |integer |Player to target. If not specified, player 0 is used|

Activates all verb groups for a player.

#### **Example**

```gml

```

<!-- tabs:end -->

&nbsp;

## …DeactivateAll

`InputVerbGroupDeactivateAll([playerIndex=0])`

<!-- tabs:start -->

#### **Description**

**Returns:** N/A (`undefined`)

|Name            |Datatype|Purpose                                             |
|----------------|--------|----------------------------------------------------|
|`[playerIndex]` |integer |Player to target. If not specified, player 0 is used|

Deactivates all verb groups for a player.

!> Be careful with the function! It's possible to accidentally lock your players out of controlling the game.

#### **Example**

```gml

```

<!-- tabs:end -->

&nbsp;

## …GetVerbs

`InputVerbGroupGetVerbs(verbGroupIndex)`

<!-- tabs:start -->

#### **Description**

**Returns:** Array of verb indexes

|Name            |Datatype|Purpose             |
|----------------|--------|--------------------|
|`verbGroupIndex`|integer |Verb group to target|

Returns an array containing all verbs that have been assigned to a verb group.

#### **Example**

```gml

```

<!-- tabs:end -->

&nbsp;

## …Get

`InputVerbGroupGet(verbIndex)`

<!-- tabs:start -->

#### **Description**

**Returns:** Array of verb group indexes

|Name            |Datatype|Purpose             |
|----------------|--------|--------------------|
|`verbGroupIndex`|integer |Verb group to target|

Returns an array that contains the verb group indexes that a verb is assigned to. If a verb is assigned to no verb groups then this function returns an empty array.

#### **Example**

```gml

```

<!-- tabs:end -->