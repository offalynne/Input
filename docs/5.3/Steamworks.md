# Steamworks

&nbsp;

The [Steamworks Game Maker extension](https://github.com/YoYoGames/GMEXT-Steamworks/) allows the Input library to leverage Steam Input for correct identification of XInput and virtual controllers, as well as access to extended gamepad features normally available only on console platforms: [vibration](Functions-(Vibration).md), [motion](Functions-(Motion).md), [LED color](Functions-(Color).md), and [haptic trigger effects](Functions-(Trigger-Effects).md). Input supports Steamworks through [the Game Maker extension](https://github.com/YoYoGames/GMEXT-Steamworks/) on Windows and Linux, including SteamOS for Steam Deck.

Once configuring an app in the Steamworks dashboard and setting up the extension for Game Maker in a project as outlined below, Input handles these features transparently, requiruing no further effort specific to Steamworks.

?> If you are not using the Steamworks extension for other Steam platform features, do not want to use extended gamepad features on Windows or Linux, and do not have an issue with gamepad type reporting on Windows through Steam, Input will work adquately without any need to import or configure the Steamworks extension.

&nbsp;

## Setup

- Download and extract the [Steamworks SDK](https://partner.steamgames.com/downloads/list)
- Download and import the latest [Steamworks Game Maker extension](https://github.com/YoYoGames/GMEXT-Steamworks/releases)
- [Configure your application](#configuring-steamworks) through Steamworks dashboard
- [Set Application ID](#setting-application-id) and SDK location in extension options in Game Maker IDE
- Ensure `INPUT_USE_STEAMWORKS` in [`__input_config_general`](Configuration.md#general) is `<true>`

&nbsp;

## Configuring Steamworks

In order to appropriately configure your Steam app for use with the Input library, [using the Steam dashboard](https://partner.steamgames.com/dashboard), navigate to your app: *Steamworks > App Admin > (Your App)*. From the *Application* menu select *Steam Input* and select *Gamepad with Camera Controls*, *Gamepad with High Precision Camera/Aim*, or *Generic Gamepad*.

![](https://i.imgur.com/xve3seR.png)

How Steam Input operates depends on how your App is configured in Steamworks, and further relies on the player's Steam settings for opted-in controllers. Steam Input covers three main use scenarios:

1. Handling gamepads through Steam alone, for games solely or primarily distributed on Steam _(Custom Configuration)_
2. Normalizing gamepads and offering extended device features, for games that include basic gamepad support
3. Remapping gamepad input to keyboard and mouse, for games that do not include gamepad support

Since the Input library aims to provide comprehensive cross-platform gamepad support and does not solely rely on Steam, use case #2 is relevant, referred to as [Steam Input Gamepad Emulation](https://partner.steamgames.com/doc/features/steam_controller/steam_input_gamepad_emulation_bestpractices). 

Note that if you select *Custom Configuration* for *Steam Input Default Configuration*, Game Maker will no longer recieve any gamepad input from devices that are opted-in to Steam, will require you to [rely directly on the Steam Input API](https://github.com/YoYoGames/GMEXT-Steamworks/wiki/Input#Input) by configuring your game extensively [from within Steamworks](https://partner.steamgames.com/doc/features/steam_controller/iga_file), and will not work with the normal functions provided by Game Maker or the Input library.

&nbsp;

## Setting Application ID

Steamworks SDK documentation refers to an example project called *Spacewar*, [(Application ID 480)](https://steamdb.info/app/480) that is the default AppID setting when you import the YYG Steamworks Extension for Game Maker. Note that the *Spacewar* example is configured in Steamworks to use a Steam Input *Custom Configuration*, meaning it will not work as intended until this option is changed, and no controller opted-in to Steam will work with Game Maker or the Input library's default feature set for this AppID.

![](https://i.imgur.com/czFKFNj.png)

&nbsp;

## Borrowing an AppID for Local Testing

In order for your game to use Steamworks upon release, you will need to [register with Steamworks](https://partner.steamgames.com/newpartner/) and acquire your own AppID. You cannot use Steamworks API features meaningfully upon release without registering your app through Steam. The easiest way to get set up with Steamworks is by configuring your own application. However, if during development you would like to test without configuring your own application within Steamworks, you can substitute an AppID from an existing Steam app for testing purposes. 

!> Note that before distributing your game you will need to switch to your own AppID and make sure it is properly configured, so it is usually most convenient to use your own AppID from the outset instead of going through the additional effort to borrow an AppID as outlined below.

In order to test with a borrowed AppID, the associated app must support your target desktop OS, you must have claimed it (by downloading and installing the original app), and the app must not be configured to use a Steam Input *Custom Conifguration*. You can use the information available from the website SteamDB to check an app's Steam Input configuration, for example the [configuration for Portal 2](https://steamdb.info/app/620/config/) is custom (indicated by `steamcontrollertemplateindex 1`) making it ineligible to borrow, where the [configuration for Samurai Gunn 2](https://steamdb.info/app/1397790/config/) is not, making it suitable for this purpose. For convenience, ideal candidates for borrowing AppID are [multi-platform, free](https://store.steampowered.com/search/?sort_by=Released_DESC&maxprice=free&category1=998&category2=28&os=linux), and small in file size, for example the game [Rebel Wings (AppID 378090)](https://store.steampowered.com/app/378090/Rebel_Wings/).

To test from the Game Maker IDE from Windows, set the borrowed AppID in the Steamworks extension, and run your game while Steam is open in the background. To test within the Steam environment on Windows and/or to test on Ubuntu or SteamOS, find the executable file for the installed app whose ID you are borrowing, and replace it by renaming a built executable copy of your project with the Steamworks extension configured. Since you cannot select a Steam Input gamepad configuration setting for an app without Steamworks dashboard access, you may need to apply a generic gamepad template configuration for the app from Steam user settings.

&nbsp;

## Additional Reading

For additional details, see [Steamworks SDK documentation](https://partner.steamgames.com/doc/features/steam_controller) and the [Game Maker Steamworks Extension wiki](https://github.com/YoYoGames/GMEXT-Steamworks/wiki/Input#Input).
