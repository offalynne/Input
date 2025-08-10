# Virtual Buttons

&nbsp;

The following functions are in global scope and can be called anywhere in your game. Virtual buttons themselves are created with `InputVirtualCreate()` - which returns a struct - and should be configured by executing methods on that struct.

?> All coordinates and positions are in GUI-space.

&nbsp;

## …VirtualCreate

`InputVirtualCreate()`

<!-- tabs:start -->

#### **Description**

**Returns:** Struct, an instance of `__InputClassVirtualButton`

|Name|Datatype|Purpose|
|----|--------|-------|
|None|        |       |

Creates a virtual button. Virtual buttons can typically only be used if a player has been assigned the `INPUT_TOUCH` device. Virtual buttons can optionally be set up to respond to mouse input via the `INPUT_KBM` device; please see `INPUT_MOUSE_CAN_USE_VIRTUAL_BUTTONS`. 

#### **Example**

```gml
//Create a rectangular button and bind it to the "accept" verb
vbuttonAccept = InputVirtualCreate()
                .Rectangle(10, 210, 160, 360)
                .Button(INPUT_VERB.ACCEPT);

//Create a circular button and bind it to movement verbs as a virtual "thumbstick"
vbuttonThumbstick = InputVirtualCreate()
                    .Circle(500, 300, 120)
                    .Thumbstick(undefined, INPUT_VERB.LEFT, INPUT_VERB.RIGHT, INPUT_VERB.UP, INPUT_VERB.DOWN);
```

<!-- tabs:end -->

&nbsp;

## …VirtualDebugDraw

`InputVirtualDebugDraw()`

<!-- tabs:start -->

#### **Description**

**Returns:** N/A (`undefined`)

|Name|Datatype|Purpose|
|----|--------|-------|
|None|        |       |

Draws a visualisation aid for virtual buttons. This should be called in a Draw GUI event for accurate results.

#### **Example**

```gml
//Draw virtual buttons to the screen when we're in debug mode
if (debug_mode)
{
    InputVirtualDebugDraw();
}
```

<!-- tabs:end -->

&nbsp;

## …VirtualDestroyAll

`InputVirtualDestroyAll()`

<!-- tabs:start -->

#### **Description**

**Returns:** N/A (`undefined`)

|Name|Datatype|Purpose|
|----|--------|-------|
|None|        |       |

Destroys all virtual buttons.

#### **Example**

```gml
//Remove all virtual buttons if we're using a gamepad
if (InputPlayerUsingGamepad())
{
    InputVirtualDestroyAll();
}
```

<!-- tabs:end -->

&nbsp;

# Virtual Button Setup

&nbsp;

Virtual buttons can be configured using the following functions. Many functions return `self` meaning that methods can be chained together as a fluent interface.

?> All coordinates and positions are in GUI-space.

&nbsp;

## .Destroy

`<virtual button>.Destroy()`

<!-- tabs:start -->

#### **Description**

|Name|Datatype|Purpose|
|----|--------|-------|
|None|        |       |

Immediately destroys a virtual button, making it inoperative and any methods for the destroyed virtual button will do nothing.

!> Don't forget to call the .destroy() method on a virtual button. Virtual buttons will persist and need to be manually destroyed to permanently remove them from your game.

#### **Example**

```gml
//Player has reached the end of the level

//Destroy our two virtual buttons for safety
vbuttonJump.Destroy();
vbuttonSlide.Destroy();

//Show the end-game stats screen
ShowStatsScreen();
```

<!-- tabs:end -->

&nbsp;

## .DebugDraw

`<virtual button>.DebugDraw()`

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
if (DEBUG_ALLOWED && global.debugVbuttons)
{
	//Then draw them to the screen for easier visualisation
	vbuttonMove.DebugDraw();
	vbuttonShoot.DebugDraw();
	vbuttonReload.DebugDraw();
}
```

<!-- tabs:end -->

&nbsp;

## .Rectangle

`<virtual button>.Rectangle(left, top, right, bottom)`

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
vbuttonNextPage = InputVirtualCreate().Rectangle(0, 400, _width, _bottom);
vbuttonPrevPage = InputVirtualCreate().Rectangle(_right - _width, 400, _right, _bottom);
```

<!-- tabs:end -->

&nbsp;

## .Circle

`<virtual button>.Circle(x, y, radius)`

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
vbutton_consent = InputVirtualCreate()
                  .Button(INPUT_VERB.ACCEPT)
                  .Circle(0.5*_width, 0.7*_height, 150);
```

<!-- tabs:end -->

&nbsp;

## .GetPosition

`<virtual button>.GetPosition()`

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
var _position = vbuttonBack.GetPosition();

//Change the sprite depending on whether it's being pressed or not
var _held = vbuttonBack.Check();

//Draw the button
draw_sprite(sButtonBack, _held, _position.x, _position.y);
```

<!-- tabs:end -->

&nbsp;

## .Button

`<virtual button>.Button(verb)`

<!-- tabs:start -->

#### **Description**

**Returns:** `self`

|Name  |Datatype|Purpose                            |
|------|--------|-----------------------------------|
|`verb`|integer |Verb to bind clicking the button to|

Binds the virtual button to a basic Input verb. Pressing the button will also "press" the verb.

#### **Example**

```gml
//Create a virtual button for the quick slot
vbuttonQuick = InputVirtualCreate()
               .Button(INPUT_VERB.QUICK_SLOT);
               .Circle(_x, y, _buttonWidth);
```

<!-- tabs:end -->

&nbsp;

## .HPad

`<virtual button>.HPad(clickVerb, leftVerb, rightVerb)`

<!-- tabs:start -->

#### **Description**

**Returns:** `self`

|Name       |Datatype|Purpose                                         |
|-----------|--------|------------------------------------------------|
|`clickVerb`|integer |Verb to bind clicking the button to             |
|`leftVerb` |integer |Verb to bind touching the left of the button to |
|`rightVerb`|integer |Verb to bind touching the right of the button to|

Binds the virtual button to a set of basic Input verbs, one for each direction on the horizontal axis and an extra one for touching the hpad at all. Verbs are triggered as **digital**, meaning that verbs are either on or off without values in between.

#### **Example**

```gml
//Treat the bottom of the GUI as a reference point
var _bottom = display_get_gui_height();

//Make a horizontal dpad (hpad) that moves left or right
vbuttonHPad = InputVirtualCreate()
              .Rectangle(100, _bottom - 200, 200, _bottom - 100)
              .HPad(undefined, INPUT_VERB.LEFT, INPUT_VERB.RIGHT);
```

<!-- tabs:end -->

&nbsp;

## .VPad

`<virtual button>.VPad(clickVerb, upVerb, downVerb)`

<!-- tabs:start -->

#### **Description**

**Returns:** `self`

|Name       |Datatype|Purpose                                       |
|-----------|--------|----------------------------------------------|
|`clickVerb`|integer |Verb to bind clicking the button to           |
|`upVerb`   |integer |Verb to bind touching the top of the button to|
|`downVerb` |integer |Verb to bind touching the bottom of the to    |

Binds the virtual button to a set of basic Input verbs, one for each direction on the vertical axis and an extra one for touching the hpad at all. Verbs are triggered as **digital**, meaning that verbs are either on or off without values in between.

#### **Example**

```gml
//Treat the bottom of the GUI as a reference point
var _bottom = display_get_gui_height();

//Make a vertical dpad (vpad) that moves up or down
vbuttonVPad = InputVirtualCreate()
              .Rectangle(100, _bottom - 200, 200, _bottom - 100)
              .VPad(undefined, INPUT_VERB.UP, INPUT_VERB.DOWN);
```

<!-- tabs:end -->

&nbsp;

## .DPad

`<virtual button>.DPad(clickVerb, leftVerb, rightVerb, upVerb, downVerb, [4dir])`

<!-- tabs:start -->

#### **Description**

**Returns:** `self`

|Name       |Datatype|Purpose                                                                                                    |
|-----------|--------|-----------------------------------------------------------------------------------------------------------|
|`clickVerb`|integer |Verb to bind clicking the button to                                                                        |
|`leftVerb` |integer |Verb to bind touching the left of the button to                                                            |
|`rightVerb`|integer |Verb to bind touching the right of the button to                                                           |
|`upVerb`   |integer |Verb to bind touching the top of the button to                                                             |
|`downVerb` |integer |Verb to bind touching the bottom of the to                                                                 |
|`[4dir]`   |boolean |Whether the dpad should be limited to 4 directions only. Defaults to `false`, allowing 8-directional output|

Binds the virtual button to a set of basic Input verbs, one for each direction and an extra one for touching the dpad at all. Verbs are triggered as **digital**, meaning that verbs are either on or off without values in between.

By default, a dpad-type virtual button can trigger one or two verbs at once (left, right+up etc.) allowing for 8-directional output. Set `4dir` to `true` to restrict output to 4 directions only.

#### **Example**

```gml
//Treat the bottom of the GUI as a reference point
var _bottom = display_get_gui_height();

//Make a 4-dir dpad
vbuttonDPad = InputVirtualCreate()
              .Rectangle(100, _bottom - 200, 200, _bottom - 100)
              .DPad(undefined, INPUT_VERB.LEFT, INPUT_VERB.RIGHT, INPUT_VERB.UP, INPUT_VERB.DOWN, true);
```

<!-- tabs:end -->

&nbsp;

## .Thumbstick

`<virtual button>.Thumbstick(clickVerb, leftVerb, rightVerb, upVerb, downVerb)`

<!-- tabs:start -->

#### **Description**

**Returns:** `self`

|Name       |Datatype|Purpose                                         |
|-----------|--------|------------------------------------------------|
|`clickVerb`|integer |Verb to bind clicking the button to             |
|`leftVerb` |integer |Verb to bind touching the left of the button to |
|`rightVerb`|integer |Verb to bind touching the right of the button to|
|`upVerb`   |integer |Verb to bind touching the top of the button to  |
|`downVerb` |integer |Verb to bind touching the bottom of the to      |

Binds the virtual button to a set of basic Input verbs, one for each direction and an extra one for touching the virtual button at all. Verbs are triggered as **analogue**, meaning that verbs will be sent values from `0` to `1` as a hardware thumbstick would.

#### **Example**

```gml
//Treat the bottom of the GUI as a reference point
var _bottom = display_get_gui_height();

//Make a thumbstick that follows the player finger around
vbuttonThumbstick = InputVirtualCreate()
                    .Circle(150, _bottom - 150, 100)
                    .Thumbstick(undefined, INPUT_VERB.LEFT, INPUT_VERB.RIGHT, INPUT_VERB.UP, INPUT_VERB.DOWN)
                    .Follow(true)
                    .ReleaseBehavior(INPUT_VIRTUAL_RELEASE.RESET_POSITION);
```

&nbsp;

## .Touchpad

`<virtual button>.Touchpad(clickVerb, leftVerb, rightVerb, upVerb, downVerb)`

<!-- tabs:start -->

#### **Description**

**Returns:** `self`

|Name         |Datatype|Purpose                                         |
|-------------|--------|------------------------------------------------|
|`clickVerb`  |integer |Verb to bind clicking the button to             |
|`leftVerb`   |integer |Verb to bind touching the left of the button to |
|`rightVerb`  |integer |Verb to bind touching the right of the button to|
|`upVerb`     |integer |Verb to bind touching the top of the button to  |
|`downVerb`   |integer |Verb to bind touching the bottom of the to      |

Binds the virtual button to a set of basic Input verbs, one for each direction and an extra one for touching the virtual button at all. Verbs are triggered as **analogue** and **normalized**, meaning that verbs will be sent values from `0` to `1` based on the speed of movement of the touch point (the player's finger).

The sensitivity of a touchpad is controlled by setting the threshold for the virtual button using `.Threshold()`. A higher maximum threshold will *reduce* the sensitivity of the touchpad whereas a lower maximum threshold will *increase* the sensitivity of the touchpad. Additionally, increasing the minimum threshold will filter out more "jitter" from noisy hardware or the player's finger moving slightly.

!> Make sure you set an appropriate threshold using `.Threshold()` or the touchpad may appear to be non-functional. Good threshold values to start with are a minimum of `1` and a maximum of `20`.

?> Touchpad behaviour overrides any option set by `.ReferencePoint()`.

#### **Example**

```gml
//Creat Event
//Define a touchpad vbutton with lower threshold settings for good sensitivity
var _right  = display_get_gui_width();
var _bottom = display_get_gui_height();
vbutton_touchpad = InputVirtualCreate()
                   .Rectangle(_right-200, _bottom-200, _right-50, _bottom-50)
                   .Threshold(1, 20)
                   .Touchpad(undefined, INPUT_VERB.LEFT, INPUT_VERB.RIGHT, INPUT_VERB.UP, INPUT_VERB.DOWN);
```

<!-- tabs:end -->

&nbsp;

## .GetType

`<virtual button>.GetType()`

<!-- tabs:start -->

#### **Description**

**Returns:** Member of the `INPUT_VIRTUAL_TYPE` enum, what type of virtual button this is

|Name|Datatype|Purpose|
|----|--------|-------|
|None|        |       |

The `INPUT_VIRTUAL_TYPE` enum contains the following elements:

|Name              |Purpose                                                                         |
|------------------|--------------------------------------------------------------------------------|
|`.BUTTON`    	   |Virtual button bindings set by `.Button()`                                      |
|`.DPAD_HORIZONTAL`|Virtual button bindings set by `.HPad()`                                        |
|`.DPAD_VERTICAL`  |Virtual button bindings set by `.VPad()`                                        |
|`.DPAD_8DIR` 	   |Virtual button bindings set by `.DPad()` with the `4dir` argument set to `false`|
|`.DPAD_4DIR` 	   |Virtual button bindings set by `.DPad()` with the `4dir` argument set to `true` |
|`.THUMBSTICK`	   |Virtual button bindings set by `.Thumbstick()`                                  |
|`.TOUCHPAD`	   |Virtual button bindings set by `.Touchpad()`                                    |

#### **Example**

```gml
//If we're in debug mode...
if (debug_mode)
{
	//Show a different debug string for this button depending on its type
	var _position = vbuttonMovement.GetPosition();
	with(vbuttonMovement.GetType())
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

## .GetVerbs

`<virtual button>.GetVerbs()`

<!-- tabs:start -->

#### **Description**

**Returns:** Struct, the verb bindings for the virtual button

|Name|Datatype|Purpose|
|----|--------|-------|
|None|        |       |

The struct returned from this method has the following member variables:

|Name    |Datatype|Purpose                                                    |
|--------|--------|-----------------------------------------------------------|
|`.click`|integer |Verb bound to touching the virtual button at all           |
|`.left` |integer |Verb bound to touching the virtual button on the left side |
|`.right`|integer |Verb bound to touching the virtual button on the right side|
|`.up`   |integer |Verb bound to touching the virtual button on the up side   |
|`.down` |integer |Verb bound to touching the virtual button on the down side |

#### **Example**

```gml
//If we're in debug mode and touch the movement virtual button...
if (debug_mode && vbuttonMovement.Pressed())
{
	//Then spit out a list of verbs that are assigned to the button
	show_debug_message($"Pressed virtual button with verbs: {vbuttonMovement.GetVerbs()}");
}
```

<!-- tabs:end -->

&nbsp;

## .Threshold

`<virtual button>.Threshold(min, max)`

<!-- tabs:start -->

#### **Description**

**Returns:** `self`

|Name |Datatype|Purpose                |
|-----|--------|-----------------------|
|`min`|number  |Minimum threshold value|
|`max`|number  |Maximum threshold value|

?> This method does not affect virtual buttons configured with the `.Button()` method.

#### **Example**

```gml
//Set the threshold of the thumbstick virtual button based on a sensitivity mode
switch(sensitivityMode)
{
	case 0: vbThumbstick.Threshold(0.3, 1.0); break;
	case 1: vbThumbstick.Threshold(0.4, 0.9); break;
	case 2: vbThumbstick.Threshold(0.5, 0.8); break;
}
```

<!-- tabs:end -->

&nbsp;

## .GetThreshold

`<virtual button>.GetThreshold()`

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
var _struct = vbThumbstick.GetThreshold();

if (vbThresholdMinDecr.Pressed()) _struct.min = max(0, _struct.min - 0.1);
if (vbThresholdMinIncr.Pressed()) _struct.min = min(1, _struct.min + 0.1, _struct.max - 0.1);

if (vbThresholdMaxDecr.Pressed()) _struct.min = max(0, _struct.min + 0.1, _struct.max - 0.1);
if (vbThresholdMaxIncr.Pressed()) _struct.min = min(1, _struct.max + 0.1);

vbThumbstick.Threshold(_struct.min, _struct.max);
```

<!-- tabs:end -->

&nbsp;

## .Active

`<virtual button>.Active(state)`

<!-- tabs:start -->

#### **Description**

**Returns:** `self`

|Name   |Datatype|Purpose                            |
|-------|--------|-----------------------------------|
|`state`|boolean |Active state for the virtual button|

When a virtual button's active state is set to `false`, it will immediately stop responding to player input, including any current input.

#### **Example**

```gml
if (input_check_pressed(INPUT_VERB.PAUSE))
{
	//If the player's pressed the PAUSE button, flip the pause state
	global.paused = not global.paused;

	//Set the main gameplay virtual buttons to the opposite of the pause state
	var _vbActive = not global.paused;
	vbThumbstick.Active(_vbActive);
	vbAccept.Active(_vbActive);
	vbCancel.Active(_vbActive);

	//Handle pause menu presence
	if (global.paused)
	{
		instance_create_layer(0, 0, "GUI", oPause);
	}
	else
	{
		with(oPauseMenu) instance_destroy();
	}
}
```

<!-- tabs:end -->

&nbsp;

## .GetActive

`<virtual button>.GetActive()`

<!-- tabs:start -->

#### **Description**

**Returns:** Boolean, whether the virtual button is active

|Name|Datatype|Purpose|
|----|--------|-------|
|None|        |       |

#### **Example**

```gml
//Draw the "accept" virtual button, but only if it's active
if (vbAccept.GetActive())
{
	var _position = vbAccept.GetPosition();
	draw_sprite(sVbAccept, 0, _position.x, _position.y);
}
```

<!-- tabs:end -->

&nbsp;

## .Priority

`<virtual button>.Priority(priority)`

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
vbPause = InputVirtualCreate()
          .Rectangle(room_width-40, 10, room_width-10, 40)
          .Button(INPUT_VERB.PAUSE)
          .Priority(100);
```

<!-- tabs:end -->

&nbsp;

## .GetPriority

`<virtual button>.GetPriority()`

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
	var _position = vbCancel.GetPosition();
	draw_text(_position.x, _position.y - 30, $"depth={vbCancel.GetPriority()}");
}
```

<!-- tabs:end -->

&nbsp;

## .Follow

`<virtual button>.Follow(state)`

<!-- tabs:start -->

#### **Description**

**Returns:** `self`

|Name   |Datatype|Purpose                                                         |
|-------|--------|----------------------------------------------------------------|
|`state`|boolean |Whether the virtual button should move to follow the touch point|

?> As the follow state moves the virtual button around, you may want to call `.ReleaseBehavior()` to control how a virtual button reacts when released (including resetting the position of the button).

#### **Example**

```gml
if (vbScreen.Pressed())
{
	//Create a virtual button to track player movement when touching the screen
	//We use the screen virtual button here so that other button can take priority

	//Create a simple circular button
	vbFollow = InputVirtualCreate()
	           .Circle(vbScreen.GetTouchX(), vbScreen.GetTouchY(), 20);

    //Choose a priority higher than the screen button so we always take priority
	vbFollow.Priority(vbScreen.GetPriority() + 1)

	//Set this new button to follow the player's finger around
	vbFollow.Follow(true);

	//When released, destroy this button completely
	vbFollow.ReleaseBehavior(INPUT_VIRTUAL_RELEASE.DESTROY);
}
```

<!-- tabs:end -->

&nbsp;

## .GetFollow

`<virtual button>.GetFollow()`

<!-- tabs:start -->

#### **Description**

**Returns:** Boolean, whether the virtual button is following the touch point

|Name|Datatype|Purpose|
|----|--------|-------|
|None|        |       |

#### **Example**

```gml
//Draw the "switch weapon" button
var _position = vbSwitchWeapon.GetPosition();
draw_sprite(sVbSwitchWeapon, 0, _position.x, _position.y);

//If we're in customisation mode and this button is following a touchpoint...
if (global.customiseLayout && vbSwitchWeapon.GetFollow())
{
	//Then flash an overlay sprite over the button
	if ((current_time mod 400) < 200)
	{
		draw_sprite_ext(sVbSwitchWeapon, 0, _position.x, _position.y, 1.2, 1.2, 0, c_yellow, 0.4);
	}
}
```

<!-- tabs:end -->

&nbsp;

## .ReleaseBehavior

`<virtual button>.ReleaseBehavior(option)`

<!-- tabs:start -->

#### **Description**

**Returns:** `self`

|Name    |Datatype                    |Purpose                                            |
|--------|----------------------------|---------------------------------------------------|
|`option`|`INPUT_VIRTUAL_RELEASE` enum|Behavior to execute when releasing a virtual button|

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

vbBalloonArray = [];

var _i = 0;
repeat(20)
{
	//Choose a random position around the centre of the screen
	var _x = room_width/2  + irandom_range(-300, 300);
	var _y = room_height/2 + irandom_range(-300, 300);

	//Create the balloon virtual buttons
	//We use a high priority here to block most other virtual buttons
	vbBalloonArray[@ _i] = InputVirtualCreate()
                           .Circle(_x, _y, 80)
                           .Release_behavior(INPUT_VIRTUAL_RELEASE.DESTROY)
                           .Priority(10);
    ++_i;
}
```

<!-- tabs:end -->

&nbsp;

## .GetReleaseBehavior

`<virtual button>.GetReleaseBehavior()`

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
	var _position = vbLootable.GetPosition();
	draw_text(_position.x, _position.y, $"rel bhv={vb_resume.get_release_behavior()}");
}
```

<!-- tabs:end -->

&nbsp;

## .FirstTouchOnly

`<virtual button>.FirstTouchOnly(state)`

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
repeat(array_length(menuContentArray))
{
	var _content = menuContentArray[_i];
	if (_content.isButton)
	{
		//Use the .FirstTouchOnly() feature to remove the potential for misclicks
		_content.virtualButton = Input_VirtualCreate()
		                          .Rectangle(_content.left, _content.top, _content.right, _content.bottom)
		                          .FirstTouchOnly(true);
	}

	++_i;
}
```

<!-- tabs:end -->

&nbsp;

## .GetFirstTouchOnly

`<virtual button>.GetFirstTouchOnly()`

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
	var _position = vbResume.GetPosition();
	draw_text(_position.right + 10, _position.y, $"FTO={vbResume.GetFirstTouchOnly()}");
}
```

<!-- tabs:end -->

&nbsp;

## .ReferencePoint

`<virtual button>.ReferencePoint(option)`

<!-- tabs:start -->

#### **Description**

**Returns:** `self`

|Name    |Datatype                      |Purpose|
|--------|------------------------------|-------|
|`option`|`INPUT_VIRTUAL_REFERENCE` enum|       |

This method controls how the virtual button calculates the output x/y values. These output x/y values also impact the calculation of left/right/up/down verb triggers. As a general description, output x/y values are calculated by subtracting the reference point's position from the position of the current touchpoint. By adjusting the reference point you can customise what sort of motions you expect to trigger output values from the virtual button.

The `INPUT_VIRTUAL_REFERENCE` enum contains the following elements:

|Name          |Purpose                                                                           |
|--------------|----------------------------------------------------------------------------------|
|`.CENTER`     |Default setting. Reference point is the centre of the virtual button              |
|`.TOUCH_POINT`|Reference point is the place where the player first touched the virtual button    |
|`.DELTA`      |Reference point is the place where the player touched the virtual button last step|

?> This setting is ignored when using the touchpad mode for a virtual button.

#### **Example**

```gml
//Get screen dimensions
var _right  = display_get_gui_width();
var _bottom = display_get_gui_height();

//Create a joystick that can be used anywhere on the screen, with 
//the reference point following the players touch location.
vbuttonFullscreenJoystick = InputVirtualCreate()
                            .Rectangle(0, 0, _right, _bottom)
                            .Thumbstick(undefined, INPUT_VERB.LEFT, INPUT_VERB.RIGHT, INPUT_VERB.UP, INPUT_VERB.DOWN)
                            .ReferencePoint(INPUT_VIRTUAL_REFERENCE.TOUCH_POINT);
```

<!-- tabs:end -->

&nbsp;

## .GetReferencePoint

`<virtual button>.GetReferencePoint()`

<!-- tabs:start -->

#### **Description**

**Returns:** Member of the `INPUT_VIRTUAL_REFERENCE` enum

|Name|Datatype|Purpose|
|----|--------|-------|
|None|        |       |

#### **Example**

```gml
//Draw the current reference point type to the screen when in debug mode
if (debug_mode)
{
	//Convert the referent point type enum to a string
	var _string = "Unknown";
	switch(vbuttonScreen.GetReferencePoint())
	{
		case INPUT_VIRTUAL_REFERENCE.CENTER:      _string = "Center";      break;
		case INPUT_VIRTUAL_REFERENCE.TOUCH_POINT: _string = "Touch Point"; break;
		case INPUT_VIRTUAL_REFERENCE.DELTA:       _string = "Delta";       break;
	}

	//Draw that string to the screen
	draw_text(x, y, _string);
}
```

<!-- tabs:end -->

&nbsp;

## .Momentary

`<virtual button>.Momentary(state)`

<!-- tabs:start -->

#### **Description**

**Returns:** `self`

|Name   |Datatype|Purpose                               |
|-------|--------|--------------------------------------|
|`state`|boolean |Momentary state for the virtual button|

For buttons that are designed to be rapidly tapped, the standard button behaviour will trip over itself on touchscreens, leading to missed inputs. In the limited testing we've been able to do, it appears that the release event triggered by some touchscreen hardware (or perhaps the operating system) is slow to respond to physical fingers-on-glass input. The "momentary" feature partially addresses this issue by setting up a virtual button to not hold onto continuous input which allows faster re-triggering.

When the momentary mode is turned on, a button will register a "pressed" event for one step and then immediately register a "released" event on the next step. It is therefore not possible to long hold a momentary button. This self-releasing behaviour means that the next touchpoint to tap the button will be successfully picked up, leading to no lost inputs.

?> It is possible to set any virtual button to momentary but you will find this feature is only useful for `.Button()`-type virtual buttons.

#### **Example**

```gml
//Create a button that can be rapidly tapped to dash across the screen
vbuttonDash = InputVirtualCreate()
              .Rectangle(bbox_left, bbox_top, bbox_right, bbox_bottom)
              .Button(INPUT_VERB.DASH)
              .Momentary(true);
```

<!-- tabs:end -->

&nbsp;

## .GetMomentary

`<virtual button>.GetMomentary()`

<!-- tabs:start -->

#### **Description**

**Returns:** Boolean, whether the virtual button is set to momentary

|Name|Datatype|Purpose|
|----|--------|-------|
|None|        |       |

#### **Example**

```gml
//If our context-sensitive button is set to momentary input, prompt the player
if (vbuttonContext.GetMomentary())
{
	draw_text(x, y, "Tap Me Lots!");
}
```

<!-- tabs:end -->

&nbsp;

## .Pressed

`<virtual button>.Pressed()`

<!-- tabs:start -->

#### **Description**

**Returns:** Boolean, whether the virtual button was pressed this frame

|Name|Datatype|Purpose|
|----|--------|-------|
|None|        |       |

#### **Example**

```gml
//If the virtual button associated with this instance has been pressed...
if (vbutton.Pressed())
{
	//Change the sprite to a flashing one to give feedback
	sprite_index = sButtonActiveFlash;
}

//And reset the sprite when released
if (vbutton.Released())
{
	sprite_index = sButtonInactive;
}
```

<!-- tabs:end -->

&nbsp;

## .Check

`<virtual button>.Check()`

<!-- tabs:start -->

#### **Description**

**Returns:** Boolean, whether the virtual button has been pressed and held

|Name|Datatype|Purpose|
|----|--------|-------|
|None|        |       |

#### **Example**

```gml
if (vbuttonJump.Check())
{
	timeHeld++;
}

if (vbuttonJump.Release())
{
	//Jump - the strength will be proportional to how long the button was held
	PlayerJump(timeHeld);

	//Play a sound effect with a higher pitch for higher jumps
	var _sound = audio_play_sound(sndJump, 1, false);
	audio_sound_pitch(_sound, 1 + min(0.2, timeHeld/10));

	//Reset our timer when released
	timeHeld = 0;
}
```

<!-- tabs:end -->

&nbsp;

## .Released

`<virtual button>.Released()`

<!-- tabs:start -->

#### **Description**

**Returns:** Boolean, whether the virtual button was released this frame

|Name|Datatype|Purpose|
|----|--------|-------|
|None|        |       |

#### **Example**

```gml
//If the player has released the unpause virtual button and there's no modal active...
if (vbuttonUnpause.Released() && not instance_exists(oModalParent))
{
	//Destroy ourselves and resume gameplay
	instance_destroy();
	GameUnpause();
}
```

<!-- tabs:end -->

&nbsp;

## .GetX

`<virtual button>.GetX()`

<!-- tabs:start -->

#### **Description**

**Returns:** Number, the normalized x value for the virtual button

|Name|Datatype|Purpose|
|----|--------|-------|
|None|        |       |

The number returned from this function will range from `-1` (fully left) to `1` (fully right). This value respects the threshold values set by `.Threshold()`.

#### **Example**

```gml
//Draw an arrow eminating from the virtual button based on how it's being touched

var _position = vbThumbstick.GetPosition();
var _x1 = _position.x;
var _y1 = _position.y;
var _x2 = _x1 + 64*vbThumbstick.GetX();
var _y2 = _y1 + 64*vbThumbstick.GetY();

draw_arrow(_x1, _y1, _x2, _y2, 20);
```

<!-- tabs:end -->

&nbsp;

## .GetY

`<virtual button>.GetY()`

<!-- tabs:start -->

#### **Description**

**Returns:** Number, the normalized y value for the virtual button

|Name|Datatype|Purpose|
|----|--------|-------|
|None|        |       |

The number returned from this function will range from `-1` (fully top) to `1` (fully bottom). This value respects the threshold values set by `.Threshold()`.

#### **Example**

```gml
//Set the scroll position based on how the scroll bar is being touched

//First, calculate the distance we can actually scroll
var _scrollSize = max(0, contentHeight - pageHeight);

//Then set the scroll position from the scrollbar virtual button
scrollPosition = _scrollSize * vbScrollbar.GetY();
```

<!-- tabs:end -->

&nbsp;

## .GetTouchX

`<virtual button>.GetTouchX()`

<!-- tabs:start -->

#### **Description**

**Returns:** Number, the current x-coordinate of the touch point captured by the virtual button

|Name|Datatype|Purpose|
|----|--------|-------|
|None|        |       |

#### **Example**

```gml
if (vbFire.Check())
{
	//We can't read the touch point once we've released the button
	//This means we need to cache the touch points whilst the button is held
	fireTouchX = vbFire.GetTouchX();
	fireTouchY = vbFire.GetTouchY();
}

if (vb_fire.released())
{
	//Make a little first burst when releasing the button
	part_particles_create(global.guiParticleSys, fireTouchX, fireTouchY, global.pfxFireGun, 12);
}
```

<!-- tabs:end -->

&nbsp;

## .GetTouchY

`<virtual button>.GetTouchY()`

<!-- tabs:start -->

#### **Description**

**Returns:** Number, the current y-coordinate of the touch point captured by the virtual button

|Name|Datatype|Purpose|
|----|--------|-------|
|None|        |       |

#### **Example**

```gml
//Adjust the position of the power level pointer if we touch the thruster gauge
if (vbThruster.Check())
{
	thrustPointerY = vbThruster.GetTouchY();
}
```

<!-- tabs:end -->

&nbsp;

## .GetTouchDX

`<virtual button>.GetTouchDX()`

<!-- tabs:start -->

#### **Description**

**Returns:** Number, how far the touch point has moved in the x-axis between frames

|Name|Datatype|Purpose|
|----|--------|-------|
|None|        |       |

#### **Example**

```gml
//Create Event
//Create a joystick vbutton
vbuttonThumbstick = InputVirtualCreate()
                    .Circle(900, 300, 60)
                    .Thumbstick(undefined, INPUT_VERB.LEFT, INPUT_VERB.RIGHT, INPUT_VERB.UP, INPUT_VERB.DOWN);

//Step Event
//Have the thumbstick follow the touch input if movement is fast enough.
if(vbuttonThumbstick.check())
{
    var _dx     = vbuttonThumbstick.GetTouchDX();
    var _dy     = vbuttonThumbstick.GetTouchDY();
    var _follow = point_distance(0, 0, _dx, _dy) > 20;
    vbuttonThumbstick.Follow(_follow);
}
```

<!-- tabs:end -->

&nbsp;

## .GetTouchDY

`<virtual button>.GetTouchDY()`

<!-- tabs:start -->

#### **Description**

**Returns:** Number, how far the touch point has moved in the y-axis between frames

|Name|Datatype|Purpose|
|----|--------|-------|
|None|        |       |

#### **Example**

```gml
//Create Event
//Create a joystick vbutton
vbuttonThumbstick = InputVirtualCreate()
                    .Circle(900, 300, 60)
                    .Thumbstick(undefined, INPUT_VERB.LEFT, INPUT_VERB.RIGHT, INPUT_VERB.UP, INPUT_VERB.DOWN);

//Step Event
//Have the thumbstick follow the touch input if movement is fast enough.
if(vbuttonThumbstick.Check())
{
	var _dx     = vbuttonThumbstick.GetTouchDX();
	var _dy     = vbuttonThumbstick.GetTouchDY();
	var _follow = point_distance(0, 0, _dx, _dy) > 20;
	vbutton_thumbstick.follow(_follow);
}
```

<!-- tabs:end -->

&nbsp;

## .GetTouchStartX

`<virtual button>.GetTouchStartX()`

<!-- tabs:start -->

#### **Description**

**Returns:** Number, the initial x-coordinate of the touch point when captured by the virtual button

|Name|Datatype|Purpose|
|----|--------|-------|
|None|        |       |

#### **Example**

```gml
var _throw = false;
if (vbThrow.Released())
{
	//If we've released the throw button, throw!
	_throw = true;
}
else if (vbThrow.Check())
{
	//If we're holding down the throw button then track the touch position
	throwX = vbThrow.GetTouchX();
	throwY = vbThrow.GetTouchY();
}

//Figure out how far it is from the start of the touch gesture to the current position
var _start_x = vbThrow.GetTouchStartX();
var _start_y = vbThrow.GetTouchStartY();
var _distance = point_distance(_startX, _startY, throwX, throwY);

//If we've exceeded the max distance then throw!
var _minDistance =  50;
var _maxDistance = 250;
if (_distance > _maxDistance) _throw = true;

if (_throw)
{
	//Find the direction to throw in
	var _direction = point_direction(_startX, _startY, throwX, throwY);

	//And also the power of the throw
	var _power = clamp((_distance - _minDistance) / (_maxDistance - _minDistance), 0, 1);

	//Create a projectile and give it a push
	var _inst = instance_create_layer(x, y, "Projectile", oProjectile);
	_inst.speed     = lerp(2, 10, _power);
	_inst.direction = direction;
}
```

<!-- tabs:end -->

&nbsp;

## .GetTouchStartY

`<virtual button>.GetTouchStartY()`

<!-- tabs:start -->

#### **Description**

**Returns:** Number, the initial y-coordinate of the touch point when captured by the virtual button

|Name|Datatype|Purpose|
|----|--------|-------|
|None|        |       |

#### **Example**

```gml
if (vbBall.Released())
{
	//Once we've released the ball's virtual button, apply a spin
	//We calculate the spin based on the y-offset where we originally touched the ball
	var _spin = (vbBall.GetTouchStartY() - y) / ballRadius;
	angle_speed = 7*_spin;
}
```

<!-- tabs:end -->

&nbsp;

## .RecordHistory

`<virtual button>.RecordHistory(state)`

<!-- tabs:start -->

#### **Description**

**Returns:** `self`

|Name   |Datatype|Purpose|
|-------|--------|-------|
|`state`|boolean |       |

Starts recording touch point history for the virtual button. This can be used to detect swipe and flick gestures.

?> Input only keeps track of a limited number of frames of data. This is controlled by the `INPUT_TOUCH_HISTORY_FRAMES` config macro.

#### **Example**

```gml
//Create a virtual button that covers the entire screen
//We also want to track input history for this virtual button to detect swipes etc.
vbuttonScreen = input_virtual_create()
                .Rectangle(0, 0, display_get_gui_width(), display_get_gui_height())
                .RecordHistory(true);
```

<!-- tabs:end -->

&nbsp;

## .GetHistory

`<virtual button>.GetHistory()`

<!-- tabs:start -->

#### **Description**

**Returns:** Array of structs, see below

|Name|Datatype|Purpose|
|----|--------|-------|
|None|        |       |

Structs in the returned array contain x/y coordinate pairs. These coordinates are the position of the touch point captured by the virtual button, going back into the past. New data is pushed into the array every frame, with index 0 being the current touch point, index 1 in the array being 1 frame before present, the index 2 being 2 frames before presents, and so on.

?> All coordinates and positions are in GUI-space.

#### **Example**

```gml
//Draw all of the history points, but only if we're debugging
if (debug_mode)
{
    var _history = vbuttonScreen.GetHistory();

    //Use a line primitive to draw out all the points
    draw_primitive_begin(pr_linestrip);
    for(var _i = 0; _i < array_length(_history); _i++) draw_vertex(_history[_i].x, _history[_i].y);
    draw_primitive_end();
}
```

<!-- tabs:end -->

&nbsp;

## .GetHistoryDirection

`<virtual button>.GetHistoryDirection([frames])`

<!-- tabs:start -->

#### **Description**

**Returns:** Number, the direction in degrees from the oldest historic point to the most recent point

|Name      |Datatype|Purpose                                                                                        |
|----------|--------|-----------------------------------------------------------------------------------------------|
|`[frames]`|integer |Number of frames in the past to analyze. If not specified, `INPUT_TOUCH_HISTORY_FRAMES` is used|

#### **Example**

```gml
//IF the player is touching this button...
if (vbuttonScreen.Check())
{
    //Draw an arrow from the newest touch point...
    var _x1 = vbuttonScreen.GetTouchX();
    var _y1 = vbuttonScreen.GetTouchY();
    
    //In the direction of the oldest one
    var _x2 = _x1 - lengthdir_x(100, vbuttonScreen.GetHistoryDirection());
    var _y2 = _y1 - lengthdir_y(100, vbuttonScreen.GetHistoryDirection());
    
    draw_arrow(_x1, _y1, _x2, _y2, 20);
}
```

<!-- tabs:end -->

&nbsp;

## .GetHistoryDistance

`<virtual button>.GetHistoryDistance([frames])`

<!-- tabs:start -->

#### **Description**

**Returns:** Number, the length of the path described by the historical touch points

|Name      |Datatype|Purpose                                                                                        |
|----------|--------|-----------------------------------------------------------------------------------------------|
|`[frames]`|integer |Number of frames in the past to analyze. If not specified, `INPUT_TOUCH_HISTORY_FRAMES` is used|

?> The distance that this function returns is measured in GUI-space.

#### **Example**

```gml
//If the player is touching the kaleidoscope...
if (vbuttonKaleidoscope.Check())
{
    //Then animate in as they swipe around
    animation += vbuttonKaleidoscope.GetHistoryDistance() / 10;
}
```

<!-- tabs:end -->

&nbsp;

## .GetHistorySpeed

`<virtual button>.GetHistorySpeed([frames])`

<!-- tabs:start -->

#### **Description**

**Returns:** Number, the speed of the touch point's movement

|Name      |Datatype|Purpose                                                                                        |
|----------|--------|-----------------------------------------------------------------------------------------------|
|`[frames]`|integer |Number of frames in the past to analyze. If not specified, `INPUT_TOUCH_HISTORY_FRAMES` is used|

?> The speed that this function returns is measured in GUI-space.

#### **Example**

```gml
//If the player has stopped touching the "screen" virtual button
if (vbuttonScreen.Released())
{
    //And their touch motion has exceeded a certain speed...
    if (vbuttonScreen.GetHistorySpeed() > 5)
    {
        //Then flick the player instance off in that direction!
        hspeed += lengthdir_x(10, vbuttonScreen.GetHistoryDirection());
        vspeed += lengthdir_y(10, vbuttonScreen.GetHistoryDirection());
        sprite_index = sPlayerDash;
    }
}
```

<!-- tabs:end -->