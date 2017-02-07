$fs=0.2; // default 2
$fa=3; // default 12


//pole();
light_holder();
module light_holder() {
  module single() {
    cylinder(d=7, h=5);
  }
  module single_hole() {
    cylinder(d=5, h=30, center=true);
    translate([-1,0,54]) cube([5,100,100],true);
  }
  difference() {
    union() {
      hull() {
        translate([0,0,0]) cylinder(d=7, h=4);;
        translate([14,0,0]) cylinder(d=7, h=4);;
      }
      translate([0,0,0]) single();
      translate([7,0,0]) single();
      translate([14,0,0]) single();
    }
    union() {
      translate([0,0,0]) single_hole();
      translate([7,0,0]) single_hole();
      translate([14,0,0]) single_hole();
    }
  }
  difference() {
    union() {
      translate([3.5,0,-3.5]) cube([0.8,7,7],true);
      translate([10.5,0,-3.5]) cube([0.8,7,7],true);    
    }
    translate([0,0,-6]) cube([100,4,10],true);
  }
  
}

module head() {
  //cube([10,12,24],true);
  module outer() {
    hull() {
      translate([0,0,0]) cylinder(d=10, h=12);
      translate([14,0,0]) cylinder(d=10, h=12);
    }
  }
  module inner() {
    translate([0,0,1]) hull() {
      translate([0,0,0]) cylinder(d=7, h=12);
      translate([14,0,0]) cylinder(d=7, h=12);
    }
  }
  rotate([0,-90,0]) difference() {
    outer();
    inner();
  }
}
module pole() {
  
  difference() {
    union() {
      translate([0,0,-6]) cylinder(d=10,h=6);
      translate([0,0,0]) cylinder(d1=14,d2=6,h=10);
      translate([0,0,10]) cylinder(d=6,h=60);
      translate([5,0,73]) head();
    }
    cylinder(d=4,h=170,center=true);
  }
}
