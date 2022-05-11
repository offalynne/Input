# Functions (Verbs)

&nbsp;

## `input_consume(verb, [playerIndex])`

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

## `input_verb_get_groups(verb)`

*Returns:* Array or `undefined`, the collision groups defined for the target verb

|Name  |Datatype                  |Purpose                             |
|------|--------------------------|------------------------------------|
|`verb`|[verb](Verbs-and-Bindings)|[Verb](Verbs-and-Bindings) to target|

Values that this function returns are defined via [`INPUT_VERB_COLLISION_GROUPS`](Configuration?id=profiles-and-bindings). If no collision groups have been defined for the target verb then this function will return `undefined` (and the verb is considered as being in every collision group).

&nbsp;

## `input_verb_group_active(verbGroup, state, [playerIndex])`

*Returns:* N/A (`undefined`)

|Name           |Datatype                        |Purpose                                             |
|---------------|--------------------------------|----------------------------------------------------|
|`verbGroup`    |[verb group](Verbs-and-Bindings)|[Verb](Verbs-and-Bindings) to target                |
|`state`        |boolean                         |State to set for the verb group                     |
|`[playerIndex]`|integer                         |Player to target. If not specified, player 0 is used|

&nbsp;

## `input_verb_group_is_active(verbGroup, [playerIndex])`

*Returns:* Boolean, whether the verb group is active for the given player

|Name           |Datatype                        |Purpose                                             |
|---------------|--------------------------------|----------------------------------------------------|
|`verbGroup`    |[verb group](Verbs-and-Bindings)|[Verb group](Verbs-and-Bindings) to target          |
|`[playerIndex]`|integer                         |Player to target. If not specified, player 0 is used|
