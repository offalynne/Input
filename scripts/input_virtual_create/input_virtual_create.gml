/// @desc    Creates a new virtual button that allows for touchscreen input to control verbs
/// 
/// Virtual buttons are returned as structs which can controlled by calling methods. For example,
/// the two following functions destroy and draw the button:
/// 
/// .destroy()
/// .debug_draw()
/// 
/// The behaviour of the created virtual button can be customised by calling methods on the retruned
/// virtual button struct:
/// 
/// .rectangle(left, right, top, bottom)
/// .circle(x, y, radius)
/// .get_position()
/// .button(clickVerb)
/// .dpad(clickVerb, leftVerb, rightVerb, upVerb, downVerb, [4dir])
/// .thumbstick(clickVerb, leftVerb, rightVerb, upVerb, downVerb)
/// .get_type()
/// .get_verbs()
/// .threshold(min, max)
/// .get_threshold()
/// .active(state)
/// .get_active()
/// .priority(priority)
/// .get_priority()
/// .follow(state)
/// .get_follow()
/// .release_behavior(option)
/// .get_release_behavior()
/// .first_touch_only(state)
/// .get_first_touch_only()
/// 
/// The state of the virtual button can also be directly interrogated if required. The following
/// methods are available (please see online documentation at http://jujuadams.github.io/Input for
/// more information):
/// 
/// .pressed()
/// .check()
/// .released()
/// .get_x()
/// .get_y()
/// .get_touch_x()
/// .get_touch_y()
/// .get_touch_start_x()
/// .get_touch_start_y()
/// 
/// Buttons can also be used to record touch position history. This is very useful for detecting
/// fast swipes etc.
/// 
/// .record_history(state)
/// .get_history()
/// .get_history_direction([frames])
/// .get_history_distance([frames])
/// .get_history_speed([frames])

function input_virtual_create()
{
    return new __input_class_virtual();
}