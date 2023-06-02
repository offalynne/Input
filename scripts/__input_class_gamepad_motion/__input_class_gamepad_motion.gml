function __input_class_gamepad_motion(_gamepad_index) constructor
{
    __INPUT_GLOBAL_STATIC_VARIABLE  //Set static __global
    
    static __motion_data = {};
    __motion_frame = -infinity;
    __index = _gamepad_index;
    
    __clear();

    static __tick = function()
    {
        var _cleared = __global.__cleared || !input_window_has_focus();
        if (!_cleared && (__global.__frame <= __motion_frame))
        {
            return __get_data();
        }

        __clear();
        if (_cleared)
        {
            return __get_data();
        }
        
        __motion_frame = __global.__frame;

        switch(os_type)
        {
            case os_switch:
                var _axis_x = switch_controller_axis_x;
                var _axis_z = switch_controller_axis_y;
                var _sign_x = 1;
                var _sign_z = 1;
                var _sensor = 0;

                switch(__global.__gamepads[__index].raw_type)
                {
                    case "SwitchJoyConPair":
                        if (INPUT_SWITCH_JOYCON_MOTION_RIGHT_HAND)
                        {
                            _sensor = 1;
                        }
                    break;

                    case "SwitchJoyConLeft":
                        if (INPUT_SWITCH_HORIZONTAL_HOLDTYPE)
                        {
                            _axis_x = switch_controller_axis_y;
                            _axis_z = switch_controller_axis_x;
                            _sign_x = -1;
                        }
                    break;

                    case "SwitchJoyConRight":
                        if (INPUT_SWITCH_HORIZONTAL_HOLDTYPE)
                        {
                            _axis_x = switch_controller_axis_y;
                            _axis_z = switch_controller_axis_x;
                            _sign_z = -1;
                        }
                    break;
                }

                __accel_x = _sign_x * switch_controller_acceleration(__index, _axis_x, _sensor);
                __accel_y = -switch_controller_acceleration(__index, switch_controller_axis_z, _sensor);
                __accel_z = _sign_z * switch_controller_acceleration(__index, _axis_z, _sensor);

                __gyro_x = _sign_x * degtorad(switch_controller_angular_velocity(__index, _axis_x, _sensor)/5) * 570.6;
                __gyro_y = -degtorad(switch_controller_angular_velocity(__index, switch_controller_axis_z, _sensor)/5) * 570.6;
                __gyro_z = _sign_z * degtorad(switch_controller_angular_velocity(__index, _axis_z, _sensor)/5) * 570.6;
            break;            

            case os_ps4:
            case os_ps5:
                __accel_x =  gamepad_axis_value(__index, gp_axis_acceleration_x);
                __accel_y = -gamepad_axis_value(__index, gp_axis_acceleration_y);
                __accel_z = -gamepad_axis_value(__index, gp_axis_acceleration_z);
                
                __gyro_x =  gamepad_axis_value(__index, gp_axis_angular_velocity_x) / pi;
                __gyro_y = -gamepad_axis_value(__index, gp_axis_angular_velocity_y) / pi;
                __gyro_z = -gamepad_axis_value(__index, gp_axis_angular_velocity_z) / pi;
            break;

            case os_windows:
            case os_linux:
                var _steam_handle = __global.__gamepads[__index].__steam_handle;
                if (is_numeric(_steam_handle))
                {                    
                    var _steam_data = steam_input_get_motion_data(_steam_handle);
                    if (!is_struct(_steam_data)) 
                    {
                        return undefined;
                        break;
                    }
                    
                    __accel_x =  _steam_data.pos_accel_x / 16384;
                    __accel_y = -_steam_data.pos_accel_y / 16384;
                    __accel_z = -_steam_data.pos_accel_z / 16384;
                    
                    var _gyro_scale = 2949.12;
                    if ((__global.__gamepads[__index].simple_type == INPUT_GAMEPAD_TYPE_SWITCH)
                    ||  (__global.__gamepads[__index].simple_type == INPUT_GAMEPAD_TYPE_XBOX_360) //Switch with "Use Nintendo Button Layout"
                    ||  (__global.__gamepads[__index].simple_type == INPUT_GAMEPAD_TYPE_PS4))
                    {
                       //Reduce raw gyro scale for Switch and PS4 sensors
                        _gyro_scale *= 2;
                    }
                    
                    __gyro_x =  _steam_data.rot_vel_x / _gyro_scale;
                    __gyro_y = -_steam_data.rot_vel_z / _gyro_scale;
                    __gyro_z = -_steam_data.rot_vel_y / _gyro_scale;
                }                
            break;

            default: return undefined; break;
        }
        
        return __get_data();
    };
    
    static __clear = function()
    {        
        __accel_x =  0.0;
        __accel_y = -1.0;
        __accel_z =  0.0;

        __gyro_x = 0.0;
        __gyro_y = 0.0;
        __gyro_z = 0.0;
    };

    static __get_data = function()
    {
        __motion_data.acceleration_x = __accel_x;
        __motion_data.acceleration_y = __accel_y;
        __motion_data.acceleration_z = __accel_z;

        __motion_data.angular_velocity_x = __gyro_x;
        __motion_data.angular_velocity_y = __gyro_y;
        __motion_data.angular_velocity_z = __gyro_z;
        
        return __motion_data;
    };
}
