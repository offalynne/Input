// Feather disable all
/// @desc    Returns whether input is detected from any source

function input_any_pressed()
{
    return input_source_detect_input(all, false);
}
