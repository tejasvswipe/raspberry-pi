# Software

This enclosure does not require custom microcontroller firmware. The Raspberry Pi 5 runs Raspberry Pi OS and uses standard Linux drivers and applications for the display, camera, audio amplifier, speakers, and microphone.

## Suggested setup

1. Install Raspberry Pi OS 64-bit.
2. Update the system:

```bash
sudo apt update
sudo apt full-upgrade -y
```

3. Enable/test the camera with `rpicam-hello`.
4. Test audio input/output with `arecord -l` and `aplay -l`.
5. Configure the selected audio amplifier and microphone module according to its interface: USB, I2S, or analog codec.
6. Confirm the Touch Display 2 is detected before closing the case.

## Power note

The software folder intentionally does not contain battery-charging firmware. Charging and power regulation must be handled by a correctly rated 1S charger/protection board and a 5 V boost/power-management board. The Pi should never control an unprotected Li-ion cell directly.

## Validation status

The commands above are setup guidance and have not been run against the user's exact camera, charger, audio, and microphone modules. Hardware-specific overlays or drivers may be required.
