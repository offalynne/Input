if (instance_number(object_index) > 1)
{
    __input_error("More than one instance of ", object_get_name(object_index), " has been created\nPlease ensure that ", object_get_name(object_index), " is never manually created");
    instance_destroy();
    return;
}