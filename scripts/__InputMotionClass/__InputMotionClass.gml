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
        switch(os_type)
        {
            case os_switch:
                var _axis_x = switch_controller_axis_x;
                var _axis_z = switch_controller_axis_y;
                var _sign_x = 1;
                var _sign_z = 1;
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
                        _axis_x = switch_controller_axis_y;
                        _axis_z = switch_controller_axis_x;
                        _sign_x = -1;
                    }
                }
                else if (_type == INPUT_GAMEPAD_TYPE_JOYCON_RIGHT)
                {
                    if (__INPUT_SWITCH_JOYCON_HORIZONTAL_HOLDTYPE)
                    {
                        _axis_x = switch_controller_axis_y;
                        _axis_z = switch_controller_axis_x;
                        _sign_z = -1;
                    }
                }
                
                accelerationX = _sign_x * switch_controller_acceleration(__device, _axis_x, _sensor);
                accelerationY = -switch_controller_acceleration(__device, switch_controller_axis_z, _sensor);
                accelerationZ = _sign_z * switch_controller_acceleration(__device, _axis_z, _sensor);

                angularVelocityX = _sign_x * degtorad(switch_controller_angular_velocity(__device, _axis_x, _sensor)/5) * 570.6;
                angularVelocityY = -degtorad(switch_controller_angular_velocity(__device, switch_controller_axis_z, _sensor)/5) * 570.6;
                angularVelocityZ = _sign_z * degtorad(switch_controller_angular_velocity(__device, _axis_z, _sensor)/5) * 570.6;
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
                        __Clear();
                        return;
                    }
                    
                    accelerationX =  _steamData.pos_accel_x / 16384;
                    accelerationY = -_steamData.pos_accel_y / 16384;
                    accelerationZ = -_steamData.pos_accel_z / 16384;
                    
                    var _gyroScale = 2949.12;
                    
                    var _type = InputDeviceGetGamepadType(__device);
                    if ((_type == INPUT_GAMEPAD_TYPE_SWITCH)
                    ||  (_type == INPUT_GAMEPAD_TYPE_XBOX) //Switch with "Use Nintendo Button Layout"
                    ||  (_type == INPUT_GAMEPAD_TYPE_PS4))
                    {
                       //Reduce raw gyro scale for Switch and PS4 sensors
                        _gyroScale *= 2;
                    }
                    
                    //angularVelocityX =  _steamData.rot_vel_x / _gyroScale;
                    //angularVelocityY = -_steamData.rot_vel_z / _gyroScale;
                    //angularVelocityZ = -_steamData.rot_vel_y / _gyroScale;
                    
                    
                    
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