/// @param type
/// @param [value]
/// @param [axisNegative]

function __input_class_binding() constructor
{
    type          = argument[0];
    value         = (argument_count > 1)? argument[1] : undefined;
    axis_negative = (argument_count > 2)? bool(argument[2]) : undefined;
}