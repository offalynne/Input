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

<div class="table-wrapper">
<table>
	<thead>
		<tr>
		<th align="left">Gamepad type</th>
		<th align="center">face south, east, west, north</th>
		<th align="center">shoulder l, r</th>
		<th align="center">trigger l, r</th>
		<th align="center">select, start</th>
		</tr>
	</thead>
	<tbody>
		<tr>
			<td align="left"><code>"xbox 360"</code></td>
			<td rowspan="2" align="center"><img src="https://i.imgur.com/StIK9or.png" alt="A B X Y"></td>
			<td rowspan="2" align="center"><img src="https://i.imgur.com/W3isGVt.png" alt="LB RB"></td>
			<td rowspan="2" align="center"><img src="https://i.imgur.com/XtrPne2.png" alt="LT RT"></td>
			<td align="center"><img src="https://i.imgur.com/S9lZyQe.png" alt="Back Start"></td>
		</tr>
	<tr>
		<td align="left"><code>"xbox one"</code></td>
		<td align="center"><img src="https://i.imgur.com/YFmYk3A.png" alt="View Menu"></td>
	</tr>
	</tbody>
</table>
</div>

?> Xbox Series S|X gamepads are considered Xbox One type on all platforms. Xbox-like and XInput gamepads are categorized by their closest match, eg. the Steam Controller is considered Xbox 360 type, while Stadia is considered Xbox One type.

&nbsp;

## PlayStation

<div class="table-wrapper">
<table>
	<thead>
	<tr>
		<th align="left">Gamepad type</th>
		<th align="center">face south, east, west, north</th>
		<th align="center">shoulder l, r</th>
		<th align="center">trigger l, r</th>
		<th align="center">select, start</th>
	</tr>
	</thead>
    <tbody>
    <tr>
		<td align="left"><code>"psx"</code></td>
		<td rowspan="3" align="center"><img src="https://i.imgur.com/lBwBvfL.png" alt="Cross Circle Square Triangle"></td>
		<td rowspan="3" align="center"><img src="https://i.imgur.com/Y7OzYx5.png" alt="L1 R1"></td>
		<td rowspan="3" align="center"><img src="https://i.imgur.com/38ifmTB.png" alt="L2 R2"></td>
		<td align="center"><img src="https://i.imgur.com/MPT3cmA.png" alt="Sel St"></td>
	</tr>
	<tr>
		<td align="left"><code>"ps4"</code></td>
		<td align="center"><img src="https://i.imgur.com/3u6CDEl.png" alt="Opt Menu"></td>
	</tr>
	<tr>
		<td align="left"><code>"ps5"</code></td>
		<td align="center"><img src="https://i.imgur.com/7k8dZJI.png" alt="Create Menu"></td>
	</tr>
	</tbody>
</table>
</div>

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

<div class="table-wrapper">
<table>
	<thead>
	<tr>
		<th align="left">Gamepad type</th>
		<th align="center">face south, east, west, north</th>
		<th align="center">shoulder l, r</th>
		<th align="center">select, start</th>
	</tr>
	</thead>
	<tbody>
	<tr>
		<td align="left"><code>"switch joycon left"</code></td>
		<td rowspan="2" align="center"><img src="https://i.imgur.com/zA8Dyj8.png" alt="S W E N"></td>
		<td rowspan="2" align="center"><img src="https://i.imgur.com/jCs47Mj.png" alt="SL SR"></td>
		<td align="center"><img src="https://i.imgur.com/fkWIGk7.png" alt="- Capture"></td>
	</tr>
	<tr>
		<td align="left"><code>"switch joycon right"</code></td>
		<td align="center"><img src="https://i.imgur.com/z0qdUic.png" alt="Home +"></td>
	</tr>
	</tbody>
</table>
</div>
	
?> Input assumes individual JoyCons will be used in the [solo horizontal grip](https://en-americas-support.nintendo.com/app/answers/detail/a_id/22740/kw/#:~:text=Joy-Con%20with%20wrist-strap%20being%20held%20in%20a%20solo%20horizontal%20grip) orientation (unified as a pair they are identified as the `"switch"` type). The Capture and Home buttons (`gamepad button select`) are not available for binding on the Switch platform.

&nbsp;

## Legacy

<div class="table-wrapper">
<table>
    <thead>
    <tr>
		<th align="left">Gamepad type</th>
		<th colspan="4" align="center">face south, east, west, north</th>
		<th colspan="2" align="center">shoulder l, r</th>
		<th colspan="2" align="center">trigger l, r</th>
		<th colspan="2" align="center">select, start</th>
	</tr>
	</thead>
	<tbody>
	<tr>
		<td align="left"><code>"snes"</code></td>
		<td colspan="4" align="center"><img src="https://i.imgur.com/OZhHN2h.png" alt="B A Y X"></td>
		<td colspan="2" align="center"><img src="https://i.imgur.com/hMP8Esy.png" alt="L R"></td>
		<td colspan="2" align="center"><em>N/A</em></td>
		<td colspan="2" align="center"><img src="https://i.imgur.com/RXRxJle.png" alt="Sel St"></td>
	</tr>
	<tr>
		<td align="left"><code>"saturn"</code></td>
		<td colspan="4" align="center"><img src="https://i.imgur.com/StIK9or.png" alt="A B X Y"></td>
		<td colspan="2" align="center"><img src="https://i.imgur.com/RMb1tVb.png" alt="L Z"></td>
		<td colspan="2" align="center"><img src="https://i.imgur.com/gH6IdMN.png" alt="R C"></td>
		<td rowspan="3" align="center"><em>N/A</em></td>
		<td align="center"><img src="https://i.imgur.com/c5u3a8i.png" alt="Start"></td>
	</tr>
	<tr>
		<td align="left"><code>"n64"</code></td>
		<td colspan="2" align="center"><img src="https://i.imgur.com/slfqguq.png" alt="A B"></td>
		<td align="center"><em>N/A</em></td>
		<td align="center"><em>N/A</em></td>
		<td colspan="2" align="center"><img src="https://i.imgur.com/JwfK3ud.png" alt="L R"></td>
		<td align="center"><img src="https://i.imgur.com/eDYKUbW.png" alt="Z"></td>
		<td align="center"><em>N/A</em></td>
		<td align="center"><img src="https://i.imgur.com/9fRnJet.png" alt="Start"></td>
	</tr>
	<tr>
		<td align="left"><code>"gamecube"</code></td>
		<td colspan="4" align="center"><img src="https://i.imgur.com/VGJomWe.png" alt="A X B Y"></td>
		<td align="center"><em>N/A</em></td>
		<td align="center"><img src="https://i.imgur.com/DYg6lWQ.png" alt="Z"></td>
		<td colspan="2" align="center"><img src="https://i.imgur.com/GypmO6Z.png" alt="L R"></td>
		<td align="center"><img src="https://i.imgur.com/mvuPfLv.png" alt="Start"></td>
	</tr>
	</tbody>
</table>
</div>

?> On the N64 controller type, [`"gamepad thumbstick r"` directions](Binding-Names#gamepad) indicate [C buttons](https://www.ssbwiki.com/Category:Button_icons_(N64)#/media/File:ButtonIcon-N64-C.svg).

&nbsp;

## Directional Pads

For generalized directional pad appearance, see [`input_gamepad_get_dpad_style`](Functions-(Gamepad)#input_gamepad_get_dpad_stylegamepadindex).

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
[n64_start]: https://i.imgur.com/9fRnJet.png
