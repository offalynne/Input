# Functions (Combo Parameters)

&nbsp;

Combo parameters are global and affect all players across all verbs. You should call either `input_combo_params_set_side_on()` or `input_combo_params_set_top_down()` once at the start of your game to configure Input to meet your needs.

&nbsp;

## …combo_params_set_side_on

`input_combo_params_set_side_on(forwardVerb, backwardVerb, referenceDirection)`

<!-- tabs:start -->

#### **Description**

**Returns:** N/A (`undefined`)

|Name                |Datatype|Purpose                                          |
|--------------------|--------|-------------------------------------------------|
|`forwardVerb`       |verb    |Verb to use to indicate the forward direction    |
|`backwardVerb`      |verb    |Verb to use to indicate the backward direction   |
|`referenceDirection`|number  |Game world angle to use for the forward direction|

#### **Example**

```gml
//Set up combos such that "left" is considered the "forward" direction
//To correctly line up results from input_combo_get_direction() with the game world, use 180 as the reference direction
input_combo_params_set_side_on("left", "right", 180);
```

<!-- tabs:end -->

&nbsp;

## …combo_params_set_top_down

`input_combo_params_set_top_down(forwardVerb, counterclockwiseVerb, backwardVerb, clockwiseVerb, referenceDirection)`

<!-- tabs:start -->

#### **Description**

**Returns:** N/A (`undefined`)

|Name                  |Datatype|Purpose                                                 |
|----------------------|--------|--------------------------------------------------------|
|`forwardVerb`         |verb    |Verb to use to indicate the forward direction           |
|`counterclockwiseVerb`|verb    |Verb to use to indicate the counter-clockwise direction |
|`backwardVerb`        |verb    |Verb to use to indicate the backward direction          |
|`clockwiseVerb`       |verb    |Verb to use to indicate the clockwise direction         |
|`referenceDirection`  |number  |Game world angle to use for the forward direction       |

#### **Example**

```gml
//Set up combos to interpret the right-hand direction as "forwards"
input_combo_params_set_top_down("right", "up", "left", "down", 0);
```

<!-- tabs:end -->

&nbsp;

## …combo_params_get

`input_combo_params_get()`

<!-- tabs:start -->

#### **Description**

**Returns:** Struct, see below

|Name|Datatype|Purpose|
|----|--------|-------|
|None|        |       |

Returns the current combo parameters as a struct. The struct contains the following member variables:

|Variable               |Datatype|Purpose                                                                  |
|-----------------------|--------|-------------------------------------------------------------------------|
|`reset`                |boolean |Whether the combo parameters have been reset i.e. blank/invalid          |
|`side_on`              |boolean |Whether the side-on mode (`true`) or top-down mode (`false`) has been set|
|`forward_verb`         |verb    |Name of the verb for the forward direction                               |
|`counterclockwise_verb`|verb    |Name of the verb for the counter-clockwise direction, if applicable      |
|`backward_verb`        |verb    |Name of the verb for the forward direction                               |
|`clockwise_verb`       |verb    |Name of the verb for the clockwise direction, if applicable              |
|`reference_direction`  |number  |Reference angle for the forward direction                                |

<!-- tabs:end -->

&nbsp;

## …combo_params_reset

`input_combo_params_reset()`

<!-- tabs:start -->

#### **Description**

**Returns:** N/A (`undefined`)

|Name|Datatype|Purpose|
|----|--------|-------|
|None|        |       |

Resets combo parameters entirely. This will force all combos defined as "directional" to be evaluated non-directional until `input_combo_params_set_side_on()` or `input_combo_params_set_top_down()` are called.

Honestly, I'm not sure what the use case is for this function is but it exists if you need it.

<!-- tabs:end -->