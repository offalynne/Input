# Functions (System)

---

### `input_tick()`

*Returns:* N/A (`undefined`)

|Name|Datatype|Purpose|
|----|--------|-------|
|None|        |       |

Updates Input - all verbs, players, and gamepads. This function also unsticks keyboard keys and performs other clean-up duties to fix various bugs.

!> This function must be called **once every frame** in the [Begin Step](https://manual.yoyogames.com/#t=The_Asset_Editors%2FObject_Properties%2FObject_Events.htm) event (typically in a persistent instance). This function should **never** be called more than once a frame.