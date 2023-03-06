# Functions (Verbs)

&nbsp;

## `input_verb_consume(verb, [playerIndex])`

*Returns:* N/A (`undefined`)

|Name           |Datatype                            |Purpose                                                                                                          |
|---------------|------------------------------------|-----------------------------------------------------------------------------------------------------------------|
|`verb`         |[verb](Verbs-and-Alternate-Bindings)|[Verb](Verbs-and-Alternate-Bindings) to consume. If keyword `all` is used, all verbs for the player are consumed.|
|`[playerIndex]`|integer                             |Player to target. If not specified, player 0 is used                                                             |

When a verb has been consumed, [check functions](Functions-(Checkers)) that target the verb will return `false` until the button is released and pressed again.

&nbsp;

## `input_verb_set(verb, value, [playerIndex])`

*Returns:* N/A (`undefined`)

|Name           |Datatype                             |Purpose                                                                                                 |
|---------------|-------------------------------------|--------------------------------------------------------------------------------------------------------|
|`verb`         |[verb](Verbs-and-Alternate-Bindings) |[Verb](Verbs-and-Alternate-Bindings) to set                                                             |
|`value`        |number                               |Value to set for the verb, from `-1` to `+1` (though most verbs will only expect values from `0` to `+1`|
|`[playerIndex]`|integer                              |Player to target. If not specified, player 0 is used                                                    |

&nbsp;

## `input_verb_get_icon(verb, [playerIndex], [alternate], [profileName])`

_Returns:_ Various, the icon identifier defined in [`__input_config_icons()`](Configuration?id=icons)

|Name           |Datatype                             |Purpose                                                                                                        |
|---------------|-------------------------------------|---------------------------------------------------------------------------------------------------------------|
|`verb`         |[verb](Verbs-and-Alternate-Bindings) |[Verb](Verbs-and-Alternate-Bindings) to return the icon for                                                    |
|`[playerIndex]`|integer                              |Player to target. If not specified, player 0 is used                                                           |
|`[alternate]`  |integer                              |[Alternate binding](Verbs-and-Bindings) to target. If not specified, `0` is used                               |
|`[profileName]`|string                               |The [profile](Profiles) to set the verb binding for. If no profile is provided then the current profile is used|

Returns the icon associated with the given verb for the device that the given player is currently using. You should edit [`__input_config_icons()`](Configuration?id=icons) to match the requirements of your game.

&nbsp;

## `input_verb_get_group(verb)`

*Returns:* String or `undefined`, the collision group defined for the target verb

|Name  |Datatype                  |Purpose                             |
|------|--------------------------|------------------------------------|
|`verb`|[verb](Verbs-and-Bindings)|[Verb](Verbs-and-Bindings) to target|

String values that this function may return are defined via [`INPUT_VERB_GROUPS`](Configuration?id=profiles-and-bindings). If no verb group has been defined for the target verb then this function will return `undefined` (and the verb is considered as being in every group).

&nbsp;

## `input_verb_group_active(verbGroup, state, [playerIndex], [exclusive])`

*Returns:* N/A (`undefined`)

|Name           |Datatype                        |Purpose                                                                                                                                                                                                                                            |
|---------------|--------------------------------|---------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------|
|`verbGroup`    |[verb group](Verbs-and-Bindings)|[Verb group](Verbs-and-Bindings) to target                                                                                                                                                                                                         |
|`state`        |boolean                         |State to set for the verb group                                                                                                                                                                                                                    |
|`[playerIndex]`|integer                         |Player to target. If not specified, player 0 is used                                                                                                                                                                                               |
|`[exclusive]`  |boolean                         |Whether to force all verb groups, other than the one being targeted, to be deactivated. This only applies if `state` is set to `true`. If not specified, `exclusive` defaults to `false`, allowing multiple verb groups to be active simultaneously|

A verb is considerd inactive when the verb group that that verb is a part of has been deactivated. A verb that has been assigned to no groups cannot be deactivated using this function.

&nbsp;

## `input_verb_group_is_active(verbGroup, [playerIndex])`

*Returns:* Boolean, whether the verb group is active for the given player

|Name           |Datatype                        |Purpose                                             |
|---------------|--------------------------------|----------------------------------------------------|
|`verbGroup`    |[verb group](Verbs-and-Bindings)|[Verb group](Verbs-and-Bindings) to target          |
|`[playerIndex]`|integer                         |Player to target. If not specified, player 0 is used|

&nbsp;

## `input_verb_groups_get(verbGroup, [playerIndex])`

*Returns:* Array, the verb groups set in `__input_config_verb_groups`

|Name|Datatype|Purpose|
|----|--------|-------|
|None|        |       |

&nbsp;

## `input_verb_group_get_verbs(verbGroup)`

*Returns:* Array, the verbs set for the verb group

|Name           |Datatype                        |Purpose                                             |
|---------------|--------------------------------|----------------------------------------------------|
|`verbGroup`    |[verb group](Verbs-and-Bindings)|[Verb group](Verbs-and-Bindings) to target          |
