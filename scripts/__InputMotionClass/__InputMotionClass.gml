// Feather disable all

/// @param deviceIndex

function __InputMotionClass(_device) constructor
{
    __device = _device;
        
    quatCalibratedX = 0;
    quatCalibratedY = 0;
    quatCalibratedZ = 0;
    quatCalibratedW = 1;
    
    __isCalibrated = false;
    
    if (INPUT_ON_SWITCH || INPUT_ON_PS4 || INPUT_ON_PS5)
    {
        //Console platforms are presumed to always have motion data available for their first-party gamepads
        __hasData = InputDeviceIsGamepad(__device);
    }
    else if ((INPUT_ON_WINDOWS || INPUT_ON_LINUX) && InputGetSteamInfo(INPUT_STEAM_INFO.STEAMWORKS))
    {
        //Check to see if Steam thinks this device supports gyro & motion
        var _steamHandle = InputDeviceGetSteamHandle(__device);
        __hasData = is_numeric(_steamHandle) && is_struct(steam_input_get_motion_data(_steamHandle));
    }
    else
    {
        __hasData = false;
    }
    
    __Clear();
    
    
    
    
    
    static __Clear = function()
    {
        accelerationX =  0.0;
        accelerationY = -1.0;
        accelerationZ =  0.0;

        angularVelocityX = 0.0;
        angularVelocityY = 0.0;
        angularVelocityZ = 0.0;
        
        quatDeviceX = 0;
        quatDeviceY = 0;
        quatDeviceZ = 0;
        quatDeviceW = 1;
        
        quatRoll  = 0;
        quatPitch = 0;
        quatYaw   = 0;
    };
    
    static __Calibrate = function()
    {
        quatCalibratedX = quatDeviceX;
        quatCalibratedY = quatDeviceY;
        quatCalibratedZ = quatDeviceZ;
        quatCalibratedW = quatDeviceW;
        
        __isCalibrated = true;
    }

    static __Update = function()
    {
        //Take a break if the game is out of focus
        if (not InputGameHasFocus()) return;
        
        switch(os_type)
        {
            case os_switch:
                var _axisX  = switch_controller_axis_x;
                var _axisZ  = switch_controller_axis_y;
                var _signX  = 1;
                var _signZ  = 1;
                var _sensor = 0;
                
                var _type = InputDeviceGetGamepadType(__device);
                if (_type == INPUT_GAMEPAD_TYPE_SWITCH)
                {
                    if (InputDeviceGetDescription(__device) == "SwitchJoyConPair")
                    {
                        _sensor = 1;
                    }
                }
                else if (_type == INPUT_GAMEPAD_TYPE_JOYCON_LEFT)
                {
                    if (__INPUT_SWITCH_JOYCON_HORIZONTAL_HOLDTYPE)
                    {
                        _axisX = switch_controller_axis_y;
                        _axisZ = switch_controller_axis_x;
                        _signX = -1;
                    }
                }
                else if (_type == INPUT_GAMEPAD_TYPE_JOYCON_RIGHT)
                {
                    if (__INPUT_SWITCH_JOYCON_HORIZONTAL_HOLDTYPE)
                    {
                        _axisX = switch_controller_axis_y;
                        _axisZ = switch_controller_axis_x;
                        _signZ = -1;
                    }
                }
                
                accelerationX = _signX * switch_controller_acceleration(__device, _axisX, _sensor);
                accelerationY = -switch_controller_acceleration(__device, switch_controller_axis_z, _sensor);
                accelerationZ = _signZ * switch_controller_acceleration(__device, _axisZ, _sensor);

                angularVelocityX = _signX * degtorad(switch_controller_angular_velocity(__device, _axisX, _sensor)/5) * 570.6;
                angularVelocityY = -degtorad(switch_controller_angular_velocity(__device, switch_controller_axis_z, _sensor)/5) * 570.6;
                angularVelocityZ = _signZ * degtorad(switch_controller_angular_velocity(__device, _axisZ, _sensor)/5) * 570.6;
            break;            

            case os_ps4:
            case os_ps5:
                accelerationX =  gamepad_axis_value(__device, gp_axis_acceleration_x);
                accelerationY = -gamepad_axis_value(__device, gp_axis_acceleration_y);
                accelerationZ = -gamepad_axis_value(__device, gp_axis_acceleration_z);
                
                angularVelocityX =  gamepad_axis_value(__device, gp_axis_angular_velocity_x) / pi;
                angularVelocityY = -gamepad_axis_value(__device, gp_axis_angular_velocity_y) / pi;
                angularVelocityZ = -gamepad_axis_value(__device, gp_axis_angular_velocity_z) / pi;
            break;

            case os_windows:
            case os_linux:
                var _steamHandle = InputDeviceGetSteamHandle(__device);
                if (is_numeric(_steamHandle))
                {                    
                    var _steamData = steam_input_get_motion_data(_steamHandle);
                    if (not is_struct(_steamData)) 
                    {
                        //This device is not returning motion data, clear it out!
                        __hasData = false;
                        __Clear();
                        return;
                    }
                    
                    __hasData = true;
                    
                    accelerationX =  _steamData.pos_accel_x / 16384;
                    accelerationY = -_steamData.pos_accel_y / 16384;
                    accelerationZ = -_steamData.pos_accel_z / 16384;
                    
                    var _toX = _steamData.rot_quat_x;
                    var _toY = _steamData.rot_quat_y;
                    var _toZ = _steamData.rot_quat_z;
                    var _toW = _steamData.rot_quat_w;
                    
                    quatDeviceX = _toX;
                    quatDeviceY = _toY;
                    quatDeviceZ = _toZ;
                    quatDeviceW = _toW;
                    
                    var _invFromX = -quatCalibratedX;
                    var _invFromY = -quatCalibratedY;
                    var _invFromZ = -quatCalibratedZ;
                    var _invFromW =  quatCalibratedW;
                    
                    // Multiply the conjugate of qFrom by qTo
                    var _deltaX = _invFromW*_toX + _invFromX*_toW + _invFromY*_toZ - _invFromZ*_toY;
                    var _deltaY = _invFromW*_toY - _invFromX*_toZ + _invFromY*_toW + _invFromZ*_toX;
                    var _deltaZ = _invFromW*_toZ + _invFromX*_toY - _invFromY*_toX + _invFromZ*_toW;
                    var _deltaW = _invFromW*_toW - _invFromX*_toX - _invFromY*_toY - _invFromZ*_toZ;
                    
                    var _radius = _deltaX*_deltaX + _deltaY*_deltaY + _deltaZ*_deltaZ + _deltaW*_deltaW;
                    if (_radius > 0)
                    {
                        _radius = 1/sqrt(_radius);
                        _deltaX = _radius*_deltaX;
                        _deltaY = _radius*_deltaY;
                        _deltaZ = _radius*_deltaZ;
                        _deltaW = _radius*_deltaW;
                    }
                    else
                    {
                        _deltaX = 0;
                        _deltaY = 0;
                        _deltaZ = 0;
                        _deltaW = 1;
                    }
                    
                    //Order here deliberately doesn't match. This is because the standard quaternion coordinate system
                    //doesn't match up with the assumed coordinate system of a gamepad
                    var _angleRoll  =  __InputMotionQuatToPitch(_deltaX, _deltaY, _deltaZ, _deltaW);
                    var _anglePitch = -__InputMotionQuatToRoll( _deltaX, _deltaY, _deltaZ, _deltaW);
                    var _angleYaw   = -__InputMotionQuatToYaw(  _deltaX, _deltaY, _deltaZ, _deltaW);
                    
                    angularVelocityX = _angleYaw   - quatYaw;
                    angularVelocityY = _anglePitch - quatPitch;
                    angularVelocityZ = _angleRoll  - quatRoll;
                    
                    quatRoll  = _angleRoll;
                    quatPitch = _anglePitch;
                    quatYaw   = _angleYaw;
                }                
            break;
            
            default:
                __Clear();
            break;
        }
    }
}