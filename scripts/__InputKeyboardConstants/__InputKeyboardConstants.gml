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

#macro vk_clear       12
#macro vk_capslock    20
#macro vk_menu        93
#macro vk_scrollock   145
                      
#macro vk_semicolon   186
#macro vk_comma       188
#macro vk_fslash      191
#macro vk_bslash      220
#macro vk_lbracket    219
#macro vk_rbracket    221

#macro vk_apostrophe ((INPUT_ON_MACOS && !INPUT_ON_WEB)? 192 : 222)
#macro vk_equals     ((INPUT_ON_MACOS && !INPUT_ON_WEB)?  24 : 187)
#macro vk_numlock    ((INPUT_ON_APPLE &&  INPUT_ON_WEB)?  12 : 144)
#macro vk_hyphen     ((INPUT_ON_SWITCH || (INPUT_ON_MACOS && !INPUT_ON_WEB))? 109 : 189)
#macro vk_rmeta      (INPUT_ON_MACOS? ((INPUT_ON_APPLE && INPUT_ON_WEB)? 93 : 91) : 92)
#macro vk_backtick   (INPUT_ON_MACOS?   50 : (INPUT_ON_LINUX? 223 : 192))
#macro vk_lmeta      (INPUT_ON_MACOS?   92 :  91)
#macro vk_period     (INPUT_ON_SWITCH? 110 : 190)

#macro mb_wheel_up    m_scroll_up
#macro mb_wheel_down  m_scroll_down

//Valid keycode bounds
#macro INPUT_KEYCODE_MIN  8
#macro INPUT_KEYCODE_MAX  57343