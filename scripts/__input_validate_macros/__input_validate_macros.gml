function __input_validate_macros()
{
    if ((INPUT_2D_XY_AXIS_BIAS < 0) || (INPUT_2D_XY_AXIS_BIAS > 1))
    {
        __input_error("INPUT_2D_XY_AXIS_BIAS should be between 0.0 and 1.0 (was ", INPUT_2D_XY_AXIS_BIAS, ")");
    }
}