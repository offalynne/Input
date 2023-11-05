//Feather disable all

function __input_gamepad_tester_init()
{
    __INPUT_GLOBAL_STATIC_LOCAL
    
    var _data_struct = {};
    _global.__gamepad_tester_data = _data_struct;
    
    with(_data_struct)
    {
        __enabled = false;
        
        __view_pointer = undefined;
        
        __target_gamepad = 0;
        __gamepad_ref = ref_create(self, "__target_gamepad");
        
        __gamepad_desc = "";
        __gamepad_desc_ref = ref_create(self, "__gamepad_desc");
        
        __block_input = INPUT_DEFAULT_DEBUG_OVERLAY_BLOCKS_INPUT;
        __block_input_ref = ref_create(self, "__block_input");
        
        __raw_input_string = ""
        __raw_input_string_ref = ref_create(self, "__raw_input_string");
        
        __binding_name_array = ["gp_face1", "gp_face2", "gp_face3", "gp_face4",
                                "gp_padd", "gp_padu", "gp_padl", "gp_padr",
                                "gp_axislh", "gp_axislv", "gp_axisrh", "gp_axisrv",
                                "gp_stickl", "gp_stickr",
                                "gp_shoulderl", "gp_shoulderlb", "gp_shoulderr", "gp_shoulderrb",
                                "gp_select", "gp_start",
                                "gp_paddle1", "gp_paddle2", "gp_paddle3", "gp_paddle4",
                                "gp_guide", "gp_touchpad"];
        
        __input_values = {};
        __input_binding_array = [gp_face1, gp_face2, gp_face3, gp_face4,
                                 gp_padd, gp_padu, gp_padl, gp_padr,
                                 gp_axislh, gp_axislv, gp_axisrh, gp_axisrv,
                                 gp_stickl, gp_stickr,
                                 gp_shoulderl, gp_shoulderlb, gp_shoulderr, gp_shoulderrb,
                                 gp_select, gp_start,
                                 gp_paddle1, gp_paddle2, gp_paddle3, gp_paddle4,
                                 gp_guide, gp_touchpad];
        
        __input_ref_array = [];
        var _i = 0;
        repeat(array_length(__input_binding_array))
        {
            __input_ref_array[@ _i] = ref_create(__input_values, __binding_name_array[_i]);
            ++_i;
        }
        
        __gml_values = {};
        __gml_binding_array = [gp_face1, gp_face2, gp_face3, gp_face4,
                               gp_padd, gp_padu, gp_padl, gp_padr,
                               gp_axislh, gp_axislv, gp_axisrh, gp_axisrv,
                               gp_stickl, gp_stickr,
                               gp_shoulderl, gp_shoulderlb, gp_shoulderr, gp_shoulderrb,
                               gp_select, gp_start];
        
        __gml_ref_array = [];
        var _i = 0;
        repeat(array_length(__gml_binding_array))
        {
            __gml_ref_array[@ _i] = ref_create(__gml_values, __binding_name_array[_i]);
            ++_i;
        }
    }
}