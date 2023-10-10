# Gamepad Troubleshooting

---

The following recommendations should ease configuring USB and Bluetooth console gamepads for operation on desktop and mobile platforms. If you implement Input in your project, consider passing this information on to your players.

&nbsp;

## Bluetooth and USB gamepad support by platform

Note that the following applies to native support for first-party brand gamepads. 

|Gamepad         |Windows                    |MacOS         |Ubuntu                                 |Android                |iOS,&nbsp;iPadOS,&nbsp;tvOS     |HTML5,&nbsp;OperaGX |
|:---------------|---------------------------|--------------|---------------------------------------|-----------------------|--------------------------------|--------------------|
|PlayStation 3   |USB only<sup>&nbsp;1</sup> |Bluetooth only|BT, USB                                |USB only               |None                            |BT, USB<sup>&nbsp;4</sup>|
|PlayStation 4   |BT, USB                    |BT, USB       |BT, USB                                |BT, USB                |Bluetooth only                  |BT, USB<sup>&nbsp;4</sup>|
|PlayStation 5   |BT, USB                    |BT, USB       |BT, USB                                |BT, USB                |Bluetooth only                  |BT, USB<sup>&nbsp;4</sup>|
|Xbox 360        |USB, 2.4g<sup>&nbsp;2</sup>|None          |USB<sup>&nbsp;1</sup>, 2.4g<sup>&nbsp;2</sup>|USB, 2.4g<sup>&nbsp;2</sup>|None                  |USB, 2.4g<sup>&nbsp;2</sup>|
|Xbox One        |BT, USB, 2.4g<sup>&nbsp;2</sup> |Bluetooth&nbsp;only|BT, USB<sup>&nbsp;1</sup>, 2.4g<sup>&nbsp;2</sup>|BT, USB, 2.4g<sup>&nbsp;2</sup>|Bluetooth&nbsp;only|BT, USB<sup>&nbsp;4</sup>, 2.4g<sup>&nbsp;2</sup>|
|Switch Pro      |Bluetooth only<sup>&nbsp;3</sup>|Bluetooth&nbsp;only|BT, USB<sup>&nbsp;1,3,4</sup>|BT, USB<sup>&nbsp;4</sup>|Bluetooth&nbsp;only<sup>&nbsp;4</sup>|BT, USB<sup>&nbsp;4</sup>|
|Switch Joy-Cons |Bluetooth only<sup>&nbsp;3</sup>|Bluetooth&nbsp;only|BT, USB<sup>&nbsp;1,3,4</sup>|BT, USB<sup>&nbsp;4</sup>|Bluetooth&nbsp;only<sup>&nbsp;4</sup>|BT, USB<sup>&nbsp;4</sup>|

1. _Requires driver _(see below)__
2. _Requires adapter_
3. _Additional support may be available via Steam_
4. _Support depends on OS version_

&nbsp;

## Testing Apps

To ensure your gamepad is working correctly with your device before attempting to configure it with Input, we recommend confirming proper operation using a platform-appropriate tool.

| Platform           | App  |
|:-------------------|:-----|
| Windows            | [Game Controller Dialogue (joy.cpl)](https://support.microsoft.com/en-ca/help/831361/how-to-troubleshoot-game-controllers-in-microsoft-games#section-2)|
| MacOS              | [Controllers Lite](https://itunes.apple.com/us/app/controllers-lite/id673660806)|
| Ubuntu             | [GTK Joystick Tester](https://installati.one/install-jstest-gtk-ubuntu-20-04/)|
| Android            | [GamePad Test](https://play.google.com/store/apps/details?id=com.zhangyangjing.gamepadtest)|
| iOS                | [Game Controller Tester](https://itunes.apple.com/us/app/game-controller-tester/id859236726)|
| HTML5 and OperaGX  | [HTML5 Gamepad Test](https://greggman.github.io/html5-gamepad-test/)|

&nbsp;

## Platform Troubleshooting

If you encounter trouble using your gamepad with Input, ensure the gamepad device's firmware is up to date, and that it is working correctly on your Operating System. Input includes comprehensive built-in support for a wide variety of gamepads, and so disabling intermediary software and unofficial gamepad applications that may interfere with normal operation is recommended, including Xpadder, JoyToKey, AntiMicro, x360ce, ScpToolkit, MotioninJoy, and InputMapper. 

?> Depending on platform and device, certain setups may require extra configuration including device drivers, software and specific connectivity steps. The following additional setup may be necessary for proper operation on your platform.

### Windows
- [Xbox 360 Controller driver setup](https://support.xbox.com/help/xbox-360/xbox-on-windows/accessories/xbox-controller-for-windows-setup)
- [Xbox One Controller driver setup](https://support.xbox.com/help/hardware-network/controller/connect-xbox-wireless-controller-to-pc)
- [DualShock 3 driver setup with PS Plus (subscription not required)](https://www.playstation.com/en-ca/support/subscriptions/ps-plus-pc/)
- [Amazon Luna Bluetooth driver](https://www.amazon.com/gp/help/customer/display.html?nodeId=GZCT4CTFHXLHEB9T)
- [Google Stadia Bluetooth firmware](https://stadia.google.com/controller/)

### MacOS
- ~~[Xbox 360 and Xbox One Controller driver setup](https://github.com/360Controller/360Controller/releases)~~ [(Unsupported as of Jan 9, 2021)](https://github.com/360Controller/360Controller/issues/1139)
- [Wireless PlayStation, Xbox One, and Switch Controller Bluetooth pairing](https://support.apple.com/en-us/HT210414#mac)

### Ubuntu
- [Xbox One Wireless Adapter setup](https://medusalix.github.io/xow/)
- [Nintendo Switch Controller setup](https://github.com/nicman23/dkms-hid-nintendo)

&nbsp;

## Device Mapping

If your gamepad is an uncommon model or variant and seems to be presenting an incorrect button layout, it may be absent from the [gamepad mapping database](Controller-Mapping). Consider providing data for your device to the [SDL Community Gamepad DB](https://github.com/gabomdq/SDL_GameControllerDB) if you are able, or reaching Input's maintainers [on Discord](https://discord.gg/8krYCqr) to discuss further.
