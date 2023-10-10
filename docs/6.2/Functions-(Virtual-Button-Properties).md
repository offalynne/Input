# Functions (Virtual Button Properties)

&nbsp;

Virtual buttons can be configured using the following functions. Many functions return `self` meaning that methods can be chained together as a fluent interface.

&nbsp;

## .reference_point(option)

`<virtual button>.reference_point(option)`

<!-- tabs:start -->

#### **Description**

**Returns:** `self`

|Name    |Datatype                      |Purpose|
|--------|------------------------------|-------|
|`option`|`INPUT_VIRTUAL_REFERENCE` enum|       |

The `INPUT_VIRTUAL_REFERENCE` enum contains the following elements:

|Name          |Purpose                                                                         |
|--------------|--------------------------------------------------------------------------------|
|`.CENTER`     |Default setting. Reference point is the centre of the virtual button            |
|`.TOUCH_POINT`|Reference point is the place where the player first touched the virtual button  |
|`.DELTA`      |Reference point is the place where the player touch the virtual button last step|

#### **Example**

```gml

```

<!-- tabs:end -->

&nbsp;

## .get_reference_point

`<virtual button>.get_reference_point()`

<!-- tabs:start -->

#### **Description**

**Returns:** Member of the `INPUT_VIRTUAL_REFERENCE` enum

|Name|Datatype|Purpose|
|----|--------|-------|
|None|        |       |

#### **Example**

```gml

```

<!-- tabs:end -->

&nbsp;

## .threshold

`<virtual button>.threshold(min, max)`

<!-- tabs:start -->

#### **Description**

**Returns:** `self`

|Name |Datatype|Purpose                |
|-----|--------|-----------------------|
|`min`|number  |Minimum threshold value|
|`max`|number  |Maximum threshold value|

?> This method is only relevant for dpad- and thumbstick-type virtual buttons.

#### **Example**

```gml
//Set the threshold of the thumbstick virtual button based on a sensitivity mode
switch(sensitivity_mode)
{
	case 0: vb_thumbstick.threshold(0.3, 1.0); break;
	case 1: vb_thumbstick.threshold(0.4, 0.9); break;
	case 2: vb_thumbstick.threshold(0.5, 0.8); break;
}
```

<!-- tabs:end -->

&nbsp;

## .get_threshold

`<virtual button>.get_threshold()`

<!-- tabs:start -->

#### **Description**

**Returns:** Struct, containing the minimum and maximum thresholds

|Name|Datatype|Purpose|
|----|--------|-------|
|None|        |       |

The struct returned from this method has the following member variables:

|Name   |Datatype|Purpose                |
|-------|--------|-----------------------|
|`.mini`|number  |Minimum threshold value|
|`.maxi`|number  |Maximum threshold value|

#### **Example**

```gml
var _struct = vb_thumbstick.get_threshold();

if (vb_threshold_min_decr.pressed()) _struct.min = max(0, _struct.min - 0.1);
if (vb_threshold_min_incr.pressed()) _struct.min = min(1, _struct.min + 0.1, _struct.max - 0.1);

if (vb_threshold_max_decr.pressed()) _struct.min = max(0, _struct.min + 0.1, _struct.max - 0.1);
if (vb_threshold_max_incr.pressed()) _struct.min = min(1, _struct.max + 0.1);

vb_thumbstick.threshold(_struct.min, _struct.max);
```

<!-- tabs:end -->

&nbsp;

## .active

`<virtual button>.active(state)`

<!-- tabs:start -->

#### **Description**

**Returns:** `self`

|Name   |Datatype|Purpose                            |
|-------|--------|-----------------------------------|
|`state`|boolean |Active state for the virtual button|

When a virtual button's active state is set to `false`, it will immediately stop responding to player input, including any current input.

#### **Example**

```gml
if (input_check_pressed("pause"))
{
	//If the player's pressed the PAUSE button, flip the pause state
	global.paused = not global.paused;

	//Set the main gameplay virtual buttons to the opposite of the pause state
	var _vb_active = not global.paused;
	vb_thumbstick.active(_vb_active);
	vb_accept.active(_vb_active);
	vb_cancel.active(_vb_active);

	//Handle pause menu presence
	if (global.paused)
	{
		instance_create_layer(0, 0, "GUI", obj_pause);
	}
	else
	{
		with(obj_pause_menu) instance_destroy();
	}
}
```

<!-- tabs:end -->

&nbsp;

## .get_active

`<virtual button>.get_active()`

<!-- tabs:start -->

#### **Description**

**Returns:** Boolean, whether the virtual button is active

|Name|Datatype|Purpose|
|----|--------|-------|
|None|        |       |

#### **Example**

```gml
//Draw the "accept" virtual button, but only if it's active
if (vb_accept.get_active())
{
	var _position = vb_accept.get_position();
	draw_sprite(spr_vb_accept, 0, _position.x, _position.y);
}
```

<!-- tabs:end -->

&nbsp;

## .priority

`<virtual button>.priority(priority)`

<!-- tabs:start -->

#### **Description**

**Returns:** `self`

|Name      |Datatype|Purpose                                |
|----------|--------|---------------------------------------|
|`priority`|number  |Capture priority for the virtual button|

#### **Example**

```gml
//Create a pause button in the top-right corner of the screen
//We give it a high priority to ensure nothing can overlap it
vb_pause = input_virtual_create()
           .rectangle(room_width-40, 10, room_width-10, 40)
           .button("pause")
           .priority(100);
```

<!-- tabs:end -->

&nbsp;

## .get_priority

`<virtual button>.get_priority()`

<!-- tabs:start -->

#### **Description**

**Returns:** Number, the priority of the virtual button

|Name|Datatype|Purpose|
|----|--------|-------|
|None|        |       |

#### **Example**

```gml
//If we're in debug mode, draw the priority of the cancel button
//This is useful to check value are what we expect them to be
if (debug_mode)
{
	var _position = vb_cancel.get_position();
	draw_text(_position.x, _position.y - 30, "depth=" + string(vb_cancel.get_priority()));
}
```

<!-- tabs:end -->

&nbsp;

## .follow

`<virtual button>.follow(state)`

<!-- tabs:start -->

#### **Description**

**Returns:** `self`

|Name   |Datatype|Purpose                                                         |
|-------|--------|----------------------------------------------------------------|
|`state`|boolean |Whether the virtual button should move to follow the touch point|

?> As the follow state moves the virtual button around, you may want to call `.release_behavior()` to control how a virtual button reacts when released (including resetting the position of the button).

#### **Example**

```gml
if (vb_screen.pressed())
{
	//Create a virtual button to track player movement when touching the screen
	//We use the screen virtual button here so that other button can take priority

	//Create a simple circular button
	vb_follow = input_virtual_create()
	            .circle(vb_screen.get_touch_x(), vb_screen.get_touch_y(), 20);

    //Choose a priority higher than the screen button so we always take priority
	vb_follow.priority(vb_screen.get_priority() + 1)

	//Set this new button to follow the player's finger around
	vb_follow.follow(true);

	//When released, destroy this button completely
	vb_follow.release_behavior(INPUT_VIRTUAL_RELEASE.DESTROY);
}
```

<!-- tabs:end -->

&nbsp;

## .get_follow

`<virtual button>.get_follow()`

<!-- tabs:start -->

#### **Description**

**Returns:** Boolean, whether the virtual button is following the touch point

|Name|Datatype|Purpose|
|----|--------|-------|
|None|        |       |

#### **Example**

```gml
//Draw the "switch weapon" button
var _position = vb_switch_weapon.get_position();
draw_sprite(spr_vb_switch_weapon, 0, _position.x, _position.y);

//If we're in customisation mode and this button is following a touchpoint...
if (global.customise_layout && vb_switch_weapon.get_follow()
{
	//Then flash an overlay sprite over the button
	if ((current_time mod 400) < 200)
	{
		draw_sprite_ext(spr_vb_switch_weapon, 0, _position.x, _position.y, 1.2, 1.2, 0, c_yellow, 0.4);
	}
}
```

<!-- tabs:end -->

&nbsp;

## .release_behavior

`<virtual button>.release_behavior(option)`

<!-- tabs:start -->

#### **Description**

**Returns:** `self`

|Name   |Datatype                    |Purpose|
|-------|----------------------------|-------|
|`option`|`INPUT_VIRTUAL_RELEASE` enum|       |

The `INPUT_VIRTUAL_RELEASE` enum contains the following elements:

|Name             |Purpose                                                                         |
|-----------------|--------------------------------------------------------------------------------|
|`.DO_NOTHING`    |Default setting. Does nothing!                                                  |
|`.DESTROY`       |Destroys the virtual button when released. This is useful for ad hoc thumbsticks|
|`.RESET_POSITION`|Resets the position of the button to where it was created when released         |

#### **Example**

```gml
//Create an array of balloons that the player can touch to pop
//The balloons will block other inputs until they're popped

vb_balloon_array = [];

var _i = 0;
repeat(20)
{
	//Choose a random position around the centre of the screen
	var _x = room_width/2  + irandom_range(-300, 300);
	var _y = room_height/2 + irandom_range(-300, 300);

	//Create the balloon virtual buttons
	//We use a high priority here to block most other virtual buttons
	vb_balloon_array[@ _i] = input_virtual_create()
                             .circle(_x, _y, 80)
                             .release_behavior(INPUT_VIRTUAL_RELEASE.DESTROY)
                             .priority(10);
    ++_i;
}
```

<!-- tabs:end -->

&nbsp;

## .get_release_behavior

`<virtual button>.get_release_behavior()`

<!-- tabs:start -->

#### **Description**

**Returns:** Member of the `INPUT_VIRTUAL_RELEASE` enum

|Name|Datatype|Purpose|
|----|--------|-------|
|None|        |       |

#### **Example**

```gml
//If we're in debug mode...
if (debug_mode)
{
	//Then show some extra information about the "lootable" virtual button
	var _position = vb_lootable.get_position();
	draw_text(_position.x, _position.y, "rel bhv=" + string(vb_resume.get_release_behavior()));
}
```

<!-- tabs:end -->

&nbsp;

## .first_touch_only

`<virtual button>.first_touch_only(state)`

<!-- tabs:start -->

#### **Description**

**Returns:** `self`

|Name   |Datatype|Purpose                                                                    |
|-------|--------|---------------------------------------------------------------------------|
|`state`|boolean |Whether the virtual button should only try to capture the first touch point|

On devices that support multiple touch points (typically mobile phones), setting this behavior to `true` will filter out any touch points after the first one. This is useful for preventing multiple touches on a menu.

On devices that do not support multiple touch points, this function will not change any behavior.

#### **Example**

```gml
//Create a virtual button for each button in our menu content array

var _i = 0;
repeat(array_length(menu_content_array))
{
	var _content = menu_content_array[_i];
	if (_content.is_button)
	{
		//Use the .first_touch_only() feature to remove the potential for misclicks
		_content.virtual_button = input_virtual_create()
		                          .rectangle(_content.left, _content.top, _content.right, _content.bottom)
		                          .first_touch_only(true);
	}

	++_i;
}
```

<!-- tabs:end -->

&nbsp;

## .get_first_touch_only

`<virtual button>.get_first_touch_only()`

<!-- tabs:start -->

#### **Description**

**Returns:** Boolean, whether the virtual button will respond to the first touch only

|Name|Datatype|Purpose|
|----|--------|-------|
|None|        |       |

#### **Example**

```gml
//If we're in debug mode...
if (debug_mode)
{
	//Then show some extra information about the "resume" virtual button
	var _position = vb_resume.get_position();
	draw_text(_position.right + 10, _position.y, "FTO=" + string(vb_resume.get_first_touch_only()));
}
```

<!-- tabs:end -->
