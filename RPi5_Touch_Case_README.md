# Raspberry Pi 5 Portable Touchscreen Case

This package contains a parametric enclosure concept for:

- Raspberry Pi 5 8 GB
- Raspberry Pi Touch Display 2, 7-inch assumed
- One 1-cell 5000 mAh Li-ion/LiPo battery
- Camera Module 3-class camera
- Two small speakers
- One microphone
- USB-C charging access

## Files

- `front_bezel.stl` — front frame around the display opening
- `rear_shell.stl` — rear electronics and battery enclosure
- `camera_bracket.stl` — generic Camera Module bracket
- `assembly_preview.stl` — visual preview only; do not print as one part
- `RPi5_Touch_Case.scad` — editable OpenSCAD source

## Important fit assumptions

The design assumes the 7-inch Raspberry Pi Touch Display 2, approximately 189.32 × 120.24 mm. The screen opening is set to approximately 158 × 90 mm and may need adjustment for the actual display bezel and viewing area.

The battery cavity is based on a nominal 100 × 50 × 12 mm pouch-cell envelope. **Measure the actual 5000 mAh battery before printing.** Battery dimensions vary significantly by manufacturer.

The camera bracket is generic for a Camera Module 3-class board of approximately 25 × 24 mm. Adjust the lens opening for Standard or Wide camera variants.

## Charging and power safety

The USB-C opening is only a mechanical access opening. A single Li-ion/LiPo cell must not be connected directly to a USB-C connector, Raspberry Pi 5, or speaker circuit.

Use a proper single-cell charging and power-management board with:

1. USB-C 5 V input.
2. 1S Li-ion/LiPo CC/CV charging.
3. Battery protection / BMS.
4. A regulated 5 V output capable of powering the Raspberry Pi 5 under load.
5. Appropriate thermal and current protection.

The Raspberry Pi 5 can have high peak current demand. Select the power board, wiring, connector, and battery for the required current. Do not charge or operate an unattended damaged, swollen, or overheated cell.

## Suggested assembly

1. Test-fit the display, Pi, battery, charger/power board, speakers, microphone, and camera before final printing.
2. Mount the display behind the front bezel.
3. Mount the Raspberry Pi on the internal bosses and route the display ribbon through the lower slot.
4. Place the battery in the left-side retention area and secure it with non-metallic restraint; do not compress or puncture the cell.
5. Mount speakers over the internal speaker rings and place the microphone near the top microphone port.
6. Install the camera bracket on the top edge and route the camera ribbon through the cable slot.
7. Use M2/M2.5/M3 hardware according to the actual board mounting holes; the generated bosses are generic and may need drilling or inserts.
8. Print the front bezel and rear shell separately. The assembly preview is for visualization only.

## OpenSCAD customization

At the top of `RPi5_Touch_Case.scad`, change:

- `window_w`, `window_h` for the display opening.
- `battery_w`, `battery_h`, `battery_t` for the actual battery envelope.
- `case_w`, `case_h`, and `rear_depth` for the overall enclosure.

Export each part with OpenSCAD using the `part` variable:

```bash
openscad -o front_bezel.stl -D 'part="front_bezel"' RPi5_Touch_Case.scad
openscad -o rear_shell.stl -D 'part="rear_shell"' RPi5_Touch_Case.scad
openscad -o camera_bracket.stl -D 'part="camera_bracket"' RPi5_Touch_Case.scad
```
