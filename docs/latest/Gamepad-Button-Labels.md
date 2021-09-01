# Button Labels by Gamepad Type

---

In order to display an image or text label that matches a player's device in hand, consider the following data, 
referencing [device type](Functions-(Gamepad)#input_gamepad_get_typegamepadindex) and [binding name values](Binding-Names#gamepad).
Device type can be identified with [`input_player_gamepad_get_type`](Functions-(Players)#input_player_gamepad_get_typeplayerindex), 
and binding names can be identified with [`input_binding_get_name`](Functions-(Bindings)#input_binding_get_namebinding).

&nbsp;

### Xbox and Xbox-like

| Gamepad type             |`face south, east, west, north`| `shoulder l, r`   | `trigger l, r`     | `select, start`          |
|:-------------------------|:-----------------------------:|:-----------------:|:------------------:|:------------------------:|
| `"xbox 360", "steam"`    | ![A B X Y][xb_face]           | ![LB RB][xb_shld] | ![LT RT][xb_trggr] | ![Back Start][xb_meta]   |
| `"xbox one"`             | *As above*                    | *As above*        | *As above*         | ![View Menu][xo_meta]    |
| `"luna"`                 | *As above*                    | *As above*        | *As above*         | ![Action Menu][lu_meta]  |
| `"stadia"`               | *As above*                    | ![L1 R1][ps_shld] | ![L2 R2][ps_trggr] | ![Options Menu][st_meta] |

### PlayStation

| Gamepad type |`face south, east, west, north`            | `shoulder l, r`   | `trigger l, r`     | `select, start`          |
|:-------------|:-----------------------------------------:|:-----------------:|:------------------:|:------------------------:|
| `"psx"`      | ![Cross Circle Square Triangle][ps_face]  | ![L1 R1][ps_shld] | ![L2 R2][ps_trggr] | ![Sel St][ps3_meta]      |
| `"ps4"`      | *As above*                                | *As above*        | *As above*         | ![Opt Menu][ps4_meta]    |
| `"ps5"`      | *As above*                                | *As above*        | *As above*         | ![Create Menu][ps5_meta] |


### Nintendo

| Gamepad type |`face south, east, west, north`| `shoulder l, r`      | `trigger l, r`      | `select, start`          |
|:-------------|:-----------------------------:|:--------------------:|:-------------------:|:------------------------:|
|`"switch"`    | ![B A Y X][nin_face]          | ![L R][nin_shld]     | ![ZL ZR][nin_trggr] | ![- +][nin_meta]         |
|`"snes"`      | *As above*                    | *As above*           | *N/A*               | ![Sel St][sfc_meta]      |
|`"gamecube"`  | ![A X B Y][gc_face]           | *N/A*, ![Z][gc_shld] | ![L R][gc_trggr]    | *N/A*, ![Start][gc_start]|

?> Switch Pro Controllers and JoyCon pairs are handled the same on and off the Switch target platform, identified by the type string `"switch"`.

### Misc.

| Gamepad type |`face south, east, west, north`| `shoulder l, r`  | `trigger l, r`     | `start`             |
|:-------------|:-----------------------------:|:----------------:|:------------------:|:-------------------:|
| `"saturn"`   | ![A B X Y][xb_face]           | ![L Z][sat_shld] | ![R C][sat_trggr]  | ![Start][sat_start] |
| `"apple"`    | *As above*                    | ![L1 R1][ps_shld]| ![L2 R2][ps_trggr] | ![Pause][ap_start]  |
| `"ouya"`     | ![O A U Y][oy_face]           | *As above*       | *As above*         | ![Start][oy_start]  |


### JoyCons on Desktop and Android Platforms

| Gamepad type          |`face south, east, west, north`| `shoulder l, r`   | `select, start`        |
|:----------------------|:-----------------------------:|:-----------------:|:----------------------:|
|`"switch joycon left"` | ![S W E N][jc_face]           | ![SL SR][jc_shld] | ![- Capture][jcl_meta] |
|`"switch joycon right"`| *As above*                    | *As above*        | ![Home +][jcr_meta]    |


### JoyCons on the Nintendo Switch Platform

| Gamepad type          | `select` | `start`         |
|:----------------------|:--------:|:---------------:|
|`"switch joycon left"` | *N/A*    | ![-][jcl_start] |
|`"switch joycon right"`| *N/A*    | ![+][jcr_start] |


### DualShock 4 and DualSense on PS4 and PS5

| Gamepad type   | `touchpad click`       |
|:---------------|:----------------------:|
| `"ps4", "ps5"` | ![Touchpad][ps_touchpad] |

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
[gc_shld]: https://i.imgur.com/0nt3DqX.png
[gc_trggr]: https://i.imgur.com/GypmO6Z.png
[gc_start]: https://i.imgur.com/9aYN8sf.png
[sat_shld]: https://i.imgur.com/RMb1tVb.png
[sat_trggr]: https://i.imgur.com/gH6IdMN.png
[ap_start]: https://i.imgur.com/SqQJdSB.png
[oy_face]: https://i.imgur.com/dMBObGo.png
[oy_start]: https://i.imgur.com/V6hnmz5.png
[jc_face]: https://i.imgur.com/zA8Dyj8.png
[jc_shld]: https://i.imgur.com/jCs47Mj.png
[jcl_meta]: https://i.imgur.com/Cr0AhNw.png
[jcr_meta]: https://i.imgur.com/z0qdUic.png
[jcl_start]: https://i.imgur.com/6QfR7P1.png
[jcr_start]: https://i.imgur.com/ssgumqj.png
[ps_touchpad]: https://i.imgur.com/b3Qai65.png
[sfc_meta]: https://i.imgur.com/RXRxJle.png
[sat_start]: https://i.imgur.com/c5u3a8i.png
