// Feather disable all

function __input_axis_is_directional(_axis)
{
    return ((_axis == gp_padu)   || (_axis == gp_padd)   || (_axis == gp_padl)   || (_axis == gp_padr)
         || (_axis == gp_axislh) || (_axis == gp_axislv) || (_axis == gp_axisrh) || (_axis == gp_axisrv));
}
