
module spacer1() {
  difference() {
    union() {
      cylinder(d=12,h=5,$fn=36);
      cylinder(d=7,h=6,$fn=36);
    }
    cylinder(d=4.5,h=100,center=true,$fn=36);
  }
}
module spacer2() {
  difference() {
    cylinder(d=14,h=1.7,$fn=36);
    translate([0,0,0.7]) {
      cylinder(d=9,h=10,$fn=36);
      translate([0,3,5])cube([3,5,10],true);
    }
    cylinder(d=5.5,h=100,center=true,$fn=36);
  }
}

module voltmeter_holder() {
  difference() {
    union() {
      cube([34,22,5],true);
    }
    cube([23.5,15,20],true);
    for(a=[0,1])mirror([a,0])translate([14,0]) cylinder(d=2,h=20,center=true,$fn=24);
  }
}
module fuse_holder() {
  difference() {
    union() {
      translate([-7,-7])cube([7+7+12,7+7+30+12,5]);
    }
    for(xy=[[0,0],[0,30],[12,42]]) translate(xy)
      cylinder(d=6,h=20,center=true,$fn=36);
    for(xy=[[10,0],[0,42],[12,30]]) translate(xy)
      cylinder(d=2.5,h=20,center=true,$fn=36);
  }
}

fuse_holder();
