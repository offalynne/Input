// Feather disable all

function __InputVerbGroupsConfig()
{
    //Whether verbs should be blocked if *any* of their verb groups are inactive. If you set this macro
    //to `false` then a verb will only be blocked if *all* of its verb groups are inactive.
    #macro INPUT_VERB_GROUP_INACTIVE_ON_ANY  false
    
    enum INPUT_VERB_GROUP
    {
        MENU,
        //Add your own verb groups here!
    }
    
    //If you add a verb group in the `INPUT_VERB_GROUP` enum then you should add a call to
    //`InputVerbGroupDefine` here.
    InputVerbGroupDefine(INPUT_VERB_GROUP.MENU, [INPUT_VERB.LEFT]);
}