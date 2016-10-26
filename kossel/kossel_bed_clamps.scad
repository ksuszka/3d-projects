$fa=3;
$fs=0.1;

bed_diameter = 250;
bed_height = 3;
clamp_height = 7;

//demo();
bed_clamp();

module demo() {
    %translate([0,0,clamp_height/2]) bed_mold();
    bed_clamp();
    rotate([0,0,120]) bed_clamp();
    rotate([0,0,240]) bed_clamp();
}

module bed_mold() {
    translate([0,0,bed_height/2])
        intersection() {
            translate([0,0,0.1])cylinder(d=bed_diameter, h=bed_height+0.2, center=true);
            translate([0,0,-bed_diameter/3]) sphere(d=bed_diameter*1.203);
        }
}

module bed_clamp() {
    width = 30;
    hole_diameter = 3;
    hole_screw_diameter = 6;
    bottom_length = 20;
    module body_mold() {
        translate([0,0,clamp_height/2]) {
            cylinder(d=width, h=clamp_height, center=true);
            translate([0,bottom_length/2,0])
                cube([width,bottom_length,clamp_height], center=true);
        }
    }
    module hole_mold() {
        translate([0,-6,clamp_height/2]) {
            cylinder(d=hole_diameter, h=clamp_height+1, center=true);
            translate([0,0,clamp_height-bed_height])
                cylinder(d=hole_screw_diameter, h=clamp_height, center=true);
        }
    }
    module edge() {
        translate([0,0,clamp_height/2])
            difference() {
                cylinder(d=bed_diameter+6,h=clamp_height, center=true);
                cylinder(d=bed_diameter-20,h=clamp_height+1, center=true);
                translate([0,0,2]) cylinder(d=bed_diameter,h=clamp_height, center=true);
            }
    }
    module pie() {
        intersection() {
            edge();
            rotate([0,0,60])translate([-500,0,0]) cube([1000,1000,1000],true);
            rotate([0,0,-60])translate([500,0,0]) cube([1000,1000,1000],true);
        }
    }
    difference() {
        union() {
            translate([0,-bed_diameter/2+1,0]) body_mold();
            pie();
        }
        translate([0,0,clamp_height-bed_height]) bed_mold();
        translate([0,-bed_diameter/2+1,0]) hole_mold();
    }
}


