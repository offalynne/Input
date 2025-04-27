// Feather disable all

if (InputPressed(INPUT_VERB.ACCEPT))
{
    InputMotionCalibrate();
}

var _motion = InputMotionGet();
if (_motion != undefined)
{
    pointerX = room_width  * (0.5 + _motion.quatYaw/30);
    pointerY = room_height * (0.5 + _motion.quatPitch/30);
    
    //pointerX = room_width  * (0.5 + 0.5*_motion.angularVelocityX)/30;
    //pointerY = room_height * (0.5 + 0.5*_motion.angularVelocityY)/30;
}