// Feather disable all

////////////////////////////////////////////////////////////////////////////
//                                                                        //
// You're welcome to use any of the following macros in your game but ... //
//                                                                        //
//                       DO NOT EDIT THIS SCRIPT                          //
//                       Bad things might happen.                         //
//                                                                        //
//          Customisation options can be found in __InputConfig().        //
//                                                                        //
////////////////////////////////////////////////////////////////////////////

#macro vk_clear       0x0C
#macro vk_capslock    0x14
#macro vk_menu        0x5D
#macro vk_scrollock   0x91
 
#macro vk_semicolon   0xBA
#macro vk_comma       0xBC
#macro vk_fslash      0xBF
#macro vk_bslash      0xDC
#macro vk_lbracket    0xDB
#macro vk_rbracket    0xDD

#macro vk_numlock     ((INPUT_ON_APPLE &&  INPUT_ON_WEB)                    ? 0x0C : 0x90)
#macro vk_equals      ((INPUT_ON_MACOS && !INPUT_ON_WEB)                    ? 0x18 : 0xBB)
#macro vk_apostrophe (((INPUT_ON_MACOS || INPUT_ON_LINUX)  && !INPUT_ON_WEB)? 0xC0 : 0xDE)
#macro vk_hyphen     (((INPUT_ON_MACOS || INPUT_ON_SWITCH) && !INPUT_ON_WEB)? 0x6D : 0xBD)
#macro vk_rmeta        (INPUT_ON_MACOS? ((INPUT_ON_APPLE   &&  INPUT_ON_WEB)? 0x5D : 0x5B) : 0x5C)
#macro vk_backtick    (!INPUT_ON_MACOS?  (INPUT_ON_LINUX                    ? 0xDF : 0xC0) : 0x32)
#macro vk_lmeta        (INPUT_ON_MACOS                                      ? 0x5C : 0x5B)
#macro vk_period       (INPUT_ON_SWITCH                                     ? 0x6E : 0xBE)

#macro mb_wheel_up    m_scroll_up
#macro mb_wheel_down  m_scroll_down

//Valid keycode bounds
#macro INPUT_KEYCODE_MIN  8
#macro INPUT_KEYCODE_MAX  57343