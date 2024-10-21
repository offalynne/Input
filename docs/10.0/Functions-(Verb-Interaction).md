# Verb Interaction

&nbsp;

## …VerbConsume

`InputVerbConsume(verbIndex, [playerIndex=0])`

<!-- tabs:start -->

#### **Description**

**Returns:** N/A (`undefined`)

|Name           |Datatype|Purpose                                             |
|---------------|--------|----------------------------------------------------|
|`verbIndex`    |integer |Verb to consume                                     |
|`[playerIndex]`|integer |Player to target. If not specified, player 0 is used|

"Consumes" a verb, causing it to be immediately deactivated and return a value of zero until the verb is retriggered (e.g. by released a keyboard key and pressed it again). This helpful when navigating menus to prevent multiple inputs.

<!-- tabs:end -->

&nbsp;

## …VerbConsumeAll

`InputVerbConsumeAll()`

<!-- tabs:start -->

#### **Description**

**Returns:** N/A (`undefined`)

|Name           |Datatype|Purpose                                             |
|---------------|--------|----------------------------------------------------|
|`[playerIndex]`|integer |Player to target. If not specified, player 0 is used|

"Consumes" all verbs for a player, causing them to be immediately deactivated and return a value of zero until a verb is retriggered (e.g. by released a keyboard key and pressed it again).

<!-- tabs:end -->

&nbsp;

## …VerbGetExportName

`InputVerbGetExportName(verbIndex)`

<!-- tabs:start -->

#### **Description**

**Returns:** String, the export name for a verb

|Name       |Datatype|Purpose                           |
|-----------|--------|----------------------------------|
|`verbIndex`|integer |Verb whose name should be returned|

Returns the export name for a verb, as defined by `InputDefineVerb()`.

<!-- tabs:end -->

&nbsp;

## …VerbGetBindingName

`InputVerbGetBindingName(verbIndex, [alternate=0], [playerIndex=0], [missingBindingName="???"])`

<!-- tabs:start -->

#### **Description**

**Returns:** String, the name for a verb's binding using the player's current device

|Name                  |Datatype|Purpose                                                                                 |
|----------------------|--------|----------------------------------------------------------------------------------------|
|`verbIndex`           |integer |Verb whose binding name should be returned                                              |
|`[alternate]`         |integer |Which alternate binding to target. If not specified, index 0 is used                    |
|`[playerIndex]`       |integer |Player to target. If not specified, player 0 is used                                    |
|`[missingBindingName]`|string  |String to return if a binding name cannot be resolved. If not specified, `"???"` is used|

Returns a name for a verb's binding using the player's current device. If a name for a binding cannot be found, this function will return `missingBindingName` (which is `"???"` by default). [You can find a full list of possible return values here](Binding-Names).
 
!> This function is provided for basic binding naming and is suitable for debugging or alpha-quality games. Please use the "Binding Icons" plug-in for a higher quality system.

<!-- tabs:end -->

&nbsp;

## …VerbCount

`InputVerbCount()`

<!-- tabs:start -->

#### **Description**

**Returns:** Integer, the number of defined verbs

|Name|Datatype|Purpose|
|----|--------|-------|
|None|        |       |

Returns the number of verbs defined in `InputDefineVerb()`.

<!-- tabs:end -->

&nbsp;

## …VerbStateArray

`InputVerbStateArray([newArray=true], [playerIndex=0])`

<!-- tabs:start -->

#### **Description**

**Returns:** ,

|Name           |Datatype|Purpose                                                                                               |
|---------------|--------|------------------------------------------------------------------------------------------------------|
|`[newArray]`   |boolean |Whether a new array should be returned (`true`) or whether a static array should be returned (`false`)|
|`[playerIndex]`|integer |Player to target. If not specified, player 0 is used                                                  |

Returns an array of verb states which are copies of the current verb state in the library. This is useful for interrogating verb history for e.g. a combo system. The verb states are structs that contain the following values:

|Variable     |Usage                                          |
|-------------|-----------------------------------------------|
|`.prevHeld`  |Whether the verb was held in the previous frame|
|`.held`      |Whether the verb is held on this frame         |
|`.valueRaw`  |Raw analogue value                             |
|`.valueClamp`|Analogue value after remapping and clamping    |
|`.duration`  |Number of frames since the verb was pressed    |

<!-- tabs:end -->

&nbsp;

## …VerbStateWrite

`InputVerbStateWrite(buffer, [playerIndex=0])`

<!-- tabs:start -->

#### **Description**

**Returns:** N/A (`undefined`)

|Name           |Datatype|Purpose                                             |
|---------------|--------|----------------------------------------------------|
|`buffer`       |buffer  |Buffer to write verb state into                     |
|`[playerIndex]`|integer |Player to target. If not specified, player 0 is used|

Writes the current verb state into a buffer. Four values are written:

|Datatype     |Value                                          |
|-------------|-----------------------------------------------|
|`buffer_bool`|Whether the verb was held in the previous frame|
|`buffer_f32` |Raw analogue value                             |
|`buffer_f32` |Analogue value after remapping and clamping    |
|`buffer_s32` |Number of frames since the verb was pressed    |

The verb state is preceded by the string "<-PWP" and ends with the string ">". Verb state can be restored by calling `InputPlugInVerbStateRead()` (but this read function must be called in a `INPUT_PLUG_IN_CALLBACK.UPDATE_PLAYER` callback).

<!-- tabs:end -->

&nbsp;

## …VerbStateByteLength

`InputVerbStateByteLength(buffer, [playerIndex=0])`

<!-- tabs:start -->

#### **Description**

**Returns:** Integer, the number of bytes that a verb state will occupy

|Name|Datatype|Purpose|
|----|--------|-------|
|None|        |       |

Returns the number of bytes that a verb state will occupy if `InputVerbStateWrite()` is called. 

<!-- tabs:end -->