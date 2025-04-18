use <../../lib/box-with-lid.scad>

// Globals
$fn = 60;
tolerance = 0.2;

// Main filter
filter_d = 60;
filter_outer_d = 70;
filter_h = 13; // lip = 1.7

// Stamp will always be stored in the filler
filler_outer_d = 60;
filler_outer_h = 20;
filler_inner_d = 58;
filler_lower_h = 14;
stamp_h = 31;

brush_t = 3.5;
brush_w = 12.2;
brush_l = 52.5;

// There is no spoon?
spoon_d = 24;
spoon_l = 96.6;
spoon_handle_t = 3;
spoon_handle_w = 13;

// Box nums
wall = 2;
width = filter_outer_d + filler_outer_d + wall + brush_t;
depth = max(filler_outer_d, filter_outer_d) + wall;
height = stamp_h + tolerance;
space = height - filler_lower_h;
echo(width, depth, height, space);

difference()
{
    box_with_lid([ width, depth, height ], wall = wall, inner_tolerance = space);
    color("pink") translate([ wall, wall, height - space + wall ]) cut_out();
}

// The cutout is modelled on Negative Z in order to be moved to top for cutting.
module cut_out()
{
    center = max(filter_outer_d / 2, filler_outer_d / 2, brush_l / 2);
    filter_r = (filter_d + tolerance) / 2;
    translate([ filter_outer_d / 2, center, -filter_h ]) cylinder(h = filter_h, r = filter_r);

    filler_r = (filler_inner_d + tolerance) / 2;
    translate([ filter_outer_d + filler_r + brush_t + wall, center, -filler_lower_h ])
        cylinder(h = filler_lower_h, r = filler_r);
    translate([ filter_outer_d, center - brush_l / 2, brush_w * -3 / 4 ])
        cube([ brush_t + tolerance, brush_l, brush_w * 3 / 4 ]);
}