# Functions (Combo Getters)

&nbsp;

The functions on this page allow you to access specific values associated with combos.

?> You can and should check for the completion of a combo using the standard [verb checkers](Functions-(Checkers)).

&nbsp;

## …combo_reset

`input_combo_reset(comboName, [playerIndex=0])`

<!-- tabs:start -->

#### **Description**

**Returns:** N/A (`undefined`)

|Name           |Datatype|Purpose                                             |
|---------------|--------|----------------------------------------------------|
|`comboName`    |string  |Name of the combo to target                         |
|`[playerIndex]`|integer |Player to target. If not specified, player 0 is used|

You may use GML keyword `all` to reset all combos for a player.

#### **Example**

```gml
if (input_check_pressed("pause"))
{
	//Make sure all combos are fully reset if we pause the game
	input_combo_reset(all);

	instance_create_depth(0, 0, 0, obj_pause_menu);
}
```

<!-- tabs:end -->

&nbsp;

## …combo_get_phase_count

`input_combo_get_phase_count(comboName)`

<!-- tabs:start -->

#### **Description**

**Returns:** Integer, the number of phases in the combo definition

|Name       |Datatype|Purpose                    |
|-----------|--------|---------------------------|
|`comboName`|string  |Name of the combo to target|

#### **Example**

```gml
//Form a string to show what phase the "fireball" combo is in
//This'll help the player learn the combo step by step

var _string = "Phase "
            + string(input_combo_get_phase("fireball"))
            + " of "
            + string(input_combo_get_phase_count("fireball"));

draw_text(10, 10, _string);
```

<!-- tabs:end -->

&nbsp;

## …combo_get_phase

`input_combo_get_phase(comboName, [playerIndex=0])`

<!-- tabs:start -->

#### **Description**

**Returns:** Integer, which phase the player is currently waiting to complete

|Name           |Datatype|Purpose                                             |
|---------------|--------|----------------------------------------------------|
|`comboName`    |string  |Name of the combo to target                         |
|`[playerIndex]`|integer |Player to target. If not specified, player 0 is used|

#### **Example**

```gml
var _phase = input_combo_get_phase("yanling");
if (_phase >= 3)
{
	//Calculate the number of particles we should create
	//As the "yanling" combo proceeds we'll create more particles
	var _density = (_phase - 2)*3;
	pfx_fire_generate(x, y, _density);
}
```

<!-- tabs:end -->

&nbsp;

## …combo_get_new_phase

`input_combo_get_new_phase(comboName, [playerIndex=0])`

<!-- tabs:start -->

#### **Description**

**Returns:** Boolean, whether a new phase was entered this step

|Name           |Datatype|Purpose                                             |
|---------------|--------|----------------------------------------------------|
|`comboName`    |string  |Name of the combo to target                         |
|`[playerIndex]`|integer |Player to target. If not specified, player 0 is used|

This function will return `true` in situations where the phase both increases (which indicates a successful button input) as well as if a phase was failed and the combo is reset.

#### **Example**

```gml
if (input_combo_get_new_phase("hi jump kick"))
{
	if (input_combo_get_phase("hi jump kick") == 3)
	{
		//If we've triggered a jump then swap over to a special sprite
		sprite_index = spr_combo_hjk_special_jump;
	}
}
```

<!-- tabs:end -->

&nbsp;

## …combo_get_charge

`input_combo_get_charge(comboName, [playerIndex=0])`

<!-- tabs:start -->

#### **Description**

**Returns:** Number, the charge time for the most recently encountered charge phase

|Name           |Datatype|Purpose                                             |
|---------------|--------|----------------------------------------------------|
|`comboName`    |string  |Name of the combo to target                         |
|`[playerIndex]`|integer |Player to target. If not specified, player 0 is used|

The units for the returned value is determined by `INPUT_TIMER_MILLISECONDS`.

#### **Example**

```gml
if (input_check_pressed("shockwave aoe"))
{
	var _inst = instance_create_layer(x, y, layer, obj_shockwave);

	if (input_combo_get_charge("shockwave aoe") > 25)
	{
		//If the combo was charged longer than 25 frames, use the bigger collision sprite
		_inst.sprite_index = spr_shockwave_aoe_big;
	}
}
```

<!-- tabs:end -->

&nbsp;

## …combo_get_direction

`input_combo_get_direction(comboName, [playerIndex=0])`

<!-- tabs:start -->

#### **Description**

**Returns:** Number or `undefined`, the determined direction for the combo's execution

|Name           |Datatype|Purpose                                             |
|---------------|--------|----------------------------------------------------|
|`comboName`    |string  |Name of the combo to target                         |
|`[playerIndex]`|integer |Player to target. If not specified, player 0 is used|

#### **Example**

```gml
if (input_check_pressed("fireball"))
{
	var _inst = instance_create_layer(x, y, layer, obj_fireball);
	_inst.direction = input_combo_get_direction("fireball");
}
```

<!-- tabs:end -->