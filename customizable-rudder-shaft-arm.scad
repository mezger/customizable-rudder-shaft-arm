/**
 *  Customizable rudder shaft arm generator for OpenSCAD by Matthias Mezger
 *
 */

// Diameter of rudder shaft in mm
shaft_diameter=3;

// Length of arm in mm
arm_length=18;

// Thickness of arm in mm
arm_thickness=2;

// Thickness of wall around rudder shaft
wall=2.5;

// Diameter of the holes for the push rod in mm. Probably between 0.8 and 2.
arm_hole_diameter = 1.7;

// Distance between the holes in mm. Must be greater then the hole diameter. Probably between 2.1 and 5.
arm_hole_distance = 4;

/* [Hidden] */

$fn=100;
height=7.5;

difference()
{
    union()
    {
        cylinder(d=shaft_diameter+2*wall, h=height);
        translate([0.5*shaft_diameter,-2.75,0]) cube([height+wall,5.5,height]);
        //Arm
        hull() 
        {
            cylinder(d=shaft_diameter+2*wall, h=arm_thickness);
            translate([-arm_length,0,0]) cylinder(d=shaft_diameter+wall, h=arm_thickness);
        }
    }
    //Achsloch
    cylinder(d=shaft_diameter+0.15, h=height);
    //Schlitz
    translate([0,-0.75,0]) cube([height+shaft_diameter/2+wall,1.5,height]);
    //Löcher in Arm
    for(i=[shaft_diameter/2+wall+2:arm_hole_distance:arm_length]) 
        translate([-i,0,0]) cylinder(d=arm_hole_diameter, h=arm_thickness);
    //Aussparung für Mutter
    translate([shaft_diameter/2+wall+height/2,-1.75,height/2]) 
        rotate([90,0,0]) 
            scale([1.05,1.05,1]) 
                m3_mutter(2);
    //Schraubenloch
    translate([shaft_diameter/2+wall+height/2,2.75,height/2]) rotate([90,0,0]) cylinder(d=3, h=5.5); 
}

module m3_mutter(height)
{
    cylinder(h=height,r=5.5/2/cos(180/6)+0.05,$fn=6);
}