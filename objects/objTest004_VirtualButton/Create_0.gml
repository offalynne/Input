// Feather disable all

eventArray = [];

InputPlayerSetDevice(INPUT_TOUCH);

upButton   = InputVirtualCreate().Rectangle(400, 100, 600, 300).Button(INPUT_VERB.UP);
downButton = InputVirtualCreate().Rectangle(400, 400, 600, 600).Button(INPUT_VERB.DOWN);