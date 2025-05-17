# Gamepad Troubleshooting

---

The following recommendations should ease configuring USB and Bluetooth console gamepads for operation on desktop and mobile platforms. If you implement Input in your project, consider passing this information on to your players.

&nbsp;

## Testing Apps

To ensure your gamepad is working correctly with your device before attempting to configure it with Input, we recommend confirming proper operation using a platform-appropriate tool.

| Platform           | App  |
|:-------------------|:-----|
| Windows            | [Game Controller Dialogue (joy.cpl)](https://support.microsoft.com/en-ca/help/831361/how-to-troubleshoot-game-controllers-in-microsoft-games#section-2)|
| MacOS              | [Controllers Lite](https://itunes.apple.com/us/app/controllers-lite/id673660806)|
| Ubuntu             | [GTK Joystick Tester](https://installati.one/install-jstest-gtk-ubuntu-20-04/)|
| Android            | [Gamepad Tester](https://play.google.com/store/apps/details?id=ru.elron.gamepadtester)|
| iOS                | [Game Controller Tester](https://itunes.apple.com/us/app/game-controller-tester/id859236726)|
| HTML5 and OperaGX  | [HTML5 Gamepad Test](https://greggman.github.io/html5-gamepad-test/)|

&nbsp;

## Platform Troubleshooting

If you encounter trouble using your gamepad with Input, ensure the gamepad device's firmware is up to date, and that it is operating correctly. Input includes comprehensive built-in support for a wide variety of gamepads, and so disabling intermediary software and unofficial gamepad applications that may interfere with normal operation is recommended. 

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
