# Button Labels by Gamepad Type

---

In order to display an image or text label to match a player's gamepad device in hand, consider the following layout data 
referencing [gamepad device type](Functions-(Gamepad)#input_gamepad_get_typegamepadindex) and [binding name value](Binding-Names#gamepad).
These values are dictated by [the SDL project](https://github.com/gabomdq/SDL_GameControllerDB#mapping-guide). 
Gamepad device type can be identified with the [`gamepad_get_type`](Functions-(Players)#input_player_gamepad_get_typeplayerindex) functions, 
and binding names identified by [`input_binding_get_name`](Functions-(Bindings)#input_binding_get_namebinding).

?> Binding names are simplified below for brevity, for example, `"gamepad axis trigger r"` is shortened to **trigger r**. Refer to [Binding Names](Binding-Names#gamepad) for full strings.

&nbsp;

## Xbox and Xbox-like

| Gamepad type  | face south, east, west, north |  shoulder l, r    |  trigger l, r      |  select, start         |
|:--------------|:-----------------------------:|:-----------------:|:------------------:|:----------------------:|
|  `"xbox 360"` | ![A B X Y][xb_face]           | ![LB RB][xb_shld] | ![LT RT][xb_trggr] | ![Back Start][xb_meta] |
|  `"xbox one"` | ![A B X Y][xb_face]           | ![LB RB][xb_shld] | ![LT RT][xb_trggr] | ![View Menu][xo_meta]  |

?> Xbox Series S|X gamepads are considered Xbox One type on all platforms. Xbox-like and XInput gamepads are categorized by their closest match, eg. the Steam Controller is considered Xbox 360 type, while Stadia is considered Xbox One type.

&nbsp;

## PlayStation

| Gamepad type | face south, east, west, north             |  shoulder l, r    |  trigger l, r      |  select, start           |
|:-------------|:-----------------------------------------:|:-----------------:|:------------------:|:------------------------:|
|  `"psx"`     | ![Cross Circle Square Triangle][ps_face]  | ![L1 R1][ps_shld] | ![L2 R2][ps_trggr] | ![Sel St][ps3_meta]      |
|  `"ps4"`     | ![Cross Circle Square Triangle][ps_face]  | ![L1 R1][ps_shld] | ![L2 R2][ps_trggr] | ![Opt Menu][ps4_meta]    |
|  `"ps5"`     | ![Cross Circle Square Triangle][ps_face]  | ![L1 R1][ps_shld] | ![L2 R2][ps_trggr] | ![Create Menu][ps5_meta] |

?> The `"psx"` type encompasses all PlayStation console gamepads prior to and including the PS3, as well as PlayStation Classic gamepads.

&nbsp;

### DualShock 4 and DualSense on PS4 and PS5

| Gamepad type      |  touchpad click          |
|:------------------|:------------------------:|
|  `"ps4"`, `"ps5"` | ![Touchpad][ps_touchpad] |

?> Share and Create buttons are not available for binding on console platforms.

&nbsp;

## Switch

| Gamepad type | face south, east, west, north |  shoulder l, r       |  trigger l, r       |  select, start           |
|:-------------|:-----------------------------:|:--------------------:|:-------------------:|:------------------------:|
| `"switch"`   | ![B A Y X][nin_face]          | ![L R][nin_shld]     | ![ZL ZR][nin_trggr] | ![- +][nin_meta]         |

?> Switch Lite controls, Pro Controllers and unified pairs of JoyCons (held or docked) are considered the same on and off the Switch target platform, identified by the `"switch"` type.

&nbsp;

### JoyCons

| Gamepad type            | face south, east, west, north |  shoulder l, r    |  select, start         |
|:------------------------|:-----------------------------:|:-----------------:|:----------------------:|
| `"switch joycon left"`  | ![S W E N][jc_face]           | ![SL SR][jc_shld] | ![- Capture][jcl_meta] |
| `"switch joycon right"` | ![S W E N][jc_face]           | ![SL SR][jc_shld] | ![Home +][jcr_meta]    |

?> Input assumes individual JoyCons will be used in the [solo horizontal grip](https://en-americas-support.nintendo.com/app/answers/detail/a_id/22740/kw/#:~:text=Joy-Con%20with%20wrist-strap%20being%20held%20in%20a%20solo%20horizontal%20grip) orientation (unified as a pair they are identified as the `"switch"` type). The Capture and Home buttons (`gamepad button select`) are not available for binding on the Switch platform.

&nbsp;

## Legacy

| Gamepad type | face south, east, west, north |  shoulder l, r       |  trigger l, r         |  select, start             |
|:-------------|:-----------------------------:|:--------------------:|:---------------------:|:--------------------------:|
| `"saturn"`   | ![A B X Y][xb_face]           | ![L Z][sat_shld]     | ![R C][sat_trggr]     | *N/A*, ![Start][sat_start] |
| `"snes"`     | ![B A Y X][nin_face]          | ![L R][nin_shld]     | *N/A*                 | ![Sel St][sfc_meta]        |
| `"n64"`      | ![A B][n64_face], *N/A*, *N/A*| ![L R][n64_shld]     | ![Z][n64_trggr], *N/A*| *N/A*, ![Start][n64_start] |
| `"gamecube"` | ![A X B Y][gc_face]           | *N/A*, ![Z][gc_shld] | ![L R][gc_trggr]      | *N/A*, ![Start][gc_start]  



&nbsp;

?> For generalized directional pad appearance, see [input_gamepad_get_dpad_style](Functions-(Gamepad)#input_gamepad_get_dpad_stylegamepadindex).

*Example art courtesy https://thoseawesomeguys.com/prompts (CC0) and https://www.ssbwiki.com (CC BY-SA 3.0)*

[xb_face]: https://i.imgur.com/StIK9or.png
[xb_shld]: https://i.imgur.com/W3isGVt.png
[xb_trggr]: https://i.imgur.com/XtrPne2.png
[xb_meta]: https://i.imgur.com/S9lZyQe.png
[ps_face]: https://i.imgur.com/lBwBvfL.png
[ps_shld]: https://i.imgur.com/Y7OzYx5.png
[ps_trggr]: https://i.imgur.com/38ifmTB.png
[ps4_meta]: https://i.imgur.com/3u6CDEl.png
[ps5_meta]: https://i.imgur.com/7k8dZJI.png
[xo_meta]: https://i.imgur.com/YFmYk3A.png
[st_meta]: https://i.imgur.com/e1q0Phl.png
[lu_meta]: https://i.imgur.com/UEbKUhP.png
[ps3_meta]: https://i.imgur.com/MPT3cmA.png
[nin_face]: https://i.imgur.com/OZhHN2h.png
[nin_shld]: https://i.imgur.com/hMP8Esy.png
[nin_trggr]: https://i.imgur.com/Egetbv5.png
[nin_meta]: https://i.imgur.com/Y1HWmkF.png
[gc_face]: https://i.imgur.com/VGJomWe.png
[gc_shld]: https://i.imgur.com/DYg6lWQ.png
[gc_trggr]: https://i.imgur.com/GypmO6Z.png
[gc_start]: https://i.imgur.com/mvuPfLv.png
[sat_shld]: https://i.imgur.com/RMb1tVb.png
[sat_trggr]: https://i.imgur.com/gH6IdMN.png
[ap_start]: https://i.imgur.com/SqQJdSB.png
[oy_face]: https://i.imgur.com/dMBObGo.png
[oy_shld]: https://i.imgur.com/vNeFqhp.png
[oy_trggr]: https://i.imgur.com/vlUPSQg.png
[oy_start]: https://i.imgur.com/V6hnmz5.png
[jc_face]: https://i.imgur.com/zA8Dyj8.png
[jc_shld]: https://i.imgur.com/jCs47Mj.png
[jcl_meta]: https://i.imgur.com/fkWIGk7.png
[jcr_meta]: https://i.imgur.com/z0qdUic.png
[jcl_start]: https://i.imgur.com/rnz1dLO.png
[jcr_start]: https://i.imgur.com/gaVBBkz.png
[ps_touchpad]: https://i.imgur.com/b3Qai65.png
[sfc_meta]: https://i.imgur.com/RXRxJle.png
[sat_start]: https://i.imgur.com/c5u3a8i.png
[n64_face]: https://i.imgur.com/slfqguq.png
[n64_shld]: https://i.imgur.com/JwfK3ud.png
[n64_trggr]: https://i.imgur.com/eDYKUbW.png
[n64_start]: https://i.imgur.com/RQQWauR.png
