/* A door for IKEA Besta systems */
$fn = 45;

// TODO: Add slot for Raspberry Pi Pico in the bottom of the door (to avoid crashing with the cabinet top)
//       Unless it can be mounted on the back of the LED panels?
// TODO: Can we split the door in OpenSCAD instead of the slicer? Would make iterating easier.

// Door outer dimensions
door_width = 596; // Confirmed
door_height = 252; // Confirmed
door_depth = 16.5; // Confirmed
// This is the thickness of the "see-through" part. 0.6mm is 3 layers at .2mm layer height
door_diffuser_thickness = 0.6;

// Hinge parameters
hinge_main_diameter = 35; // confirmed
hinge_radius = hinge_main_diameter / 2;
hinge_depth = 13.5; // confirmed
hinge_screw_diameter = 4.2; // confirmed, but we might want other screws?
hinge_screw_distance = 45.5; // confirmed
hinge_screw_side_offset = 30 - 5; // confirmed
// Offset from side of door (to center of hinge)
hinge_side_offset = 5 + hinge_radius; // confirmed
// Offset from top of door to first hinge 
top_hinge_offset = 61.5 + hinge_radius; // confirmed
// Distance between hinges (top to top)
hinge_step_distance = 32; // confirmed
hinge_distance_offset = hinge_step_distance * 4; 

// LED panel dimensions
// Sizes from https://www.digikey.no/no/products/detail/adafruit-industries-llc/2278/7035036
led_tolerance = 1.6; // Allow for some shrinkage
led_width = 254 * 2 + led_tolerance; // Confirmed
led_height = 127 + led_tolerance; // Confirmed
led_depth = door_depth - door_diffuser_thickness;

difference() {
    door();
    translate([hinge_side_offset, 
               top_hinge_offset,
               door_depth - hinge_depth])
        hinge_holes();
    translate([hinge_side_offset,
               top_hinge_offset + hinge_distance_offset,
               door_depth - hinge_depth])
        hinge_holes();
}

module hinge_holes() {
    cylinder(h=hinge_depth, d=hinge_main_diameter, center=false);
    translate([hinge_screw_side_offset - hinge_radius, hinge_screw_distance / 2, 0]) 
        cylinder(h=hinge_depth, d=hinge_screw_diameter, center=false);
    translate([hinge_screw_side_offset - hinge_radius, hinge_screw_distance / -2, 0]) 
        cylinder(h=hinge_depth, d=hinge_screw_diameter, center=false);
}

module door() {
    difference() {
        door_panel();

        // Led panel
        translate([(door_width-led_width) / 2,
                   (door_height-led_height) / 2,
                   door_diffuser_thickness])
            cube([led_width, led_height, led_depth], center=false);
    }    
}

module door_panel() {
    rounding = 1;

    // Full door
    hull() {
        translate([0,0,rounding]) 
            cube([door_width, door_height, door_depth-rounding], center=false);
        translate([rounding, rounding, rounding])
            sphere(r=rounding);
        translate([door_width-rounding, rounding, rounding])
            sphere(r=rounding);
        translate([rounding, door_height-rounding, rounding])
            sphere(r=rounding);
        translate([door_width-rounding, door_height-rounding, rounding])
            sphere(r=rounding);
    }
}