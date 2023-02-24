# Profiles

&nbsp;

Profiles are used to group together [bindings](Verbs-and-Bindings) into collections that can be switched in and out, either manually or automatically. You can learn more about the specifics of verbs and bindings [here](Verbs-and-Bindings). There are two kinds of profile:

1. Default Profiles - Defined using [`INPUT_DEFAULT_PROFILES`](Configuration?id=profiles-and-bindings) and exists for every player. Cannot be destroyed by [`input_profile_destroy()`](Functions-(Profiles)?id=input_profile_destroyprofilename-playerindex)
2. Custom Profiles - Created, destroyed, and otherwise managed using the [profile functions](Functions-(Profiles))

Regardless of what type a profile is, you can modify the bindings for that profile using [`input_binding_set()`](Functions-(Binding-Access)?id=input_binding_setverb-binding-playerindex-alternate) and the other [binding functions](Functions-(Binding-Access))). If a profile is a default profile then you can use [`input_profile_reset_bindings()`](Functions-(Profiles)?id=input_profile_reset_bindingsprofilename-playerindex) to reset the bindings for every verb in a profile.

!> It is not possible to create a totally new verb for a custom profile. Any verb that you intend to use in your game must be added to a default profile, even if it is initially unbound by default (i.e. set to `undefined` or `input_binding_empty()`).

&nbsp;

## Defining Default Profiles

As previously mentioned, default profiles are defined using [`INPUT_DEFAULT_PROFILES`](Configuration?id=profiles-and-bindings). This macro should be set to a struct that lays out the default profiles you need for your game and the bindings for each verb.

The structure is as follows:
```gml
INPUT_DEFAULT_PROFILES = {
    <default profile name>: {
	    <verb name>: <binding>
		<verb name>: [<binding 0>, <binding 1>], //Verb with multiple bindings
		...
	},
	
	<default profile name>: {
	    <verb name>: <binding>
		<verb name>: [<binding 0>, <binding 1>],
		...
	},
	
	...
}
```

Bindings can be created using one of the following [binding creator functions](Functions-(Binding-Creators)):

|Type                   |Creator function                                                                                                |
|-----------------------|----------------------------------------------------------------------------------------------------------------|
|Empty, inactive binding|`undefined`or [`input_binding_empty()`](Functions-(Binding-Creators)?id=input_binding_gamepad_axisaxis-negative)|
|Keyboard key           |[`input_binding_key()`](Functions-(Binding-Creators)?id=input_binding_keykey)                                   |
|Mouse button           |[`input_binding_mouse_button()`](Functions-(Binding-Creators)?id=input_binding_mouse_buttonbutton)              |
|Mouse wheel up         |[`input_binding_mouse_wheel_up()`](Functions-(Binding-Creators)?id=input_binding_mouse_wheel_up)                |
|Mouse wheel down       |[`input_binding_mouse_wheel_down()`](Functions-(Binding-Creators)?id=input_binding_mouse_wheel_down)            |
|Gamepad button         |[`input_binding_gamepad_button()`](Functions-(Binding-Creators)?id=input_binding_gamepad_buttonbutton)          |
|Gamepad axis           |[`input_binding_gamepad_axis()`](Functions-(Binding-Creators)?id=input_binding_keykey)                          |

If you'd like to mark a verb as being unbound for a particular default profile, you may use either `undefined` or [`input_binding_empty()`](Functions-(Binding-Creators)?id=input_binding_gamepad_axisaxis-negative). If you'd like more than one binding to be applied to a given verb, you may list the bindings in an array inside the struct.

Here's an example configuration that matches the one used for Hyper Light Drifter:

```gml
INPUT_DEFAULT_PROFILES = {
    keyboard_and_mouse: {
	    move_up:     input_binding_key("W"),
	    move_down:   input_binding_key("S"),
	    move_left:   input_binding_key("A"),
	    move_right:  input_binding_key("D"),
		dash:        input_binding_key(vk_space),
		
		sword: input_binding_mouse_button(mb_left),
		shoot: input_binding_mouse_button(mb_right),
		
        heal:     input_binding_key("Q"),
		sit:      input_binding_key("Z"),
		special:  input_binding_key("C"),
		interact: input_binding_key("E"),
		
		swap_weapon: input_binding_key("1"),
		inventory:   input_binding_key(vk_tab),
		menu:        input_binding_key(vk_escape),
	},
	
    gamepad: {
	    move_up:     input_binding_gamepad_axis(gp_axislv, true ),
	    move_down:   input_binding_gamepad_axis(gp_axislv, false),
	    move_left:   input_binding_gamepad_axis(gp_axislh, true ),
	    move_right:  input_binding_gamepad_axis(gp_axislh, false),
		dash:        input_binding_gamepad_button(gp_face1),
		
		sword: input_binding_mouse_button(gp_face3),
		shoot: input_binding_mouse_button(gp_shoulderr),
		
        heal:     input_binding_gamepad_button(gp_shoulderlb),
		sit:      input_binding_gamepad_button(gp_padd),
		special:  input_binding_gamepad_button(gp_shoulderrb),
		interact: input_binding_gamepad_button(gp_face4),
		
		swap_weapon: input_binding_gamepad_button(gp_face2),
		inventory:   input_binding_gamepad_button(gp_select),
		menu:        input_binding_gamepad_button(gp_start),
	},
}
```