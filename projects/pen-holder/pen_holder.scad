// Pen holder for fridge door calendar
use <../../lib/logo45.scad>;

$fn = 60;
pens = 6;
pen_diameter = 11;
pen_length = 60;
wall_width = 1.2;
component_size = pen_diameter + wall_width;

difference() {
    box();
    for(i = [0:pens-1]) {
        translate([0, i*component_size, 0])
            pen_hole();
    }
}
translate([component_size+wall_width,pens*component_size/2,pen_length/2])
    rotate([0,90,0])
        scale([0.2,0.2,1])
            linear_extrude(height=.8)
                logo45();

module pen_hole() {
    translate([pen_diameter/2+wall_width/2, pen_diameter/2, -wall_width])
        cylinder(pen_length+wall_width*4, d = pen_diameter);
}

module box() {
    hull() {
        translate([0, 0, 0])
            sphere(wall_width);
        translate([component_size, 0, 0])
            sphere(wall_width);
        translate([component_size, 0, pen_length])
            sphere(wall_width);
        translate([0, 0, pen_length])
            sphere(wall_width);
        translate([0, pens * component_size, 0])
            sphere(wall_width);
        translate([component_size, pens * component_size, 0])
            sphere(wall_width);
        translate([component_size, pens * component_size, pen_length])
            sphere(wall_width);
        translate([0, pens * component_size, pen_length])
            sphere(wall_width);
    }
}