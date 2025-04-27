// Feather disable all

if (INPUT_ON_SWITCH)
{
    switch_controller_joycon_set_holdtype(switch_controller_joycon_holdtype_horizontal);
}

bindingMap = ds_map_create();
bindingMap[? gp_face1         ] = "gp_face1";
bindingMap[? gp_face2         ] = "gp_face2";
bindingMap[? gp_face3         ] = "gp_face3";
bindingMap[? gp_face4         ] = "gp_face4";
bindingMap[? gp_shoulderl     ] = "gp_shoulderl";
bindingMap[? gp_shoulderr     ] = "gp_shoulderr";
bindingMap[? gp_shoulderlb    ] = "gp_shoulderlb";
bindingMap[? gp_shoulderrb    ] = "gp_shoulderrb";
bindingMap[? gp_select        ] = "gp_select";
bindingMap[? gp_start         ] = "gp_start";
bindingMap[? gp_stickl        ] = "gp_stickl";
bindingMap[? gp_stickr        ] = "gp_stickr";
bindingMap[? gp_padu          ] = "gp_padu";
bindingMap[? gp_padd          ] = "gp_padd";
bindingMap[? gp_padl          ] = "gp_padl";
bindingMap[? gp_padr          ] = "gp_padr";
bindingMap[? gp_axislh        ] = "gp_axislh";
bindingMap[? gp_axislv        ] = "gp_axislv";
bindingMap[? gp_axisrh        ] = "gp_axisrh";
bindingMap[? gp_axisrv        ] = "gp_axisrv";
bindingMap[? gp_home          ] = "gp_home";
bindingMap[? gp_extra1        ] = "gp_extra1";
bindingMap[? gp_extra2        ] = "gp_extra2";
bindingMap[? gp_extra3        ] = "gp_extra3";
bindingMap[? gp_extra4        ] = "gp_extra4";
bindingMap[? gp_paddler       ] = "gp_paddler";
bindingMap[? gp_paddlel       ] = "gp_paddlel";
bindingMap[? gp_paddlerb      ] = "gp_paddlerb";
bindingMap[? gp_paddlelb      ] = "gp_paddlelb";
bindingMap[? gp_touchpadbutton] = "gp_touchpadbutton";
bindingMap[? gp_extra5        ] = "gp_extra5";
bindingMap[? gp_extra6        ] = "gp_extra6";

gamepadTypeMap = ds_map_create();
gamepadTypeMap[? INPUT_GAMEPAD_TYPE_NO_GAMEPAD  ] = "No Gamepad"
gamepadTypeMap[? INPUT_GAMEPAD_TYPE_UNKNOWN     ] = "Unknown"
gamepadTypeMap[? INPUT_GAMEPAD_TYPE_XBOX        ] = "Xbox"
gamepadTypeMap[? INPUT_GAMEPAD_TYPE_PS4         ] = "PS4"
gamepadTypeMap[? INPUT_GAMEPAD_TYPE_PS5         ] = "PS5"
gamepadTypeMap[? INPUT_GAMEPAD_TYPE_SWITCH      ] = "Switch"
gamepadTypeMap[? INPUT_GAMEPAD_TYPE_JOYCON_LEFT ] = "Joy-Con Left"
gamepadTypeMap[? INPUT_GAMEPAD_TYPE_JOYCON_RIGHT] = "Joy-Con Right"

triggerEffectMap = ds_map_create();
triggerEffectMap[? INPUT_TRIGGER_STATE.EFFECT_OFF              ] = "off";
triggerEffectMap[? INPUT_TRIGGER_STATE.EFFECT_FEEDBACK_STANDBY ] = "feedback standby";
triggerEffectMap[? INPUT_TRIGGER_STATE.EFFECT_FEEDBACK_ACTIVE  ] = "feedback active";
triggerEffectMap[? INPUT_TRIGGER_STATE.EFFECT_WEAPON_STANDBY   ] = "weapon standby";
triggerEffectMap[? INPUT_TRIGGER_STATE.EFFECT_WEAPON_PULLING   ] = "weapon pulling";
triggerEffectMap[? INPUT_TRIGGER_STATE.EFFECT_WEAPON_FIRED     ] = "weapon fired";
triggerEffectMap[? INPUT_TRIGGER_STATE.EFFECT_VIBRATION_STANDBY] = "vibration standby";
triggerEffectMap[? INPUT_TRIGGER_STATE.EFFECT_VIBRATION_ACTIVE ] = "vibration active";
triggerEffectMap[? INPUT_TRIGGER_STATE.EFFECT_INTERCEPTED      ] = "intercepted";