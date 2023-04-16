# Functions (Further Verbs)

&nbsp;

## …verb_consume

`input_verb_consume(verb, [playerIndex])`

<!-- tabs:start -->

#### **Description**

**Returns:** N/A (`undefined`)

|Name           |Datatype                            |Purpose                                                                                                          |
|---------------|------------------------------------|-----------------------------------------------------------------------------------------------------------------|
|`verb`         |[verb](Verbs-and-Alternate-Bindings)|[Verb](Verbs-and-Alternate-Bindings) to consume. If keyword `all` is used, all verbs for the player are consumed.|
|`[playerIndex]`|integer                             |Player to target. If not specified, player 0 is used                                                             |

When a verb has been consumed, [check functions](Functions-(Checkers)) that target the verb will return `false` until the button is released and pressed again.

&nbsp;

## …verb_set

`input_verb_set(verb, value, [playerIndex])`

<!-- tabs:start -->

#### **Description**

**Returns:** N/A (`undefined`)

|Name           |Datatype                             |Purpose                                                                                                 |
|---------------|-------------------------------------|--------------------------------------------------------------------------------------------------------|
|`verb`         |[verb](Verbs-and-Alternate-Bindings) |[Verb](Verbs-and-Alternate-Bindings) to set                                                             |
|`value`        |number                               |Value to set for the verb, from `-1` to `+1` (though most verbs will only expect values from `0` to `+1`|
|`[playerIndex]`|integer                              |Player to target. If not specified, player 0 is used                                                    |

#### **Example**

```gml
//TODO lol
```

<!-- tabs:end -->

&nbsp;

## …chord_create

`input_chord_create(name, maxTimeBetweenPresses, verb1, verb2, ...)`

<!-- tabs:start -->

#### **Description**

**Returns:** N/A (`undefined`)

|Name                   |Datatype                  |Purpose                                                                                                                        |
|-----------------------|--------------------------|-------------------------------------------------------------------------------------------------------------------------------|
|`name`                 |string                    |Name of the chord verb to create                                                                                               |
|`maxTimeBetweenPresses`|number                    |Maximum time allowed between verb activations, the units of which are determined by [`INPUT_TIMER_MILLISECONDS`](Configuration)|
|`verb1`                |[verb](Verbs-and-Bindings)|Name of a required [verb](Verbs-and-Bindings)                                                                                  |
|`verb2`                |[verb](Verbs-and-Bindings)|Name of a required [verb](Verbs-and-Bindings)                                                                                  |
|...                    |                          |etc.                                                                                                                           |

A "chord" is a set of verbs that must be pressed together, for example `ctrl + alt + delete` or `ctrl + S`. When all of the specified verbs are pressed together, the chord verb itself is activated. If there is too much time between individual key presses, determined by the `maxTimeBetweenPresses` argument, then the chord verb will fail to activate.

#### **Example**

```gml
//TODO lol
```

<!-- tabs:end -->

&nbsp;

## …verb_get_icon

`input_verb_get_icon(verb, [playerIndex], [alternate], [profileName])`

<!-- tabs:start -->

#### **Description**

_Returns:_ Various, the icon identifier defined in [`__input_config_icons()`](Configuration?id=icons)

|Name           |Datatype                             |Purpose                                                                                                        |
|---------------|-------------------------------------|---------------------------------------------------------------------------------------------------------------|
|`verb`         |[verb](Verbs-and-Alternate-Bindings) |[Verb](Verbs-and-Alternate-Bindings) to return the icon for                                                    |
|`[playerIndex]`|integer                              |Player to target. If not specified, player 0 is used                                                           |
|`[alternate]`  |integer                              |[Alternate binding](Verbs-and-Bindings) to target. If not specified, `0` is used                               |
|`[profileName]`|string                               |The [profile](Profiles) to set the verb binding for. If no profile is provided then the current profile is used|

Returns the icon associated with the given verb for the device that the given player is currently using. You should edit [`__input_config_icons()`](Configuration?id=icons) to match the requirements of your game.

#### **Example**

```gml
//TODO lol
```

<!-- tabs:end -->

&nbsp;

## …verb_get_group

`input_verb_get_group(verb)`

<!-- tabs:start -->

#### **Description**

**Returns:** String or `undefined`, the collision group defined for the target verb

|Name  |Datatype                  |Purpose                             |
|------|--------------------------|------------------------------------|
|`verb`|[verb](Verbs-and-Bindings)|[Verb](Verbs-and-Bindings) to target|

String values that this function may return are defined via [`INPUT_VERB_GROUPS`](Configuration?id=profiles-and-bindings). If no verb group has been defined for the target verb then this function will return `undefined` (and the verb is considered as being in every group).

#### **Example**

```gml
//TODO lol
```

<!-- tabs:end -->

&nbsp;

## …verb_group_active

`input_verb_group_active(verbGroup, state, [playerIndex], [exclusive])`

<!-- tabs:start -->

#### **Description**

**Returns:** N/A (`undefined`)

|Name           |Datatype                        |Purpose                                                                                                                                                                                                                                            |
|---------------|--------------------------------|---------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------|
|`verbGroup`    |[verb group](Verbs-and-Bindings)|[Verb group](Verbs-and-Bindings) to target                                                                                                                                                                                                         |
|`state`        |boolean                         |State to set for the verb group                                                                                                                                                                                                                    |
|`[playerIndex]`|integer                         |Player to target. If not specified, player 0 is used                                                                                                                                                                                               |
|`[exclusive]`  |boolean                         |Whether to force all verb groups, other than the one being targeted, to be deactivated. This only applies if `state` is set to `true`. If not specified, `exclusive` defaults to `false`, allowing multiple verb groups to be active simultaneously|

A verb is considerd inactive when the verb group that that verb is a part of has been deactivated. A verb that has been assigned to no groups cannot be deactivated using this function.

#### **Example**

```gml
//TODO lol
```

<!-- tabs:end -->

&nbsp;

## …verb_group_is_active

`input_verb_group_is_active(verbGroup, [playerIndex])`

<!-- tabs:start -->

#### **Description**

**Returns:** Boolean, whether the verb group is active for the given player

|Name           |Datatype                        |Purpose                                             |
|---------------|--------------------------------|----------------------------------------------------|
|`verbGroup`    |[verb group](Verbs-and-Bindings)|[Verb group](Verbs-and-Bindings) to target          |
|`[playerIndex]`|integer                         |Player to target. If not specified, player 0 is used|

#### **Example**

```gml
//TODO lol
```

<!-- tabs:end -->

&nbsp;

## …verb_groups_get

`input_verb_groups_get(verbGroup, [playerIndex])`

<!-- tabs:start -->

#### **Description**

**Returns:** Array, the verb groups set in `__input_config_verb_groups`

|Name|Datatype|Purpose|
|----|--------|-------|
|None|        |       |

&nbsp;

## …verb_group_get_verbs

`input_verb_group_get_verbs(verbGroup)`

**Returns:** Array, the verbs set for the verb group

|Name           |Datatype                        |Purpose                                             |
|---------------|--------------------------------|----------------------------------------------------|
|`verbGroup`    |[verb group](Verbs-and-Bindings)|[Verb group](Verbs-and-Bindings) to target          |

#### **Example**

```gml
//TODO lol
```

<!-- tabs:end -->
