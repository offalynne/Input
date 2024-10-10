if (not InputMotionSupported())
{
    draw_text_ext(10, 10, "Motion not supported by this gamepad (or Steam Input not enabled for this gamepad)", -1, room_width-20);
}
else if (not InputMotionIsCalibrated())
{
    draw_text(10, 10, "Press gp_face1 to calibrate");
}
else
{
    draw_text(10, 10, string_replace_all(json_stringify(InputMotionGet()), ",", "\n"));
    draw_circle(pointerX, pointerY, 32, true);
}