$fa=1;
$fs=0.2;

hole_dia = 4.5;
module edge_helper(hole_dia=4) {
  intersection() {
    difference() {
      cube([28,50,80],true);
      cylinder(d=hole_dia,h=1000,center=true);
      translate([0,0,50]) cube([18.5,100,100],true);
      rotate([45,0,0]) rotate([0,90,0]) cube([10,10,100],true);
    }
    scale([0.7,1.2,1]) cylinder(d1=20,d2=100,h=81,center=true);
  }
}

module stand_helper() {
  module leg() {
    difference() {
      translate([0,25,20]) cube([10,50,40],true);
      rotate([-30,0,0]) translate([0,0,530]) cube([20,1000,1000],true);
      rotate([40,0,0]) cube([20,30,1000],true);
    }
  }
  module legs() {
    for(a=[0:90:360]) {
      rotate([0,0,a]) leg();
    }
  }
  difference() {
    union() {
      legs();
      intersection() {
        cylinder(d2=hole_dia+10,d1=30,h=40);
        cylinder(d2=40,d1=hole_dia+2,h=40);
      }
    }
    cylinder(d=hole_dia,h=1000,center=true);
  }
}

//stand_helper();
edge_helper(8.2);