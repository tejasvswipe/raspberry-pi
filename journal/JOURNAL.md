# Project Journal

## 2026-10-15 — Initial enclosure architecture

The project was organized as a two-piece printable enclosure with a separate camera bracket. The design targets a 7-inch Raspberry Pi Touch Display 2 and leaves the rear shell for the Pi 5, battery, charging/power boards, audio amplifier, speakers, and microphone.

![Assembly overview](../docs/assembly_overview.svg)

**Status:** printable STL parts and editable OpenSCAD source are present. Battery and purchased electronics remain envelope assumptions until measured.

## 2026-10-15 — Power and custom-PCB review

The enclosure uses purchased charger/protection, 5 V boost, audio, camera, and display modules. There is no project-specific PCB to route, so KiCad/EasyEDA source and gerbers are not applicable to this revision. A proper protected 1S charging and regulated 5 V power path is required before assembly.

![Power and signal wiring](../docs/wiring_diagram.svg)

![Custom PCB status](../docs/pcb_not_applicable.svg)

**Status:** wiring is a reference architecture, not a tested production schematic. Confirm the exact charger, boost converter, speaker amplifier, and microphone interfaces before wiring.

## 2026-10-15 — CAD handoff

A FreeCAD assembly was added with editable envelope models for the enclosure and purchased electronics. The STEP export is intended for fit review and includes labeled reference envelopes, not manufacturer-certified component CAD.

![Assembly overview](../docs/assembly_overview.svg)

**Status:** fit checks are still required for the actual 5000 mAh battery, display mounting pattern, audio boards, charger, and boost converter.
