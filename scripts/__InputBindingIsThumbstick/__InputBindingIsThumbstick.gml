// Feather disable all

/// @param binding

function __InputBindingIsThumbstick(_binding)
{
    if (_binding == undefined) return false;

    _binding = abs(_binding);
    return ((_binding == gp_axislh) || (_binding == gp_axislh) || (_binding == -gp_axislv) || (_binding == gp_axislv));
}
