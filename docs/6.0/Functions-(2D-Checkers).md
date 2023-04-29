# Functions (2D Checkers)

&nbsp;

The functions on this page allow you to check verbs by treating them as 2D vectors. This is helpful for situations where the player is controlling something in two dimensions, such as top-down movement or aiming.

&nbsp;

## …direction

`input_direction(default, verbLeft, verbRight, verbUp, verbDown, [playerIndex], [mostRecent])`

<!-- tabs:start -->

#### **Description**

**Returns:** Number, the direction (in degrees) represented by the sum of the verb values

|Name           |Datatype                  |Purpose                                                     |
|---------------|--------------------------|------------------------------------------------------------|
|`default`      |number                    |Value to return if none of the verbs are active             |
|`verbLeft`     |[verb](Verbs-and-Bindings)|[Verb](Verbs-and-Bindings) that moves the point of aim left |
|`verbRight`    |[verb](Verbs-and-Bindings)|[Verb](Verbs-and-Bindings) that moves the point of aim right|
|`verbUp`       |[verb](Verbs-and-Bindings)|[Verb](Verbs-and-Bindings) that moves the point of aim up   |
|`verbDown`     |[verb](Verbs-and-Bindings)|[Verb](Verbs-and-Bindings) that moves the point of aim down |
|`[playerIndex]`|integer                   |Player to target. If not specified, player 0 is used        |
|`[mostRecent]` |boolean                   |Whether to use the most recent input instead of returning 0 when two verbs conflict. False if unspecified|

#### **Examples**

```gml
//Set sprite rotation to the input direction, defaulting to the last sprite rotation value
image_angle = input_direction(image_angle, "left", "right", "up", "down");
```

```gml
//Get difference between instance direction and most recent input direction for player 0
var _turn = angle_difference(direction, input_direction(direction, "left", "right", "up", "down", 0, true));
```

<!-- tabs:end -->

&nbsp;

## …distance

`input_distance(verbLeft, verbRight, verbUp, verbDown, [playerIndex], [mostRecent])`

<!-- tabs:start -->

#### **Description**

**Returns:** Number, the length of the vector represented by the sum of the verb values

|Name           |Datatype                  |Purpose                                                     |
|---------------|--------------------------|------------------------------------------------------------|
|`verbLeft`     |[verb](Verbs-and-Bindings)|[Verb](Verbs-and-Bindings) that moves the point of aim left |
|`verbRight`    |[verb](Verbs-and-Bindings)|[Verb](Verbs-and-Bindings) that moves the point of aim right|
|`verbUp`       |[verb](Verbs-and-Bindings)|[Verb](Verbs-and-Bindings) that moves the point of aim up   |
|`verbDown`     |[verb](Verbs-and-Bindings)|[Verb](Verbs-and-Bindings) that moves the point of aim down |
|`[playerIndex]`|integer                   |Player to target. If not specified, player 0 is used        |
|`[mostRecent]` |boolean                   |Whether to use the most recent input instead of returning 0 when two verbs conflict. False if unspecified|

#### **Example**

```gml
//Move instance input distance in it's current direction 
var _move_distance = input_distance("left", "right", "up", "down");
if (_move_distance > 0)
{
    x += lengthdir_x(_move_distance, direction);
    y += lengthdir_y(_move_distance, direction);
}
```

<!-- tabs:end -->

&nbsp;

## …x

`input_x(verbLeft, verbRight, verbUp, verbDown, [playerIndex], [mostRecent])`

<!-- tabs:start -->

#### **Description**

**Returns:** Number, the x-coordinate of the vector represented by the sum of the verb values

|Name            |Datatype                  |Purpose                                                     |
|----------------|--------------------------|------------------------------------------------------------|
|`verbLeft`      |[verb](Verbs-and-Bindings)|[Verb](Verbs-and-Bindings) that moves the point of aim left |
|`verbRight`     |[verb](Verbs-and-Bindings)|[Verb](Verbs-and-Bindings) that moves the point of aim right|
|`verbUp`        |[verb](Verbs-and-Bindings)|[Verb](Verbs-and-Bindings) that moves the point of aim up   |
|`verbDown`      |[verb](Verbs-and-Bindings)|[Verb](Verbs-and-Bindings) that moves the point of aim down |
|`[playerIndex]` |integer                   |Player to target. If not specified, player 0 is used        |
|`[mostRecent ]` |boolean                   |Whether to use the most recent input instead of returning 0 when two verbs conflict. False if unspecified|

#### **Example**

```gml
//Move instance according to horizontal input 
x += input_x("left", "right", "up", "down");
```

<!-- tabs:end -->

&nbsp;

## …y

`input_y(verbLeft, verbRight, verbUp, verbDown, [playerIndex], [mostRecent])`

<!-- tabs:start -->

#### **Description**

**Returns:** Number, the y-coordinate of the vector represented by the sum of the verb values

|Name            |Datatype                  |Purpose                                                     |
|----------------|--------------------------|------------------------------------------------------------|
|`verbLeft`      |[verb](Verbs-and-Bindings)|[Verb](Verbs-and-Bindings) that moves the point of aim left |
|`verbRight`     |[verb](Verbs-and-Bindings)|[Verb](Verbs-and-Bindings) that moves the point of aim right|
|`verbUp`        |[verb](Verbs-and-Bindings)|[Verb](Verbs-and-Bindings) that moves the point of aim up   |
|`verbDown`      |[verb](Verbs-and-Bindings)|[Verb](Verbs-and-Bindings) that moves the point of aim down |
|`[playerIndex]` |integer                   |Player to target. If not specified, player 0 is used        |
|`[mostRecent]`  |boolean                   |Whether to use the most recent input instead of returning 0 when two verbs conflict. False if unspecified|

#### **Example**

```gml
//Move instance according to vertical input 
y += input_y("left", "right", "up", "down");
```

<!-- tabs:end -->

&nbsp;

## …xy

`input_xy(verbLeft, verbRight, verbUp, verbDown, [playerIndex], [mostRecent])`

<!-- tabs:start -->

#### **Description**

**Returns:** Struct, the vector represented by the sum of the verb values

|Name            |Datatype                  |Purpose                                                     |
|----------------|--------------------------|------------------------------------------------------------|
|`verbLeft`      |[verb](Verbs-and-Bindings)|[Verb](Verbs-and-Bindings) that moves the point of aim left |
|`verbRight`     |[verb](Verbs-and-Bindings)|[Verb](Verbs-and-Bindings) that moves the point of aim right|
|`verbUp`        |[verb](Verbs-and-Bindings)|[Verb](Verbs-and-Bindings) that moves the point of aim up   |
|`verbDown`      |[verb](Verbs-and-Bindings)|[Verb](Verbs-and-Bindings) that moves the point of aim down |
|`[playerIndex]` |integer                   |Player to target. If not specified, player 0 is used        |
|`[mostRecent]`  |boolean                   |Whether to use the most recent input instead of returning 0 when two verbs conflict. False if unspecified|

The struct returned by this function contains two member variables: `.x` and `.y`.

!> This function returns a `static` struct. Do not keep a permanent reference to this struct! It is liable to change value unexpectedly.

#### **Example**

```gml
//Move instance per horizontal and vertical input 
var _movement_xy = input_x("left", "right", "up", "down");
x += _movement_xy.x;
y += _movement_xy.y;
```

<!-- tabs:end -->

&nbsp;

## …radial_sector

`input_radial_sector(verbLeft, verbRight, verbUp, verbDown, [minAngle], [maxAngle], [minMagnitude], [maxMagnitude], [playerIndex])`

<!-- tabs:start -->

#### **Description**

**Returns:** Boolean, whether the vector represented by the sum of the verb values points to the radial sector indicated by angle and magnitude bounds

|Name            |Datatype                  |Purpose                                                                                                                                 |
|----------------|--------------------------|----------------------------------------------------------------------------------------------------------------------------------------|
|`verbLeft`      |[verb](Verbs-and-Bindings)|[Verb](Verbs-and-Bindings) that moves the point of aim left                                                                             |
|`verbRight`     |[verb](Verbs-and-Bindings)|[Verb](Verbs-and-Bindings) that moves the point of aim right                                                                            |
|`verbUp`        |[verb](Verbs-and-Bindings)|[Verb](Verbs-and-Bindings) that moves the point of aim up                                                                               |
|`verbDown`      |[verb](Verbs-and-Bindings)|[Verb](Verbs-and-Bindings) that moves the point of aim down                                                                             |
|`[minAngle]`    |number                    |Minimum angle for the sector. If not specified, `0` is used                                                                             |
|`[maxAngle]`    |number                    |Maximum angle for the sector. If not specified, `360` is used                                                                           |
|`[minMagnitude]`|number                    |Minimum magnitude for the sector. Must be between `0` (centre of the circle) and `1` (edge of the circle). If not specified, `0` is used|
|`[maxMagnitude]`|number                    |Maximum magnitude for the sector. Must be between `0` (centre of the circle) and `1` (edge of the circle). If not specified, `1` is used|
|`[playerIndex]` |integer                   |Player to target. If not specified, player 0 is used                                                                                    |

#### **Example**

```gml
//Run if the input directional vector points right and has a magnitude of 0.5 or greater
if (input_radial_sector("left", "right", "up", "down", -45, 45, 0.5))
{
    //Run right!
}
```

<!-- tabs:end -->
