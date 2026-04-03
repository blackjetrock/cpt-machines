// CPT4200 replacement keys
//

key_scale = 1;   // Small key
key_scale = 2.23;

$fn = 40;

kr = 0.25;
kt = 13.4;
kb = 18;
kh = 9.2;

kt2 = kt/ 2;
kb2 = kb/2;
kt2r = kt2 - kr;
kb2r = kb2 - kr;
kh2 = kh/2;
kh2r = kh2-kr;

kbh = 3.0;
kbh2 = kbh/2;
kbh2r = kbh2-kr;

module pre()
{

//rotate([0, 0, 45])
//cylinder($fn=4, r2=13.4/2, r1=18/2, h= 9.2, center=true);
hull()
    {
translate([kt2r, kt2r, kh2r-1.0])
{
  sphere(r=kr, $fn = 50, center=true);
}

translate([-kt2r, -kt2r, kh2r])
{
  sphere(r=kr, $fn = 50, center=true);
}

translate([kt2r, -kt2r, kh2r])
{
  sphere(r=kr, $fn = 50, center=true);
}

translate([-kt2r, kt2r, kh2r-1.0])
{
  sphere(r=kr, $fn = 50, center=true);
}

translate([kb2r, kb2r, -kh2r])
{
  cylinder(r=kr, $fn = 50, h = 0.05, center=true);
}

translate([-kb2r, kb2r, -kh2r])
{
  cylinder(r=kr, $fn = 50, h = 0.05, center=true);
}
translate([kb2r, -kb2r, -kh2r])
{
  cylinder(r=kr, $fn = 50, h = 0.05, center=true);
}

translate([-kb2r, -kb2r, -kh2r])
{
  cylinder(r=kr, $fn = 50, h = 0.05, center=true);
}

translate([-kb2r, -kb2r, -kh2r-kbh2r])
{
  cylinder(r=kr, $fn = 50, h = kbh, center=true);
}
translate([kb2r, -kb2r, -kh2r-kbh2r])
{
  cylinder(r=kr, $fn = 50, h = kbh, center=true);
}
translate([-kb2r, kb2r, -kh2r-kbh2r])
{
  cylinder(r=kr, $fn = 50, h = kbh, center=true);
}
translate([ kb2r, kb2r, -kh2r-kbh2r])
{
  cylinder(r=kr, $fn = 50, h = kbh, center=true);
}

}

}
use </usr/share/fonts/liberation-sans-fonts/LiberationSans-Bold.ttf>

font = "Liberation Sans";
        
module legend(txt, x1, y1, sc1)
{
    scl = 0.55;
    
        translate([x1, y1, 0])
        scale([sc1, sc1, .5])

        linear_extrude(height = 2)
        {
        text(txt, center=true);
        }
    }
    
module legend2(txt1, txt2, x1, y1, sc1, x2, y2, sc2)
{
        translate([x1, y1, 1])
        scale([sc1, sc1, .5])

        linear_extrude(height = 2)
        {
        text(txt1, center=true);
        }

        translate([x2, y2, 1])
        scale([sc2, sc2, .5])

        linear_extrude(height = 2)
        {
        text(txt2, center=true);
        }

    }

module rem(n, leg1, leg2, x1, y1, sc1, x2, y2, sc2)
{
    rh = 4;

if(0) {    
    translate([0, 0, 16.8])
    rotate([-4.4, 0, 0])
    {
        cube([20, 20, 20], center=true);
    }
}

    // Dish on top
    dr = 25;
    scale([key_scale, 1, 1])    
        translate([0, 2, 30.8])
        {
            sphere(r = dr, center=true, $fn=300);
        }

    translate([-2.5, -3, 4.75])
    {
        if( n == 1 )
        {
            translate([0, 0, 0])
            legend(leg1, x1, y1, sc1);
        }
        
        if( n == 2 )
        {
            translate([0, 0, 0])
            legend2(leg1, leg2, x1, y1, sc1, x2, y2, sc2);
        }
        
    }
    
    // Hole for illumination
    translate([0, 0, 0])
    {
        cylinder(d = 6.8, h = 9.9, center=true);
    }
}

module key(n, leg1, leg2, x1, y1, sc1, x2, y2, sc2)
{
difference()
    {
        scale([2.29, 1, 1])
        pre();
        translate([0, 0, -5.1/2])
        rem(n, leg1, leg2, x1, y1, sc1, x2, y2, sc2);
    }
    
    
    // Main stem
    difference()
    {
    translate([0, 0, -10.2])
    {
        difference()
        {
        cylinder($fn = 100, d = 8.6, h = 6.3, center=true);
        cylinder($fn = 100, d = 6.8, h = 6.4, center=true);
        }
    }

    translate([0, 0, -10.8])
    cube([3.0, 10.0, 5.5], center=true);
}
}


//key(2, "SRCH", "", -1.6, 2, 0.2, -2.2, 3.5, 0.3);

//key(2, "WORD", "", -1.9, 2, 0.2, -2.2, 3.5, 0.3);
//key(2, "1", "RWD", 1.1, -0.2, 0.3, -2.2, 3.5, 0.3);
//key(2, "2", "RWD", 1.1, -0.2, 0.3, -2.2, 3.5, 0.3);
//key(2, "2", "READ", 1.1, -0.2, 0.3, -3.0, 3.5, 0.3);
//key(2, "DUP", "", -1.8, 1.6, 0.3, -2.2, 3.5, 0.3);
//key(2, "", "CODE", 1.0, -0.2, 0.3, -3.6, 1.8, 0.3);
//key(2, "REC", "", -1.8, 1.6, 0.3, -2.2, 3.5, 0.3);
//key(2, "", "LINE", 1.0, -0.2, 0.3, -2.2, 1.8, 0.3);

// PARA
//key(2, "", "PARA", 1.0, -0.2, 0.3, -3.1, 1.8, 0.3);

// PAGE
key(2, "", "PAGE", 1.0, -0.2, 0.3, -3.1, 1.8, 0.3);
// ADJ
// SRCH

// Large keys
// READ
// SKIP
// STOP
