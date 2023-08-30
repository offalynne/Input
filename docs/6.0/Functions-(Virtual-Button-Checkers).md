# Functions (Virtual Button Checkers)

&nbsp;

Virtual buttons can be configured using the following functions. Many functions return `self` meaning that methods can be chained together as a fluent interface.

?> These functions are purely optional. The intended use case is for virtual buttons to funnel their input into verbs. This behaviour can be set up by using the `.button()`, `.dpad()`, and `.thumbstick()` methods.

&nbsp;

## .pressed

`<virtual button>.pressed()`

<!-- tabs:start -->

#### **Description**

**Returns:** Boolean, whether the virtual button was pressed this frame

|Name|Datatype|Purpose|
|----|--------|-------|
|None|        |       |

#### **Example**

```gml
//If the virtual button associated with this instance has been pressed...
if (vbutton.pressed())
{
	//Change the sprite to a flashing one to give feedback
	sprite_index = spr_button_active_flash;
}

//And reset the sprite when released
if (vbutton.released())
{
	sprite_index = spr_button_inactive;
}
```

<!-- tabs:end -->

&nbsp;

## .check

`<virtual button>.check()`

<!-- tabs:start -->

#### **Description**

**Returns:** Boolean, whether the virtual button has been pressed and held

|Name|Datatype|Purpose|
|----|--------|-------|
|None|        |       |

#### **Example**

```gml
if (vbutton_jump.check())
{
	time_held++;
}
if (vbutton_jump.release())
{
	//Jump - the strength will be proportional to how long the button was held
	player_jump(time_held);

	//Play a sound effect with a higher pitch for higher jumps
	var _sound = audio_play_sound(snd_jump, 1, false);
	audio_sound_pitch(_sound, 1 + min(0.2, time_held/10));

	//Reset our timer when released
	time_held = 0;
}
```

<!-- tabs:end -->

&nbsp;

## .released

`<virtual button>.released()`

<!-- tabs:start -->

#### **Description**

**Returns:** Boolean, whether the virtual button was released this frame

|Name|Datatype|Purpose|
|----|--------|-------|
|None|        |       |

#### **Example**

```gml
//If the player has released the unpause virtual button and there's no modal active...
if (vbutton_unpause.released() && not instance_exists(obj_modal_parent))
{
	//Destroy ourselves and resume gameplay
	instance_destroy();
	game_unpause();
}
```

<!-- tabs:end -->

&nbsp;

## .get_x

`<virtual button>.get_x()`

<!-- tabs:start -->

#### **Description**

**Returns:** Number, the normalized x value for the virtual button

|Name|Datatype|Purpose|
|----|--------|-------|
|None|        |       |

The number returned from this function will range from `-1` (fully left) to `1` (fully right). This value respects the threshold values set by `.threshold()`.

#### **Example**

```gml
//Draw an arrow eminating from the virtual button based on how it's being touched

var _position = vb_thumbstick.get_position();
var _x1 = _position.x;
var _y1 = _position.y;
var _x2 = _x1 + 64*vb_thumbstick.get_x();
var _y2 = _y1 + 64*vb_thumbstick.get_y();

draw_arrow(_x1, _y1, _x2, _y2, 20);
```

<!-- tabs:end -->

&nbsp;

## .get_y

`<virtual button>.get_y()`

<!-- tabs:start -->

#### **Description**

**Returns:** Number, the normalized y value for the virtual button

|Name|Datatype|Purpose|
|----|--------|-------|
|None|        |       |

The number returned from this function will range from `-1` (fully top) to `1` (fully bottom). This value respects the threshold values set by `.threshold()`.

#### **Example**

```gml
//Set the scroll position based on how the scroll bar is being touched

//First, calculate the distance we can actually scroll
var _scroll_size = max(0, content_height - page_height);

//Then set the scroll position from the scrollbar virtual button
scroll_position = _scroll_size * vb_scrollbar.get_y();
```

<!-- tabs:end -->

&nbsp;

## .get_touch_x

`<virtual button>.get_touch_x()`

<!-- tabs:start -->

#### **Description**

**Returns:** Number, the current x-coordinate of the touch point captured by the virtual button

|Name|Datatype|Purpose|
|----|--------|-------|
|None|        |       |

#### **Example**

```gml
if (vb_fire.check())
{
	//We can't read the touch point once we've released the button
	//This means we need to cache the touch points whilst the button is held
	fire_touch_x = vb_fire.get_touch_x();
	fire_touch_y = vb_fire.get_touch_y();
}

if (vb_fire.released())
{
	//Make a little first burst when releasing the button
	part_particles_create(global.gui_particle_sys, fire_touch_x, fire_touch_y, global.pfx_fire_gun, 12);
}
```

<!-- tabs:end -->

&nbsp;

## .get_touch_y

`<virtual button>.get_touch_y()`

<!-- tabs:start -->

#### **Description**

**Returns:** Number, the current y-coordinate of the touch point captured by the virtual button

|Name|Datatype|Purpose|
|----|--------|-------|
|None|        |       |

#### **Example**

```gml
//Adjust the position of the power level pointer if we touch the thruster gauge
if (vb_thruster.check())
{
	thrust_pointer_y = vb_thruster.get_touch_y();
}
```

<!-- tabs:end -->

&nbsp;

## .get_touch_start_x

`<virtual button>.get_touch_start_x()`

<!-- tabs:start -->

#### **Description**

**Returns:** Number, the initial x-coordinate of the touch point when captured by the virtual button

|Name|Datatype|Purpose|
|----|--------|-------|
|None|        |       |

#### **Example**

```gml
var _throw = false;
if (vb_throw.released())
{
	//If we've released the throw button, throw!
	_throw = true;
}
else if (vb_throw.check())
{
	//If we're holding down the throw button then track the touch position
	throw_x = vb_throw.get_touch_x();
	throw_y = vb_throw.get_touch_y();
}

//Figure out how far it is from the start of the touch gesture to the current position
var _start_x = vb_throw.get_touch_start_x();
var _start_y = vb_throw.get_touch_start_y();
var _distance = point_distance(_start_x, _start_y, throw_x, throw_y);

//If we've exceeded the max distance then throw!
var _min_distance =  50;
var _max_distance = 250;
if (_distance > _max_distance) _throw = true;

if (_throw)
{
	//Find the direction to throw in
	var _direction = point_direction(_start_x, _start_y, throw_x, throw_y);

	//And also the power of the throw
	var _power = clamp((_distance - _min_distance) / (_max_distance - _min_distance), 0, 1);

	//Create a projectile and give it a push
	var _inst = instance_create_layer(x, y, "Projectile", obj_projectile);
	_inst.speed     = lerp(2, 10, _power);
	_inst.direction = direction;
}
```

<!-- tabs:end -->

&nbsp;

## .get_touch_start_y

`<virtual button>.get_touch_start_y()`

<!-- tabs:start -->

#### **Description**

**Returns:** Number, the initial y-coordinate of the touch point when captured by the virtual button

|Name|Datatype|Purpose|
|----|--------|-------|
|None|        |       |

#### **Example**

```gml
if (vb_ball.released())
{
	//Once we've released the ball's virtual button, apply a spin
	//We calculate the spin based on the y-offset where we originally touched the ball
	var _spin = (vb_ball.get_touch_start_y() - y) / ball_radius;
	angle_speed = 7*_spin;
}
```

<!-- tabs:end -->
