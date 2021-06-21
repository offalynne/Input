/// @param type
/// @param [value]
/// @param [axisNegative]
/// @param [label]

function __input_class_binding() constructor
{
    type          = argument[0];
    value         = (argument_count > 1)? argument[1] : undefined;
    axis_negative = ((argument_count > 2) && (argument[2] != undefined))? bool(argument[2]) : undefined;
    label         = ((argument_count > 3) && (argument[3] != undefined))? argument[3] : __input_binding_get_label(type, value, axis_negative);
}