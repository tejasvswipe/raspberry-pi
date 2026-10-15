// Raspberry Pi 5 + 7-inch Touch Display 2 portable case
// Parametric design; units are millimeters.
// Export with: openscad -D part="front_bezel" ...
// Parts: front_bezel, rear_shell, camera_bracket, all

part = "all";

// ---------- Main assumptions ----------
display_w = 189.32;       // Touch Display 2 7-inch overall width
 display_h = 120.24;      // Touch Display 2 7-inch overall height
case_w = 198;
case_h = 130;
front_t = 3.2;
rear_depth = 42;
wall = 3.0;
clearance = 1.2;

// Screen/window opening; adjust after measuring the display bezel
window_w = 158;
window_h = 90;

// Electronics clearance assumptions
pi_w = 85;
pi_h = 58;
battery_w = 100;           // common 1S 5000 mAh pouch envelope; VERIFY YOUR CELL
battery_h = 50;
battery_t = 12;

$fn = 48;

module rounded_box(w, h, d, r=5) {
    hull() {
        for (x=[r,w-r]) for (y=[r,h-r])
            translate([x,y,0]) cylinder(r=r, h=d);
    }
}

module rounded_cut(w, h, d, r=4) {
    rounded_box(w,h,d,r);
}

module screw_hole(x,y,d=12,r=2.2) {
    translate([x,y,-1]) cylinder(r=r,h=d);
}

module display_mount_holes(depth=8) {
    // Four approximate display-board mounting locations; verify against your panel.
    for (p=[[8,8],[case_w-8,8],[8,case_h-8],[case_w-8,case_h-8]])
        screw_hole(p[0],p[1],depth,2.2);
}

module front_bezel() {
    difference() {
        rounded_box(case_w,case_h,front_t,6);
        translate([(case_w-window_w)/2,(case_h-window_h)/2,-1])
            rounded_cut(window_w,window_h,front_t+2,3);
        // Display mounting holes and four case assembly holes
        display_mount_holes(front_t+2);
        for (p=[[13,13],[case_w-13,13],[13,case_h-13],[case_w-13,case_h-13]])
            screw_hole(p[0],p[1],front_t+2,2.1);
    }
    // Retaining ledges behind the screen window
    for (y=[(case_h-window_h)/2-3, (case_h+window_h)/2])
        translate([(case_w-window_w)/2,y,0]) cube([window_w,3,5]);
    // Camera cable slot at top edge
    translate([case_w/2-12,case_h-4,-1]) cube([24,8,front_t+3]);
}

module rear_shell() {
    difference() {
        // Open-front tray with a 3 mm back
        rounded_box(case_w,case_h,rear_depth,6);
        translate([wall,wall,wall])
            rounded_cut(case_w-2*wall,case_h-2*wall,rear_depth,4);
        // USB-C power/charge access on right side
        translate([case_w-5,case_h/2-8,10]) rotate([0,90,0])
            rounded_cut(16,12,12,2);
        // Pi USB/Ethernet access on lower-right rear edge
        translate([case_w-5,22,22]) rotate([0,90,0])
            rounded_cut(48,15,12,2);
        // Camera ribbon / display ribbon exit slots
        translate([case_w/2-14,case_h-5,10]) cube([28,10,15]);
        translate([case_w/2-16,2,8]) cube([32,8,16]);
        // Speaker grille slots, left and right
        for (x=[18,case_w-28])
            for (y=[38,46,54,62,70])
                translate([x,y,-1]) cube([10,4,wall+2]);
        // Microphone port
        translate([case_w/2,case_h-1,-1]) cylinder(r=2.2,h=wall+2);
        // Ventilation field on rear
        for (x=[75:8:123]) for (y=[12:8:28])
            translate([x,y,-1]) cylinder(r=1.5,h=wall+2);
        // Assembly holes through back corners
        for (p=[[13,13],[case_w-13,13],[13,case_h-13],[case_w-13,case_h-13]])
            screw_hole(p[0],p[1],rear_depth+2,2.1);
    }
    // Internal Pi mounting bosses, laid out for the Pi 5 board envelope
    for (p=[[45,30],[45+58,30],[45,30+49],[45+58,30+49]]) {
        translate([p[0],p[1],wall]) difference() {
            cylinder(r=4.5,h=8);
            translate([0,0,-1]) cylinder(r=1.6,h=10);
        }
    }
    // Battery retention rails; battery dimensions are parameters above
    translate([8,8,wall]) cube([battery_w+2,2,10]);
    translate([8,battery_h+10,wall]) cube([battery_w+2,2,10]);
    // Speaker mounting rings, generic 28-36 mm speaker footprint
    for (x=[22,case_w-22]) {
        translate([x,88,wall]) difference() {
            cylinder(r=15,h=3);
            translate([0,0,-1]) cylinder(r=11,h=5);
        }
    }
    // Microphone boss
    translate([case_w/2,case_h-15,wall]) difference() {
        cylinder(r=5,h=5);
        translate([0,0,-1]) cylinder(r=2,h=7);
    }
}

module camera_bracket() {
    // Generic Camera Module 3 bracket. Camera PCB is approximately 25 x 24 mm.
    // Mount on the top edge of the enclosure; adjust lens hole for Standard/Wide lens.
    difference() {
        rounded_box(38,30,18,4);
        // Camera board pocket
        translate([6,3,3]) cube([26,24,13]);
        // Lens opening
        translate([19,31,11]) rotate([90,0,0]) cylinder(r=7,h=8);
        // Ribbon cable exit
        translate([13,-1,3]) cube([12,8,10]);
        // Two fixing holes
        translate([5,15,-1]) cylinder(r=2,h=20);
        translate([33,15,-1]) cylinder(r=2,h=20);
    }
}

if (part == "front_bezel") front_bezel();
if (part == "rear_shell") rear_shell();
if (part == "camera_bracket") camera_bracket();
if (part == "all") {
    front_bezel();
    translate([0,0,front_t+rear_depth+8]) rear_shell();
    translate([case_w/2-19,case_h+5,front_t+rear_depth+8]) camera_bracket();
}
