# Functions (Accessibility)

&nbsp;

- [Game Accessibility Guidelines](https://gameaccessibilityguidelines.com/) from a panel of contributors, including [OneSwich](https://www.oneswitch.org.uk/)
- [Xbox Accessibility Guidelines for Input](https://docs.microsoft.com/en-us/gaming/accessibility/xbox-accessibility-guidelines/107) from Microsoft
- [DevKit Accessibility Resource](https://specialeffectdevkit.info/input/) from [SpecialEffect](https://www.specialeffect.org.uk/)

&nbsp;

## …axis_threshold_set

`input_axis_threshold_set(axis, min, max, [playerIndex])`

<!-- tabs:start -->

#### **Description**

**Returns:** A struct with two member variables, `mini` and `maxi`, containing the minimum and maximum thresholds

|Name           |Datatype|Purpose                                             |
|---------------|--------|----------------------------------------------------|
|`axis`         |real    |[Gamepad axis](https://manual.yoyogames.com/#t=GameMaker_Language%2FGML_Reference%2FGame_Input%2FGamePad_Input%2FGamepad_Input.htm) to target|
|`min`          |real    |Minimum threshold value                             |
|`max`          |real    |Maximum threshold value                             |
|`[playerIndex]`|integer |Player to target. If not specified, player 0 is used|

#### **Example**

```gml
//TODO lol
```

<!-- tabs:end -->

&nbsp;

## …axis_threshold_get

`input_axis_threshold_get(axis, [playerIndex])`

<!-- tabs:start -->

#### **Description**

**Returns:** A struct with two member variables, `.mini` and `.maxi`, containing the minimum and maximum thresholds

|Name           |Datatype|Purpose                                             |
|---------------|--------|----------------------------------------------------|
|`axis`         |real    |[Gamepad axis](https://manual.yoyogames.com/#t=GameMaker_Language%2FGML_Reference%2FGame_Input%2FGamePad_Input%2FGamepad_Input.htm) to target|
|`[playerIndex]`|integer |Player to target. If not specified, player 0 is used|

If the axis does not have a threshold definition (as set by `input_axis_threshold_set()`) when this function is called then a new definition is created using `INPUT_DEFAULT_MIN_THRESHOLD` and `INPUT_DEFAULT_MAX_THRESHOLD`.

#### **Example**

```gml
//TODO lol
```

<!-- tabs:end -->

&nbsp;

## …accessibility_global_toggle_set

`input_accessibility_global_toggle_set(state)`

<!-- tabs:start -->

#### **Description**

**Returns:** N/A (`undefined`)

|Name   |Datatype|Purpose                                                     |
|-------|--------|------------------------------------------------------------|
|`state`|boolean |Whether to allow momentary toggles across the project at all|

#### **Example**

```gml
//TODO lol
```

<!-- tabs:end -->

&nbsp;

## …accessibility_global_toggle_get

`input_accessibility_global_toggle_get()`

<!-- tabs:start -->

#### **Description**

**Returns:** Boolean, whether momentary toggle behaviour is allowed

|Name|Datatype|Purpose|
|----|--------|-------|
|None|        |       |

#### **Example**

```gml
//TODO lol
```

<!-- tabs:end -->

&nbsp;

## …accessibility_verb_toggle_set

`input_accessibility_verb_toggle_set(verb, state)`

<!-- tabs:start -->

#### **Description**

**Returns:** N/A (`undefined`)

|Name   |Datatype|Purpose                                         |
|-------|--------|------------------------------------------------|
|`verb` |string  |Name of the [verb](Verbs-and-Bindings) to target|
|`state`|boolean |Whether to enable toggling for the verb         |

#### **Example**

```gml
//TODO lol
```

<!-- tabs:end -->

&nbsp;

## …accessibility_verb_toggle_get

`input_accessibility_verb_toggle_get(verb)`

<!-- tabs:start -->

#### **Description**

**Returns:** Boolean, whether momentary toggle behaviour is enabled for the verb

|Name  |Datatype|Purpose                                         |
|------|--------|------------------------------------------------|
|`verb`|string  |Name of the [verb](Verbs-and-Bindings) to target|

#### **Example**

```gml
//TODO lol
```

<!-- tabs:end -->

&nbsp;

## …accessibility_global_cooldown_set

`input_accessibility_global_cooldown_set(state)`

<!-- tabs:start -->

#### **Description**

**Returns:** N/A (`undefined`)

|Name   |Datatype|Purpose                                                  |
|-------|--------|---------------------------------------------------------|
|`state`|boolean |Whether to allow verb cooldowns across the project at all|

#### **Example**

```gml
//TODO lol
```

<!-- tabs:end -->

&nbsp;

## …accessibility_global_cooldown_get

`input_accessibility_global_cooldown_get()`

<!-- tabs:start -->

#### **Description**

**Returns:** Boolean, whether cooldown behaviour is allowed

|Name|Datatype|Purpose|
|----|--------|-------|
|None|        |       |

#### **Example**

```gml
//TODO lol
```

<!-- tabs:end -->

&nbsp;

## …accessibility_verb_cooldown_set

`input_accessibility_verb_cooldown_set(verb, state)`

<!-- tabs:start -->

#### **Description**

**Returns:** N/A (`undefined`)

|Name   |Datatype|Purpose                                         |
|-------|--------|------------------------------------------------|
|`verb` |string  |Name of the [verb](Verbs-and-Bindings) to target|
|`state`|boolean |Whether to enable cooldown for the verb         |

#### **Example**

```gml
//TODO lol
```

<!-- tabs:end -->

&nbsp;

## …accessibility_verb_cooldown_get

`input_accessibility_verb_cooldown_get(verb)`

<!-- tabs:start -->

#### **Description**

**Returns:** Boolean, whether cooldown behaviour is enabled for the verb

|Name  |Datatype|Purpose                                         |
|------|--------|------------------------------------------------|
|`verb`|string  |Name of the [verb](Verbs-and-Bindings) to target|

#### **Example**

```gml
//TODO lol
```

<!-- tabs:end -->