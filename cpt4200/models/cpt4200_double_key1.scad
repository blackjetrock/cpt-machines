// CPT4200 replacement double keys
//

key_scale = 1;   // Small key

double_key = 1;

//key_scale = 2.23;

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

module flat_shell()
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

module dish_sphere()
{
  // Dish on top
  dr = 25;
  scale([key_scale, 1, 1])    
    translate([0, 2, 30.8])
    {
      sphere(r = dr, center=true, $fn=300);
    }
}

module pre_shell()
{
  difference()
    {
      flat_shell();
      translate([0, 0, -2.5])
      dish_sphere();
    }
}


ccx = 30;
ccy = 30;
ccz = 30;

dk_mid_len = 35.45 - 15.0 - 1.45;

total_width = dk_mid_len + kb;

echo("Total width=", total_width);

module left_shell()
{
  translate([-dk_mid_len/2, 0, 0])
    difference()
    {
      pre_shell();
      translate([ccx/2, 0, 0])
        {
          cube([ccx, ccy, ccz], center=true);
        }
    }   
}

module right_shell()
{
  translate([dk_mid_len/2, 0, 0])
    difference()
    {
      pre_shell();
      translate([-ccx/2, 0, 0])
        {
          cube([ccx, ccy, ccz], center=true);
        }
    }   
}

shell_slice_x = 0.01;
shell_factor = 1/shell_slice_x;

module mid_shell()
{
    
  // A 1mm slice of the middle of the key
  difference()
    {
      pre_shell();
      translate([ccx/2+shell_slice_x, 0, 0])
        {
          cube([ccx, ccy, ccz], center=true);
        }
      translate([-ccx/2-shell_slice_x, 0, 0])
        {
          cube([ccx, ccy, ccz], center=true);
        }

    }   
}

module pre()
{
  if(!double_key)
    {
      pre_shell();
    }
  else
    {
      left_shell();
        
      // Scale by the length
      scale([dk_mid_len*shell_factor/2, 1, 1])

      mid_shell();
      right_shell();
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


  translate([-2.5, -3, 4.75])
    {
      if( n == 1 )
        {
          translate([0, 0, -0.1])
            legend(leg1, x1, y1, sc1);
        }
        
      if( n == 2 )
        {
          translate([0, 0, -0.1])
            legend2(leg1, leg2, x1, y1, sc1, x2, y2, sc2);
        }
        
    }
    
  // Hole for illumination
  translate([0, 0, 0])
    {
      cylinder(d = 6.8, h = 9.9, center=true);
    }

  // Open up inside the top of the key to provide mor eeven illuminationm
  translate([0, 0, 3.95])
    {
        if ( double_key )
        {
           cube([37-10, 8.6, 2], center=true);

        }
        else
        {
           cube([18-10, 8.6, 2], center=true);
        }
    }
    
  translate([0, 0, -3.26])
    {
        $fn = 200;
        
      difference()
        {
        cylinder(d = 13.8, h = 2.6, center=true);
        cylinder(d = 8.6,  h = 2.65, center=true);
        }
    }
  
}

module key(n, leg1, leg2, x1, y1, sc1, x2, y2, sc2)
{
  difference()
    {
      scale([key_scale, 1, 1])
        pre();
      translate([0, 0, -5.1/2])
        rem(n, leg1, leg2, x1, y1, sc1, x2, y2, sc2);
    }
    
    
    // Keying bumps
    difference()
    {
      {
          translate([0, 0, -5])
          rotate([90, 0, 0])
          {
           cylinder(h=10.3, r=1.4/2, $fn=50, center=true);
          }
      }
      
    translate([0, 0, -4])
    cylinder($fn = 100, d = 8.6, h = 6.3, center=true);
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

slcx = 50;
slcy = 50;
slcz = 50;

module key2(n, leg1, leg2, x1, y1, sc1, x2, y2, sc2)
{

difference()
  {
  key(n, leg1, leg2, x1, y1, sc1, x2, y2, sc2);
      if(1)
      {
  translate([-slcx/2, 0, 0])
      {
          cube([slcx, slcy, slcz], center=true);
      }
  }
  }
}

//key(2, "1", "RWD", 1.1, -0.2, 0.3, -2.2, 3.5, 0.3);
//key(2, "2", "RWD", 1.1, -0.2, 0.3, -2.2, 3.5, 0.3);
//key(2, "2", "READ", 1.1, -0.2, 0.3, -3.0, 3.5, 0.3);
//key(2, "DUP", "", -1.8, 1.6, 0.3, -2.2, 3.5, 0.3);
//key(2, "", "CODE", 1.0, -0.2, 0.3, -3.6, 1.8, 0.3);
//key(2, "REC", "", -1.8, 1.6, 0.3, -2.2, 3.5, 0.3);

//key(2, "WORD", "", -1.9, 2, 0.2, -2.2, 3.5, 0.3);
//key(2, "", "LINE", 1.0, -0.2, 0.3, -2.2, 1.8, 0.3);
//key(2, "", "PARA", 1.0, -0.2, 0.3, -3.1, 1.8, 0.3);
//key(2, "", "PAGE", 1.0, -0.2, 0.3, -3.1, 1.8, 0.3);
//key(2, "ADJ", "", -1.6, 1.6, 0.3, -2.2, 3.5, 0.3);
//key(2, "SRCH", "", -1.6, 2, 0.2, -2.2, 3.5, 0.3);

// Large keys
// READ
//key(2, "READ", "", -3.1, 1.6, 0.3, -2.2, 3.5, 0.3);

// SKIP
//key(2, "SKIP", "", -2.8, 1.6, 0.3, -2.2, 3.5, 0.3);

// STOP
key(2, "STOP", "", -3.1, 1.6, 0.3, -2.2, 3.5, 0.3);

//mid_shell();


// Measuring stick
if( 0 )
  {
  translate([0, 0, -7])
  cube([37, 2, 2], center=true);
  }
  
 