// A rounded box with a lid
use <./logo45.scad>

$fn = 30;
// Parameters
// - dimension: [x, y, z] - x is front, y is depth, z is height (total)
//   Dimension is treated as INNER dimension, meaning walls will be added on all sides.
// - wall: number - default 2 - thickness of lid, lid edge (and hollow box of selected.
// - use_logo: boolean - default true
// - solid: boolean - default true - whether box is a solid block inside. Used for hollowing the box to create inserts.
// If false, the box will have wall*2 thickness (lid has wall*1)
// - inner_tolerance: number - default 2 - distance between lid and top of box on the inside.
module box_with_lid(dimensions = [ 40, 40, 20 ], wall = 2, use_logo = true, solid = true, inner_tolerance = 2,
                    lid_overlap = 5)
{
    printer_tolerance = 0.1; // Used to add a /little/ extra space for the lid to not get stuck
    lid_height = wall + inner_tolerance + lid_overlap;

    box_bottom();
    translate([ dimensions[0] + wall * 4, 0, 0 ]) box_lid();

    module box_bottom()
    {

        hull()
        {
            // helpers to avoid repetion below
            tr = wall; // Spheres and cylinders centers around origo
            tx = dimensions[0] - tr + wall * 2;
            ty = dimensions[1] - tr + wall * 2;
            tz = dimensions[2] - (tr + inner_tolerance) + wall;

            // Bottom
            translate([ tr, tr, tr ]) sphere(wall);
            translate([ tx, tr, tr ]) sphere(wall);
            translate([ tr, ty, tr ]) sphere(wall);
            translate([ tx, ty, tr ]) sphere(wall);
            // Top
            translate([ tr, tr, tz - lid_overlap ]) cylinder(r = wall, h = wall);
            translate([ tx, tr, tz - lid_overlap ]) cylinder(r = wall, h = wall);
            translate([ tr, ty, tz - lid_overlap ]) cylinder(r = wall, h = wall);
            translate([ tx, ty, tz - lid_overlap ]) cylinder(r = wall, h = wall);
        }

        hull()
        {
            r = wall * 0.6; // Inner radius
            // TBD: Find the right fraction for this rounding, or just use the magic number?
            tr = r + wall + printer_tolerance;
            tx = dimensions[0] - tr + wall * 2;
            ty = dimensions[1] - tr + wall * 2;
            tz = dimensions[2] - (lid_overlap + inner_tolerance) + wall;

            translate([ tr, tr, tz ]) cylinder(h = lid_overlap, r = r);
            translate([ tx, tr, tz ]) cylinder(h = lid_overlap, r = r);
            translate([ tr, ty, tz ]) cylinder(h = lid_overlap, r = r);
            translate([ tx, ty, tz ]) cylinder(h = lid_overlap, r = r);
        }
    }

    module box_lid()
    {
        lid_inner_height = lid_overlap + inner_tolerance;

        difference()
        {
            hull()
            {
                // helpers to avoid repetion below
                tr = wall; // Spheres and cylinders centers around origo
                tx = dimensions[0] - tr + wall * 2;
                ty = dimensions[1] - tr + wall * 2;
                tz = dimensions[2] - tr + wall * 2;
                tzb = tz - lid_overlap - inner_tolerance;

                // Top
                translate([ tr, tr, tz ]) sphere(wall);
                translate([ tx, tr, tz ]) sphere(wall);
                translate([ tr, ty, tz ]) sphere(wall);
                translate([ tx, ty, tz ]) sphere(wall);
                // Bottom
                translate([ tr, tr, tzb ]) cylinder(r = wall, h = wall);
                translate([ tx, tr, tzb ]) cylinder(r = wall, h = wall);
                translate([ tr, ty, tzb ]) cylinder(r = wall, h = wall);
                translate([ tx, ty, tzb ]) cylinder(r = wall, h = wall);
            }

            hull()
            {
                r = wall * 0.6; // Inner radius
                // TBD: Find the right fraction for this rounding, or just use the magic number?
                tr = r + wall;
                tx = dimensions[0] - tr + wall * 2;
                ty = dimensions[1] - tr + wall * 2;
                tz = dimensions[2] - (lid_overlap + inner_tolerance + wall) + wall * 2;
                translate([ tr, tr, tz ]) cylinder(h = lid_inner_height, r = r);
                translate([ tx, tr, tz ]) cylinder(h = lid_inner_height, r = r);
                translate([ tr, ty, tz ]) cylinder(h = lid_inner_height, r = r);
                translate([ tx, ty, tz ]) cylinder(h = lid_inner_height, r = r);
            }
        }
    }
}

box_with_lid();