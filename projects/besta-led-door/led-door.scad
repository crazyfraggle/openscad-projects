/* A door for IKEA Besta systems */

// TODO: Add slot for Raspberry Pi Pico in the bottom of the door (to avoid crashing with the cabinet top)
// TODO: Get real measurements for the below numbers.
// Door outer dimensions
door_width = 585;
door_height = 280;
door_depth = 18;
// This is the thickness of the "see-through" part.
door_diffuser_thickness = 0.6;

// Hinge parameters
hinge_main_diameter = 30;
hinge_depth = 10;
hinge_screw_diameter = 5;
hinge_screw_distance = 30;
hinge_screw_side_offset = 30;
hinge_side_offset = 5; // Offset from side of door
top_hinge_offset = 25; // Offset from top of door to first hinge
hinge_distance_offset = 200; // Distance between hinges (top to top)

// LED panel dimensions
led_tolerance = 0.4; // Allow for some shrinkage
led_width = 500 + led_tolerance;
led_height = 145 + led_tolerance;
led_depth = door_depth-door_diffuser_thickness;

difference() {
    door();
    translate([hinge_side_offset+(hinge_main_diameter/2), 
               top_hinge_offset+(hinge_main_diameter/2),
               door_depth-hinge_depth+.01])
        hinge_holes();
    translate([hinge_side_offset+(hinge_main_diameter/2),
               top_hinge_offset+hinge_distance_offset+(hinge_main_diameter/2),
               door_depth-hinge_depth+.01])
        hinge_holes();
}


module hinge_holes() {
    hinge_radius = hinge_main_diameter/2;
    cylinder(h=hinge_depth, d=hinge_main_diameter, center=false);
    translate([hinge_screw_side_offset - hinge_radius, hinge_screw_distance/2, 0]) 
        cylinder(h=hinge_depth, d=hinge_screw_diameter, center=false);
    translate([hinge_screw_side_offset - hinge_radius, hinge_screw_distance/-2, 0]) 
        cylinder(h=hinge_depth, d=hinge_screw_diameter, center=false);
}

module door() {
    difference() {
        // Full door
        cube([door_width, door_height, door_depth], center=false);
        // Led panel
        translate([(door_width-led_width)/2, (door_height-led_height)/2, door_diffuser_thickness+.01])
            cube([led_width, led_height, led_depth], center=false);
    }
    
}