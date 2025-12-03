function __InputConfigVerbs()
{
    enum INPUT_VERB
    {
        //Add your own verbs here!
        UP,
        DOWN,
        LEFT,
        RIGHT,
        ACCEPT,
        CANCEL,
        ACTION,
        SPECIAL,
        PAUSE,
        MAP,
    }
    
    enum INPUT_CLUSTER
    {
        //Add your own clusters here!
        //Clusters are used for two-dimensional checkers (InputDirection() etc.)
        NAVIGATION,
    }
    
    InputDefineVerb(INPUT_VERB.UP,      "up",         [vk_up,    "W"],    [-gp_axislv, gp_padu]);
    InputDefineVerb(INPUT_VERB.DOWN,    "down",       [vk_down,  "S"],    [ gp_axislv, gp_padd]);
    InputDefineVerb(INPUT_VERB.LEFT,    "left",       [vk_left,  "A"],    [-gp_axislh, gp_padl]);
    InputDefineVerb(INPUT_VERB.RIGHT,   "right",      [vk_right, "D"],    [ gp_axislh, gp_padr]);
    InputDefineVerb(INPUT_VERB.ACTION,  "action",      vk_enter,            gp_face3);
    InputDefineVerb(INPUT_VERB.SPECIAL, "special",     vk_shift,            gp_face4);
    
    if (INPUT_ON_SWITCH)
    {
        //Flip A/B over on Switch
        InputDefineVerb(INPUT_VERB.ACCEPT, "accept", undefined, gp_face2); // !!
        InputDefineVerb(INPUT_VERB.CANCEL, "cancel", undefined, gp_face1); // !!
    }
    else
    {
        InputDefineVerb(INPUT_VERB.ACCEPT, "accept", vk_space,     gp_face1);
        InputDefineVerb(INPUT_VERB.CANCEL, "cancel", vk_backspace, gp_face2);
    }
    
    if (INPUT_ON_PS5)
    {
        //`gp_select` is inaccessible on PS5
        InputDefineVerb(INPUT_VERB.MAP, "map", vk_backspace, gp_touchpadbutton);
    }
    else
    {
        InputDefineVerb(INPUT_VERB.MAP, "map", vk_backspace, gp_select);
    }
    
    
    //Define a cluster of verbs for moving around
    InputDefineCluster(INPUT_CLUSTER.NAVIGATION, INPUT_VERB.UP, INPUT_VERB.RIGHT, INPUT_VERB.DOWN, INPUT_VERB.LEFT);
}
