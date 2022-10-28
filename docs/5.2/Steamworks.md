# Steamworks for Input

The official Steamworks extension allows the Input library to leverage Steam Input, enabling correct identification of XInput and virtual controllers, as well as access to extended gamepad features normally available only on console platforms including [vibration](Functions-(Vibration).md), [motion](Functions-(Motion).md), [LED color](Functions-(Color).md), and [haptic trigger effects](Functions-(Trigger-Effects).md). Input supports Steamworks through [the offical Game Maker extension](https://github.com/YoYoGames/GMEXT-Steamworks/) on Windows and Linux, including SteamOS for Steam Deck.

Once you have configured your app in the Steamworks dashboard and set up the Steamworks extension for Game Maker in your project, Input can be left to handle related features transparently, requiring no further effort specific to Steamworks support.

## Setup

1. Download and extract the [Steamworks SDK](https://partner.steamgames.com/downloads/list)
2. Download and import the latest [Steamworks Game Maker extension](https://github.com/YoYoGames/GMEXT-Steamworks/releases)
3. Configure your application for Steamworks (see below)
4. Set your AppID and Steamworks SDK location in the extension dialogue in the Game Maker IDE (see below)
5. Ensure `INPUT_USE_STEAMWORKS` in the `__input_config_general` script is `<true>`


## Configuring Steamworks

How Steam Input works depends on how your App is configured in Steamworks, and further relies on the player's Steam settings for opted-in controllers. Steam Input covers three main use scenarios:

1. Remapping gamepad input to keyboard and mouse for games that ***do not** include* gamepad support
2. Normalizing different kinds of gamepads and offering extended device features for games that ***do** include* gamepad support
3. Exclusive handling of gamepad input through [Steam Overlay](https://partner.steamgames.com/doc/features/overlay) for games that are ***solely or primarily** distributed* through Steam

Since the Input library aims to provide comprehensive cross-platform gamepad support and does not solely rely on Steam, use case #2 is relevant, sometimes called [Steam Input Gamepad Emulation](https://partner.steamgames.com/doc/features/steam_controller/steam_input_gamepad_emulation_bestpractices). 

In order to appropriately configure your app for use with the Input library, using the Steam dashboard, navigate to your app: *Steamworks > App Admin > (Your App)*. From the *Application* menu select *Steam Input* and select *Gamepad with Camera Controls*, *Gamepad with High Precision Camera/Aim*, or *Generic Gamepad*.

<img src="https://i.imgur.com/xve3seR.png">

Note that if you select *Custom Configuration*, Game Maker will no longer recieve any gamepad input from devices that are opted-in to Steam, will require you to [rely directly on the Steam Input API](https://github.com/YoYoGames/GMEXT-Steamworks/wiki/Input#Input) by configuring your game [extensively from within Steamworks](https://partner.steamgames.com/doc/features/steam_controller/iga_file), and will not work with the functions provided by Game Maker or the Input library.

The Steamworks SDK includes an example project called *Spacewar*, [(Application ID 480)](https://steamdb.info/app/480) that is the default setting when you import the YYG Steamworks Extension for Game Maker. Note that the *Spacewar* example is configured in Steamworks to use a Steam Input *Custom Configuration*, meaning it will not work with the Input library's Steamworks features, and any controller types opted-in to Steam will no longer work with Game Maker or the Input library's default features until this value is changed.

<img src="https://i.imgur.com/czFKFNj.png">

## Borrowing an AppID for Local Testing

In order for your game to use Steamworks upon release, you will need to [register with Steamworks](https://partner.steamgames.com/newpartner/) and acquire your own AppID. You cannot use Steamworks API features meaningfully upon release without registering your app through Steam. The easiest way to get set up with Steamworks is by configuring your own application. However, if during development you would like to test without configuring your own application within Steamworks, you can susbstite your AppID for another for testing purposes. 

!> Note that before distrubiting your game you will need to switch to your own AppID and make sure it is properly configured, so it is usually most convenient to use your own AppID from the outset instead of going through the additional effort to borrow an AppID as outlined below.

In order to test with a borrowed AppID, the associated app must support your target desktop OS, you must have claimed it (by downloading and installing the original app), and the app must not be configured to use a Steam Input *Custom Conifguration*. You can use the information available from the website SteamDB to check Steam Input configuration, for example the [configuration for Portal 2](https://steamdb.info/app/620/config/) uses Steam Input (indicated by *steamcontrollertemplateindex 1*), where [the configuration for Samurai Gunn 2](https://steamdb.info/app/1397790/config/) does not. For convenience, good candidates for borrowing AppID are [ideally multi-platform, free](https://store.steampowered.com/search/?sort_by=Released_DESC&maxprice=free&category1=998&category2=28&os=linux), and small in file-size, for example the game [Rebel Wings](https://store.steampowered.com/app/378090/Rebel_Wings/).

To test while running from the Game Maker IDE, while Steam is running, set the AppID in the Steamworks extension, and run your game. This method is for Windows only. To test within the Steam environment on Windows and/or to test on Ubuntu or SteamOS, find the application file for the installed app whose AppID you are borrowing, and replace the executable with a built executable of your game.

## Additional Reading

For more detail, see [Steamworks SDK](https://partner.steamgames.com/doc/features/steam_controller) documentation and the [YYG GM Steamworks Extension Wiki](https://github.com/YoYoGames/GMEXT-Steamworks/wiki/Input#Input).
