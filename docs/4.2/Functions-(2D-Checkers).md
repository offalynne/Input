# Functions (2D Checkers)

---

### `input_x(verbLeft, verbRight, verbUp, verbDown, [playerIndex])`

*Returns:* Real, the x-coordinate of the vector represented by the sum of the verb values

|Name            |Datatype                  |Purpose                                                     |
|----------------|--------------------------|------------------------------------------------------------|
|`verbUp`        |[verb](Alternate-Bindings)|[Verb](Alternate-Bindings) that moves the point of aim up   |
|`verbDown`      |[verb](Alternate-Bindings)|[Verb](Alternate-Bindings) that moves the point of aim down |
|`verbLeft`      |[verb](Alternate-Bindings)|[Verb](Alternate-Bindings) that moves the point of aim left |
|`verbRight`     |[verb](Alternate-Bindings)|[Verb](Alternate-Bindings) that moves the point of aim right|
|`[playerIndex]` |integer                   |Player to target. If not specified, player 0 is used        |

&nbsp;
---
&nbsp;

### `input_y(verbLeft, verbRight, verbUp, verbDown, [playerIndex])`

*Returns:* Real, the y-coordinate of the vector represented by the sum of the verb values

|Name            |Datatype                  |Purpose                                                     |
|----------------|--------------------------|------------------------------------------------------------|
|`verbUp`        |[verb](Alternate-Bindings)|[Verb](Alternate-Bindings) that moves the point of aim up   |
|`verbDown`      |[verb](Alternate-Bindings)|[Verb](Alternate-Bindings) that moves the point of aim down |
|`verbLeft`      |[verb](Alternate-Bindings)|[Verb](Alternate-Bindings) that moves the point of aim left |
|`verbRight`     |[verb](Alternate-Bindings)|[Verb](Alternate-Bindings) that moves the point of aim right|
|`[playerIndex]` |integer                   |Player to target. If not specified, player 0 is used        |

&nbsp;
---
&nbsp;

### `input_xy(verbLeft, verbRight, verbUp, verbDown, [playerIndex])`

*Returns:* Struct, the vector represented by the sum of the verb values

|Name            |Datatype                  |Purpose                                                     |
|----------------|--------------------------|------------------------------------------------------------|
|`verbUp`        |[verb](Alternate-Bindings)|[Verb](Alternate-Bindings) that moves the point of aim up   |
|`verbDown`      |[verb](Alternate-Bindings)|[Verb](Alternate-Bindings) that moves the point of aim down |
|`verbLeft`      |[verb](Alternate-Bindings)|[Verb](Alternate-Bindings) that moves the point of aim left |
|`verbRight`     |[verb](Alternate-Bindings)|[Verb](Alternate-Bindings) that moves the point of aim right|
|`[playerIndex]` |integer                   |Player to target. If not specified, player 0 is used        |

The struct returned by this function contains two member variables: `x` and `y`.

&nbsp;
---
&nbsp;

### `input_direction(verbLeft, verbRight, verbUp, verbDown, [playerIndex])`

*Returns:* Real or `undefined`, the direction (in degrees) represented by the sum of the verb values, or `undefined` if the vector length is below the minimum threshold

|Name            |Datatype                  |Purpose                                                     |
|----------------|--------------------------|------------------------------------------------------------|
|`verbUp`        |[verb](Alternate-Bindings)|[Verb](Alternate-Bindings) that moves the point of aim up   |
|`verbDown`      |[verb](Alternate-Bindings)|[Verb](Alternate-Bindings) that moves the point of aim down |
|`verbLeft`      |[verb](Alternate-Bindings)|[Verb](Alternate-Bindings) that moves the point of aim left |
|`verbRight`     |[verb](Alternate-Bindings)|[Verb](Alternate-Bindings) that moves the point of aim right|
|`[playerIndex]` |integer                   |Player to target. If not specified, player 0 is used        |

**N.B.** If the distance to the point of aim is 0 (after taking into account the minimum threshold) then this function will return `undefined`.

&nbsp;
---
&nbsp;

### `input_distance(verbLeft, verbRight, verbUp, verbDown, [playerIndex])`

*Returns:* Positive real, the length of the vector represented by the sum of the verb values

|Name            |Datatype                  |Purpose                                                     |
|----------------|--------------------------|------------------------------------------------------------|
|`verbUp`        |[verb](Alternate-Bindings)|[Verb](Alternate-Bindings) that moves the point of aim up   |
|`verbDown`      |[verb](Alternate-Bindings)|[Verb](Alternate-Bindings) that moves the point of aim down |
|`verbLeft`      |[verb](Alternate-Bindings)|[Verb](Alternate-Bindings) that moves the point of aim left |
|`verbRight`     |[verb](Alternate-Bindings)|[Verb](Alternate-Bindings) that moves the point of aim right|
|`[playerIndex]` |integer                   |Player to target. If not specified, player 0 is used        |