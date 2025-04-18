// Size of the mirror glass (rectangular)s
mirror = [ 87, 51, 2 ];
$fn = 8;
difference()
{
    union()
    {
        hull()
        {
            translate([ 0, 0, 0 ]) sphere(r = 4);
            translate([ mirror[0], 0, 0 ]) sphere(r = 4);
        }
        hull()
        {
            translate([ 0, 0, 0 ]) sphere(r = 4);
            translate([ 0, mirror[1], 0 ]) sphere(r = 4);
        }
        hull()
        {
            translate([ 0, mirror[1], 0 ]) sphere(r = 4);
            translate([ mirror[0], mirror[1], 0 ]) sphere(r = 4);
        }
        hull()
        {
            translate([ mirror[0], 0, 0 ]) sphere(r = 4);
            translate([ mirror[0], mirror[1], 0 ]) sphere(r = 4);
        }
        hull()
        {
            translate([ 0, 0, 0 ]) sphere(r = 4);
            translate([ -20, 15, 0 ]) sphere(r = 4);
        }
        hull()
        {
            translate([ 0, mirror[1], 0 ]) sphere(r = 4);
            translate([ -20, mirror[1] - 15, 0 ]) sphere(r = 4);
        }
        hull()
        {
            translate([ -20, 15, 0 ]) sphere(r = 4);
            translate([ -20, mirror[1] - 15, 0 ]) sphere(r = 4);
        }
        translate([ 0, 0, 1.7 ]) cube(mirror);
    }
    cube(mirror);
}