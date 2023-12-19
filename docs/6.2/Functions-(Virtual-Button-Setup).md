# Functions (Virtual Button Setup)

&nbsp;

Virtual buttons can be configured using the following functions. Many functions return `self` meaning that methods can be chained together as a fluent interface.

?> All coordinates and positions are in GUI-space.

&nbsp;

## .destroy

`<virtual button>.destroy()`

<!-- tabs:start -->

#### **Description**

**Returns:** N/A (`undefined`)

|Name|Datatype|Purpose|
|----|--------|-------|
|None|        |       |

Immediately destroys a virtual button, making it inoperative and any methods for the destroyed virtual button will do nothing.

!> Don't forget to call the .destroy() method on a virtual button. Virtual buttons will persist and need to be manually destroyed to permanently remove them from your game.

#### **Example**

```gml
//Player has reached the end of the level

//Destroy our two virtual buttons for safety
vbutton_jump.destroy();
vbutton_slide.destroy();

//Show the end-game stats screen
show_stats_screen();

```

<!-- tabs:end -->

&nbsp;

## .debug_draw

`<virtual button>.debug_draw()`

<!-- tabs:start -->

#### **Description**

**Returns:** N/A (`undefined`)

|Name|Datatype|Purpose|
|----|--------|-------|
|None|        |       |

Draws simple representations of the virtual button to the screen. This is intended for debug use only.

!> This function should be called in a [Draw GUI event](https://manual.yoyogames.com/The_Asset_Editors/Object_Properties/Draw_Events.htm) for accurate results.

#### **Example**

```gml
//If we're debugging our virtual buttons...
if (DEBUG_ALLOWED && global.debug_vbuttons)
{
	//Then draw them to the screen for easier visualisation
	vbutton_move.debug_draw();
	vbutton_shoot.debug_draw();
	vbutton_reload.debug_draw();
}
```

<!-- tabs:end -->

&nbsp;

## .rectangle

`<virtual button>.rectangle(left, top, right, bottom)`

<!-- tabs:start -->

#### **Description**

**Returns:** `self`

|Name    |Datatype|Purpose                         |
|--------|--------|--------------------------------|
|`left`  |number  |Left position of the rectangle  |
|`top`   |number  |Top position of the rectangle   |
|`right` |number  |Right position of the rectangle |
|`bottom`|number  |Bottom position of the rectangle|

Sets the shape of the virtual button to a rectangle.

#### **Example**

```gml
//Set up some temporary variables for readability
var _width  = display_get_gui_width()/4;
var _right  = display_get_gui_width();
var _bottom = display_get_gui_height();

//Create two buttons at the bottom corners of the screen for navigation
//We *don't* define a verb for these so we'll have to directly check them with .pressed() etc.
vbutton_next_page = input_virtual_create().rectangle(0, 400, _width, _bottom);
vbutton_prev_page = input_virtual_create().rectangle(_right - _width, 400, _right, _bottom);
```

<!-- tabs:end -->

&nbsp;

## .circle

`<virtual button>.circle(x, y, radius)`

<!-- tabs:start -->

#### **Description**

**Returns:** `self`

|Name    |Datatype|Purpose                                 |
|--------|--------|----------------------------------------|
|`x`     |number  |x-coordinate of the centre of the circle|
|`y`     |number  |y-coordinate of the centre of the circle|
|`radius`|number  |Radius of the circle                    |

Sets the shape of the virtual button to a circle.

#### **Example**

```gml
var _width  = display_get_gui_width();
var _height = display_get_gui_height();

//Create a virtual button that the player can tap to consent to the data privacy policy
vbutton_consent = input_virtual_create().button("accept").circle(0.5*_width, 0.7*_height, 150);
```

<!-- tabs:end -->

&nbsp;

## .get_position

`<virtual button>.get_position()`

<!-- tabs:start -->

#### **Description**

**Returns:** Struct, see below

|Name|Datatype|Purpose|
|----|--------|-------|
|None|        |       |

The struct returned from this method has the following member variables:

|Name     |Datatype|Purpose                                                                |
|---------|--------|-----------------------------------------------------------------------|
|`.left`  |number  |Left position of the bounding box                                      |
|`.top`   |number  |Top position of the bounding box                                       |
|`.right` |number  |Right position of the bounding box                                     |
|`.bottom`|number  |Bottom position of the bounding box                                    |
|`.width` |number  |Width of the bounding box                                              |
|`.height`|number  |Height of the bounding box                                             |
|`.x`     |number  |x-coordinate of the centre of the button                               |
|`.y`     |number  |y-coordinate of the centre of the button                               |
|`.radius`|number  |Radius of the circle. This value is `undefined` for rectangular buttons|

#### **Example**

```gml
//Get the location of the button on the screen
var _position = vbutton_back.get_position();

//Change the sprite depending on whether it's being pressed or not
var _held = vbutton_back.check();

//Draw the button
draw_sprite(spr_button_back, _held, _position.x, _position.y);
```

<!-- tabs:end -->

&nbsp;

## .button

`<virtual button>.button(clickVerb)`

<!-- tabs:start -->

#### **Description**

**Returns:** `self`

|Name       |Datatype|Purpose                            |
|-----------|--------|-----------------------------------|
|`clickVerb`|string  |Verb to bind clicking the button to|

Binds the virtual button to a basic Input verb. Pressing the button will also "press" the verb.

#### **Example**

```gml
//Set up some size parameters for our quickslot buttons
var _button_width = 30;
var _button_gap = 10;

//Calculate the starting x-coordinate for the buttons
//This will ensure that they're spread out across the width of the screen, and centred
var _x = 0.5*display_get_gui_width();
_x -= (QUICK_SLOT_COUNT - 1)*(_button_width + _button_gap);

//Create an array to hold our quick slots
vbutton_quick = array_create(QUICK_SLOT_COUNT);

//Iterate over each quick slot...
for(var _i = 0; _i < QUICK_SLOT_COUNT; _i++)
{
	//And create a button for it
	vbutton_quick[_i] = input_virtual_create()
	                    .button("quick_slot_" + string(_i));
	                    .circle(_x, y, _button_width);

	//Find the position of the next button
    _x += _button_width + _button_gap;
}
```

<!-- tabs:end -->

&nbsp;

## .hpad

`<virtual button>.hpad(clickVerb, leftVerb, rightVerb)`

<!-- tabs:start -->

#### **Description**

**Returns:** `self`

|Name       |Datatype|Purpose                                                                                                    |
|-----------|--------|-----------------------------------------------------------------------------------------------------------|
|`clickVerb`|string  |Verb to bind clicking the button to                                                                        |
|`leftVerb` |string  |Verb to bind touching the left of the button to                                                            |
|`rightVerb`|string  |Verb to bind touching the right of the button to                                                           |

Binds the virtual button to a set of basic Input verbs, one for each direction on the horizontal axis and an extra one for touching the hpad at all. Verbs are triggered as **digital**, meaning that verbs are either on or off without values in between.

#### **Example**

```gml
//Treat the bottom of the GUI as a reference point
var _bottom = display_get_gui_height();

//Make a horizontal dpad (hpad) that moves left or right
vbutton_hpad = input_virtual_create()
               .rectangle(100, _bottom - 200, 200, _bottom - 100)
               .hpad(undefined, "left", "right");
```

<!-- tabs:end -->

&nbsp;

## .vpad

`<virtual button>.vpad(clickVerb, upVerb, downVerb)`

<!-- tabs:start -->

#### **Description**

**Returns:** `self`

|Name       |Datatype|Purpose                                                                                                    |
|-----------|--------|-----------------------------------------------------------------------------------------------------------|
|`clickVerb`|string  |Verb to bind clicking the button to                                                                        |
|`upVerb`   |string  |Verb to bind touching the top of the button to                                                             |
|`downVerb` |string  |Verb to bind touching the bottom of the to                                                                 |

Binds the virtual button to a set of basic Input verbs, one for each direction on the vertical axis and an extra one for touching the hpad at all. Verbs are triggered as **digital**, meaning that verbs are either on or off without values in between.

#### **Example**

```gml
//Treat the bottom of the GUI as a reference point
var _bottom = display_get_gui_height();

//Make a vertical dpad (vpad) that moves up or down
vbutton_vpad = input_virtual_create()
               .rectangle(100, _bottom - 200, 200, _bottom - 100)
               .vpad(undefined, "up", "down");
```

<!-- tabs:end -->

&nbsp;

## .dpad

`<virtual button>.dpad(clickVerb, leftVerb, rightVerb, upVerb, downVerb, [4dir])`

<!-- tabs:start -->

#### **Description**

**Returns:** `self`

|Name       |Datatype|Purpose                                                                                                    |
|-----------|--------|-----------------------------------------------------------------------------------------------------------|
|`clickVerb`|string  |Verb to bind clicking the button to                                                                        |
|`leftVerb` |string  |Verb to bind touching the left of the button to                                                            |
|`rightVerb`|string  |Verb to bind touching the right of the button to                                                           |
|`upVerb`   |string  |Verb to bind touching the top of the button to                                                             |
|`downVerb` |string  |Verb to bind touching the bottom of the to                                                                 |
|`[4dir]`   |boolean |Whether the dpad should be limited to 4 directions only. Defaults to `false`, allowing 8-directional output|

Binds the virtual button to a set of basic Input verbs, one for each direction and an extra one for touching the dpad at all. Verbs are triggered as **digital**, meaning that verbs are either on or off without values in between.

By default, a dpad-type virtual button can trigger one or two verbs at once (left, right+up etc.) allowing for 8-directional output. Set `4dir` to `true` to restrict output to 4 directions only.

#### **Example**

```gml
//Treat the bottom of the GUI as a reference point
var _bottom = display_get_gui_height();

//Make a 4-dir dpad
vbutton_dpad = input_virtual_create()
               .rectangle(100, _bottom - 200, 200, _bottom - 100)
               .dpad(undefined, "left", "right", "up", "down", true);
```

<!-- tabs:end -->

&nbsp;

## .thumbstick

`<virtual button>.thumbstick(clickVerb, leftVerb, rightVerb, upVerb, downVerb)`

<!-- tabs:start -->

#### **Description**

**Returns:** `self`

|Name       |Datatype|Purpose                                                                                                    |
|-----------|--------|-----------------------------------------------------------------------------------------------------------|
|`clickVerb`|string  |Verb to bind clicking the button to                                                                        |
|`leftVerb` |string  |Verb to bind touching the left of the button to                                                            |
|`rightVerb`|string  |Verb to bind touching the right of the button to                                                           |
|`upVerb`   |string  |Verb to bind touching the top of the button to                                                             |
|`downVerb` |string  |Verb to bind touching the bottom of the to                                                                 |

Binds the virtual button to a set of basic Input verbs, one for each direction and an extra one for touching the virtual button at all. Verbs are triggered as **analogue**, meaning that verbs will be sent values from `0` to `1` as a hardware thumbstick would.

#### **Example**

```gml
//Treat the bottom of the GUI as a reference point
var _bottom = display_get_gui_height();

//Make a thumbstick that follows the player finger around
vbutton_thumbstick = input_virtual_create()
                     .circle(150, _bottom - 150, 100)
                     .thumbstick(undefined, "left", "right", "up", "down")
                     .follow(true)
                     .release_behavior(INPUT_VIRTUAL_RELEASE.RESET_POSITION);
```

<!-- tabs:end -->

&nbsp;

## .touchpad

`<virtual button>.touchpad(clickVerb, leftVerb, rightVerb, upVerb, downVerb)`

<!-- tabs:start -->

#### **Description**

**Returns:** `self`

|Name         |Datatype|Purpose                                                                                                    |
|-------------|--------|-----------------------------------------------------------------------------------------------------------|
|`clickVerb`  |string  |Verb to bind clicking the button to                                                                        |
|`leftVerb`   |string  |Verb to bind touching the left of the button to                                                            |
|`rightVerb`  |string  |Verb to bind touching the right of the button to                                                           |
|`upVerb`     |string  |Verb to bind touching the top of the button to                                                             |
|`downVerb`   |string  |Verb to bind touching the bottom of the to                                                                 |

Binds the virtual button to a set of basic Input verbs, one for each direction and an extra one for touching the virtual button at all. Verbs are triggered as **analogue** and **normalized**, meaning that verbs will be sent values from `0` to `1` based on the speed of movement of the touch point (the player's finger).

The sensitivity of a touchpad is controlled by setting the threshold for the virtual button using `.threshold()`. A higher maximum threshold will *reduce* the sensitivity of the touchpad whereas a lower maximum threshold will *increase* the sensitivity of the touchpad. Additionally, increasing the minimum threshold will filter out more "jitter" from noisy hardware or the player's finger moving slightly.

!> Make sure you set an appropriate threshold using `.threshold()` or the touchpad may appear to be non-functional. Good threshold values to start with are a minimum of `1` and a maximum of `20`.

?> Touchpad behaviour overrides any option set by `.reference_point()`.

#### **Example**

```gml

```

<!-- tabs:end -->

&nbsp;

## .get_type

`<virtual button>.get_type()`

<!-- tabs:start -->

#### **Description**

**Returns:** Member of the `INPUT_VIRTUAL_TYPE` enum, what type of virtual button this is

|Name|Datatype|Purpose|
|----|--------|-------|
|None|        |       |

The `INPUT_VIRTUAL_TYPE` enum contains the following elements:

|Name         |Purpose                                                                              |
|-------------|-------------------------------------------------------------------------------------|
|`.BUTTON`    	   |Virtual button bindings set by `.button()`                                      |
|`.DPAD_HORIZONTAL`|Virtual button bindings set by `.hpad()`                                        |
|`.DPAD_VERTICAL`  |Virtual button bindings set by `.vpad()`                                        |
|`.DPAD_8DIR` 	   |Virtual button bindings set by `.dpad()` with the `4dir` argument set to `false`|
|`.DPAD_4DIR` 	   |Virtual button bindings set by `.dpad()` with the `4dir` argument set to `true` |
|`.THUMBSTICK`	   |Virtual button bindings set by `.thumbstick()`                                  |
|`.TOUCHPAD`	   |Virtual button bindings set by `.touchpad()`                                    |

#### **Example**

```gml
//If we're in debug mode...
if (debug_mode)
{
	//Show a different debug string for this button depending on its type
	var _position = vbutton_movement.get_position();
	with(vbutton_movement.get_type())
	{
		case INPUT_VIRTUAL_TYPE.BUTTON:
			draw_text(_position.x + 10, _position.y, "button");
		break;

		case INPUT_VIRTUAL_TYPE.DPAD_8DIR:
			draw_text(_position.x + 10, _position.y, "dpad");
		break;

		case INPUT_VIRTUAL_TYPE.DPAD_4DIR:
			draw_text(_position.x + 10, _position.y, "dpad (4dir)");
		break;

		case INPUT_VIRTUAL_TYPE.THUMBSTICK:
			draw_text(_position.x + 10, _position.y, "thumbstick");
		break;
	}
}
```

<!-- tabs:end -->

&nbsp;

## .get_verbs

`<virtual button>.get_verbs()`

<!-- tabs:start -->

#### **Description**

**Returns:** Struct, the verb bindings for the virtual button

|Name|Datatype|Purpose|
|----|--------|-------|
|None|        |       |

The struct returned from this method has the following member variables:

|Name    |Datatype|Purpose                                                    |
|--------|--------|-----------------------------------------------------------|
|`.click`|string  |Verb bound to touching the virtual button at all           |
|`.left` |string  |Verb bound to touching the virtual button on the left side |
|`.right`|string  |Verb bound to touching the virtual button on the right side|
|`.up`   |string  |Verb bound to touching the virtual button on the up side   |
|`.down` |string  |Verb bound to touching the virtual button on the down side |

#### **Example**

```gml
//If we're in debug mode and touch the movement virtual button...
if (debug_mode && vbutton_movement.pressed())
{
	//Then spit out a list of verbs that are assigned to the button
	show_debug_message("Pressed virtual button with verbs: " + string(vbutton_movement.get_verbs()));
}
```

<!-- tabs:end -->
