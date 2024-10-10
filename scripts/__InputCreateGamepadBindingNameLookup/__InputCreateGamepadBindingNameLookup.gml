// Feather disable all

function __InputCreateGamepadBindingNameLookup()
{
    var _map = ds_map_create();
    
    _map[? -gp_axislh] = "thumbstick l left";
    _map[? -gp_axislv] = "thumbstick l up";
    _map[?  gp_axislh] = "thumbstick l right";
    _map[?  gp_axislv] = "thumbstick l down";
    _map[?  gp_stickl] = "thumbstick l click";
    
    _map[? -gp_axisrh] = "thumbstick r left";
    _map[? -gp_axisrv] = "thumbstick r up";
    _map[?  gp_axisrh] = "thumbstick r right";
    _map[?  gp_axisrv] = "thumbstick r down";
    _map[?  gp_stickr] = "thumbstick r click";
    
    _map[?  gp_shoulderl ] = "shoulder l";
    _map[?  gp_shoulderr ] = "shoulder r";
    _map[?  gp_shoulderlb] = "trigger l";
    _map[?  gp_shoulderrb] = "trigger r";
    
    _map[?  gp_padu] = "dpad up";
    _map[?  gp_padd] = "dpad down";  
    _map[?  gp_padl] = "dpad left";  
    _map[?  gp_padr] = "dpad right";  
    
    _map[?  gp_face1] = "face south";
    _map[?  gp_face2] = "face east";
    _map[?  gp_face3] = "face west";
    _map[?  gp_face4] = "face north";
    
    _map[?  gp_select] = "select";
    _map[?  gp_start ] = "start";
    _map[?  gp_home  ] = "home";
    
    _map[?  gp_paddler ] = "paddle r";
    _map[?  gp_paddlel ] = "paddle l";
    _map[?  gp_paddlerb] = "paddle rb";
    _map[?  gp_paddlelb] = "paddle lb";
    
    _map[?  gp_extra1] = "extra 1";
    _map[?  gp_extra2] = "extra 2";
    _map[?  gp_extra3] = "extra 3";
    _map[?  gp_extra4] = "extra 4";
    _map[?  gp_extra5] = "extra 5";
    _map[?  gp_extra6] = "extra 6";
    
    _map[?  gp_touchpadbutton] = "touchpad";
    
    return _map;
}