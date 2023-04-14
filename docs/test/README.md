<img src="https://raw.githubusercontent.com/JujuAdams/Input/master/LOGO.png" width="50%" style="display: block; margin: auto;" />
<h1 align="center">Input 5.5</h1>
<p align="center">Comprehensive cross-platform input for GameMaker 2022 LTS by <a href="https://www.jujuadams.com/" target="_blank">Juju Adams</a> and <a href="https://twitter.com/offalynne" target="_blank">Alynne Keith</a></p>

<p align="center"><a href="https://github.com/JujuAdams/Input/releases/" target="_blank">Download the .yymps</a></p>
<p align="center">Talk about Input on the <a href="https://discord.gg/8krYCqr" target="_blank">Discord server</a></p>

---

Input is a robust, feature-packed input library that unifies keyboard, mouse, and gamepad control under one umbrella. It handles hotswapping, rebinding, gamepad type detection, player gamepad assignment, thumbstick min/max deadzones etc. all without you lifting a finger. This library strips away the boring repetitive task of getting every gamepad for every platform set up perfectly, and accelerates the development of your game.

Input is built on top of the engine agnostic [SDL2 remapping system](https://github.com/gabomdq/SDL_GameControllerDB) and uses community contributed binding for every common gamepad, and many gamepads you've probably never heard of. Because it's built on community contributions made over many years, SDL2 and Input have excellent coverage of all the weird and wonderful input devices that exist. It's rare to find a device that SDL2 doesn't support.

This library is a significant improvement on GameMaker's native gamepad implementation, which is fraught with cross-platform inconsistencies and the occasional show-stopping bug. It's a massive step up from GameMaker's barebones gamepad and keyboard implementations.

?> Input is a really big library! To get up and running fast, check out our [Newbie Guide](Newbie-Guide).

---

**What platforms does Input support?**

Everything! You might run into edge cases on platforms that we don't regularly test; please [report any bugs](https://github.com/JujuAdams/Input/issues) if and when you find them.

&nbsp;

**What versions of GameMaker does Input support?**

Version 5 of Input primarily supports GameMaker LTS 2022, and in theory supports every version of GameMaker later than that. Later versions of GameMaker may change functionality in a way that Input is not forwards-compatible with, but Input uses only native GameMaker functions so is in the best possible position for long-term compatibility.

&nbsp;

**How is Input licensed? Can I use it for commercial projects?**

[Input is released under the MIT license](https://github.com/JujuAdams/Input/blob/master/LICENSE). This means you can use it for whatever purpose you want, including commercial projects. It'd mean a lot to me if you'd drop our names in the credits (Juju Adams and Alynne Keith) and/or say thanks, but you're under no obligation to do so.

&nbsp;

**I think you're missing a useful feature and I'd like you to implement it!**

Great! Please make a [feature request](https://github.com/JujuAdams/Input/issues). Feature requests make Input a more fun tool to use and gives me something to think about when I'm bored on public transport.

&nbsp;

**I found a bug, and it both scares and mildly annoys me. What is the best way to get the problem solved?**

Please make a [bug report](https://github.com/JujuAdams/Input/issues). We check GitHub every day and bug fixes usually go out a couple days after that. You can also grab us on the [Discord server](https://discord.gg/8krYCqr), but that's not a replacement for a nice clear bug report.

&nbsp;

**Who made Input?**

Input is primarily built and maintained by [Juju](https://www.jujuadams.com/) and [Alynne]([https://twitter.com/offalynne](https://offalynne.neocities.org/)) who have been writing and rewriting input systems for a long time. Juju's worked on a lot of [commercial GameMaker games](http://www.jujuadams.com/) and Alynne has been [active in indie dev](https://offalynne.neocities.org/) for years. Input is the product of our combined practical experience working as consultants.

Many, many other people have contributed to GameMaker's open source community via bug reports and feature requests. Input wouldn't exist without them and we're eternally grateful for their creativity and patience. You can read [Input's credits here](Credits)

&nbsp;

**Can I send you donations? Are you going to start a Patreon?**

Thank you for wanting to show your appreciation - it really does mean a lot to us personally - but we're fortunate enough to have a stable income from gamedev. We're not looking to join Patreon as a creator at this moment in time. If you'd like to support our work then drop us a credit in your game and/or give a shout-out on the social media platform of your choice.
