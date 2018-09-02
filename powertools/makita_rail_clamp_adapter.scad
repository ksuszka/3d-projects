draft = false;
$fa = draft ? 12 : 3;
$fs = draft ? 2 : 0.3;

// Possible options: clamp, knob, all
show("all");

module show(part) {
  if (part == "knob") {
    knob();
  } else if (part == "clamp") {
    rotate([-90,0,0]) clamp();
  } else {
    color("MediumPurple") translate([0,10,24]) rotate([-90,0,0]) knob();
    color("DarkTurquoise")clamp();
  }
}

module cube2(size, center) {
  translate([
    center[0] ? -size[0]/2 : 0,
    center[1] ? -size[1]/2 : 0,
    center[2] ? -size[2]/2 : 0]) cube(size);
}

module clamp_rod_mold_hard_head() {
  module screw() {
    cylinder(d=6.2,h=50,center=true);
    translate([0,0,7]) cylinder(d=10*2/sqrt(3)+0.2,h=50,$fn=6);
  }
  module stop() {
    hull() {
      cylinder(d=6,h=12,center=true);
      translate([0,20,0]) cylinder(d=6.5,h=12,center=true);
    }
  }
  hull() for(x=[-1,1]) translate([x*13/2,0,-10]) cylinder(d=6, h=100);
  translate([0,0,24]) rotate([90,0,0]) screw();
  translate([0,0,43]) rotate([90,0,0]) stop();
      
}
module clamp_body() {
  intersection() {
    union() {
      hull() for(x=[-1,1]) translate([x*13/2,0,0]) cylinder(d=20,h=45);
    }
    union() {
      translate([0,0,100*sqrt(2)/2+9-4]) rotate([45,0,0])cube2([100,100,100],[true,true,true]);
      cube2([100,8,100],[true,true,true]);
    }
  }
  x1 = -30;
  x2 = 80;
  hull() for(x=[x1,x2]) translate([x,0,0]) cylinder(d=11.8,h=6.2);
  hull() for(x=[x1,x2]) translate([x,0,0]) cylinder(d=8,h=8);
  translate([0,0,24]) rotate([90,0,0])cylinder(d=15,h=7+5);
}

module clamp() {
  difference() {
    clamp_body();
    clamp_rod_mold_hard_head();
  }
}

module knob() {
  diameter1 = 25;
  height = 8;
  chamfer_r = (diameter1-5)/2;
  module chamfer() {
    rotate_extrude(convexity = 10)
      intersection() {
        translate([0,-1]) square([100,100]);
        translate([diameter1/2+3, -(chamfer_r-2), 0]) circle(r = chamfer_r, $fn = 100);
      }
  }
  difference() {
    union() {
      cylinder(d=diameter1, h=height);
      for(a=[0:30:359]) rotate([0,0,a])translate([diameter1/2-1,0,0]) cylinder(d=5,h=height);
    }
    chamfer();
    translate([0,0,-1]) cylinder(d=6.2,h=100);
    translate([0,0,3]) cylinder(d=10*2/sqrt(3),h=100,$fn=6);
  }
}

