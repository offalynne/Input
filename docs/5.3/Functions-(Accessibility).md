# Functions (Accessibility)

&nbsp;

## `input_accessibility_global_toggle_set(state)`

*Returns:* N/A (`undefined`)

|Name   |Datatype|Purpose                                                     |
|-------|--------|------------------------------------------------------------|
|`state`|boolean |Whether to allow momentary toggles across the project at all|

&nbsp;

## `input_accessibility_global_toggle_get()`

*Returns:* Boolean, whether momentary toggle behaviour is allowed

|Name|Datatype|Purpose|
|----|--------|-------|
|None|        |       |

&nbsp;

## `input_accessibility_verb_toggle_set(verb, state)`

*Returns:* N/A (`undefined`)

|Name   |Datatype|Purpose                                         |
|-------|--------|------------------------------------------------|
|`verb` |string  |Name of the [verb](Verbs-and-Bindings) to target|
|`state`|boolean |Whether to enable toggling for the verb         |

&nbsp;

## `input_accessibility_verb_toggle_get(verb)`

*Returns:* Boolean, whether momentary toggle behaviour is enabled for the verb

|Name  |Datatype|Purpose                                         |
|------|--------|------------------------------------------------|
|`verb`|string  |Name of the [verb](Verbs-and-Bindings) to target|

&nbsp;

## `input_accessibility_global_cooldown_set(state)`

*Returns:* N/A (`undefined`)

|Name   |Datatype|Purpose                                                  |
|-------|--------|---------------------------------------------------------|
|`state`|boolean |Whether to allow verb cooldowns across the project at all|

&nbsp;

## `input_accessibility_global_cooldown_get()`

*Returns:* Boolean, whether cooldown behaviour is allowed

|Name|Datatype|Purpose|
|----|--------|-------|
|None|        |       |

&nbsp;

## `input_accessibility_verb_cooldown_set(verb, state)`

*Returns:* N/A (`undefined`)

|Name   |Datatype|Purpose                                         |
|-------|--------|------------------------------------------------|
|`verb` |string  |Name of the [verb](Verbs-and-Bindings) to target|
|`state`|boolean |Whether to enable cooldown for the verb         |

&nbsp;

## `input_accessibility_verb_cooldown_get(verb)`

*Returns:* Boolean, whether cooldown behaviour is enabled for the verb

|Name  |Datatype|Purpose                                         |
|------|--------|------------------------------------------------|
|`verb`|string  |Name of the [verb](Verbs-and-Bindings) to target|