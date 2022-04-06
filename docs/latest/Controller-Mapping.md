# Controller Mapping

---

GMS2 has some [roughly-documented features](https://docs2.yoyogames.com/source/_build/3_scripting/4_gml_reference/controls/gamepad%20input/gamepad_test_mapping.html) that attempt parity with [SDL2](https://github.com/libsdl-org/SDL)'s [gamepad mapping feature](https://wiki.libsdl.org/CategoryGameController). These aim to normalize all compatible gamepad devices toward the [XInput spec](https://en.wikipedia.org/wiki/DirectInput#XInput); in simple terms, configuring every device in the style of an Xbox 360 controller. GameMaker supports this feature for desktop targets (Windows, Mac, Ubuntu) and Android.

?> While this information is provided for your benefit, in the best of cases it can be ignored: it is our intent that Input permit otherwise-problematic scenarios to “just work”. If you encounter undocumented platform-particular issues with Input's controller mapping feature, please consider authoring a bug report or reaching us to discuss further on Discord.

&nbsp;

## Controller Maps

In order to expand GMS2's database of supported controllers, all that should be necessary is adding an [updated CSV database file](https://github.com/gabomdq/SDL_GameControllerDB) named `gamecontrollerdb.txt` into the program directory (manually or as an Included File) which the runner should automatically load and parse. Unfortunately GMS2's implementation has a number of outstanding issues including using an old version of the GUID format on Windows, having a peculiar offset value for input indexes on Mac, and other cases where functions do not behave as expected per-platform. See [_Platform Quirks_](Platform-Quirks) for details.

Input attempts to solve GameMaker's issues with our own implementation that circumvents problems encountered with native functionality. When you use Input for gamepad binding, gamepads are automatically detected and configured according to the SDL community specification. Please note: Whilst the expectation for SDL is to name the gamepad remapping database as `gamecontrollerdb.txt`, to avoid conflicts with GameMaker's native implementation, Input reads its gamepad remapping data from a CSV file named `sdl2.txt`. Data in this file is otherwise identical to the SDL community database.

Input sources its gamepad data from  [SDL2 Game Controller Community DB](https://github.com/gabomdq/SDL_GameControllerDB). If you find a game controller device missing from the database, please contribute to the community database so we can all benefit.

&nbsp;

## Controller Type

Input references datafile `controllertypes.csv` in order to identify controllers by platform type. This information is useful should you want to present players with appropriate art for controller prompts to match their device in-hand, or otherwise configure around controller type. This data is [sourced from SDL](https://github.com/libsdl-org/SDL/blob/main/src/joystick/controller_type.h) combined with a [hand-curated list](https://gist.github.com/offalynne/1cf66d663a26c054f46c26c826666bf9) derived from the [community DB](https://github.com/gabomdq/SDL_GameControllerDB).

See [Functions (Gamepad)](Functions-(Gamepad)#input_gamepad_get_typegamepadindex) for usage.

&nbsp;

## Controller Blacklist

Some devices are accidentally incorrectly enumerated as gamepads, others are incompatible but enumerate anyway. Input blocks these by GUID, indicated by `all,guid`. Some cases are innocuous (devices simply don't operate) others are more problematic, such as Switch Pro Controllers, which don't work over USB unless used with Steam Input (which uses them as feeders for virtual controllers), which causes the device to go haywire. If you find Input to be blocking a device you think should work and want to use, remove the relevant ID data from the blacklist.

On Linux, some HID devices cause trouble and may misreport as gamepads, indicated in the blacklist as `linux,vid+pid,`. Sources for these include [community-sourced udev rules](https://github.com/denilsonsa/udev-joystick-blacklist/blob/master/generate_rules.py) and [Chromium](https://github.com/chromium/chromium/blob/master/device/gamepad/gamepad_blocklist.cc). On Android, pointing devices, headsets, push-to-talk interfaces, etc. are filtered out by device name. These are identified with [available logs from the HTML5 gamepad API](https://web.archive.org/web/20210222080234/https://gamepad-tester.com/logs/controllers), and are indicated in the `android,description contains` field.

&nbsp;

## Updating Dependencies

Portable script [`refresh_datafiles.py`](https://github.com/JujuAdams/Input/blob/master/refresh_datafiles.py) includes reference to all source files for Input's game controller data, and when run will attempt to update from each respective source. Since many of the upstream repositories are active, we recommend running the script locally prior to ship in order to keep your data up to date.
