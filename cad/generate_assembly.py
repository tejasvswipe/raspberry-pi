import FreeCAD as App
import Part

out_dir = '/home/ubuntu/tejasvswipe-raspberry-pi/cad'
doc = App.newDocument('RPi5_Touch_Case_Assembly')

def box(name, label, x, y, z, dx, dy, dz, color):
    obj = doc.addObject('Part::Feature', name)
    obj.Label = label
    obj.Shape = Part.makeBox(dx, dy, dz, App.Vector(x, y, z))
    # ViewObject is unavailable in some headless FreeCAD builds; geometry is
    # intentionally exported without relying on GUI-only display properties.
    return obj

# Coordinate system: X = width, Y = height, Z = depth; millimetres.
# The boxes are reference envelopes for purchased electronics, not manufacturer CAD.
# Case envelopes
box('RearShellEnvelope', 'Printed rear shell envelope', 0, 0, 0, 198, 130, 42, (0.72,0.72,0.76))
box('FrontBezelEnvelope', 'Printed front bezel envelope', 0, 0, 42, 198, 130, 3.2, (0.45,0.45,0.50))

# Electronics and mechanical envelopes
box('TouchDisplay2', 'Raspberry Pi Touch Display 2 7-inch envelope', 4.34, 4.88, 45.2, 189.32, 120.24, 12.8, (0.10,0.35,0.85))
box('RaspberryPi5', 'Raspberry Pi 5 8 GB envelope', 48, 35, 4, 85, 58, 18, (0.20,0.65,0.25))
box('Battery1S5000mAh', '1S 5000 mAh battery envelope - verify actual size', 8, 8, 4, 100, 50, 12, (0.80,0.20,0.20))
box('ChargerBMS', 'USB-C 1S charger + protection board envelope', 120, 8, 4, 35, 25, 8, (0.95,0.65,0.10))
box('Boost5V', '5 V boost / power-management board envelope', 120, 38, 4, 45, 28, 10, (0.95,0.45,0.10))
box('SpeakerLeft', 'Left speaker envelope', 8, 86, 4, 30, 30, 8, (0.75,0.35,0.70))
box('SpeakerRight', 'Right speaker envelope', 160, 86, 4, 30, 30, 8, (0.75,0.35,0.70))
box('AudioAmplifier', 'Audio amplifier module envelope', 120, 78, 4, 35, 25, 8, (0.55,0.25,0.70))
box('Microphone', 'Microphone module envelope', 92, 108, 4, 12, 8, 6, (0.20,0.75,0.75))
box('CameraModule3', 'Camera Module 3 envelope', 86, 130, 12, 25, 24, 11.5, (0.15,0.15,0.15))
box('ActiveCooler', 'Pi 5 active cooler envelope', 65, 50, 22, 30, 25, 8, (0.15,0.15,0.15))

# Metadata group
info = doc.addObject('App::FeaturePython', 'DesignNotes')
info.addProperty('App::PropertyString', 'DesignStatus')
info.DesignStatus = 'Envelope assembly; verify purchased part dimensions before fabrication.'
info.addProperty('App::PropertyString', 'DisplayAssumption')
info.DisplayAssumption = 'Raspberry Pi Touch Display 2 7-inch, 189.32 x 120.24 mm.'
info.addProperty('App::PropertyString', 'BatteryAssumption')
info.BatteryAssumption = 'Nominal 1S 5000 mAh pouch envelope 100 x 50 x 12 mm; measure actual cell.'
info.addProperty('App::PropertyString', 'PowerRequirement')
info.PowerRequirement = 'Use a protected 1S charger plus regulated 5 V boost converter; never connect cell directly to USB-C or Pi.'

doc.recompute()
doc.saveAs(out_dir + '/RPi5_Touch_Case_Assembly.FCStd')
try:
    Part.export([o for o in doc.Objects if hasattr(o, 'Shape') and not o.Shape.isNull()], out_dir + '/RPi5_Touch_Case_Assembly.step')
except Exception as e:
    print('STEP export warning:', e)
doc.recompute()
doc.save()
print('Created FCStd and STEP assembly files')
