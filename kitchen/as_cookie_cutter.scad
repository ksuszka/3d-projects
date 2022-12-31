//import("D:/OneDrive/Identity/AS/autonomus-only-logo.svg",center=true,96);
module logo(h) {
  a=0.16;
scale([a,a,1])linear_extrude(height=h)translate([8,3])import("d:\\Downloads\\autonomus-only-logo-_1_.svg",center=true );
}
module logo2(h) {
  a=0.16;
  minkowski() {  
scale([a,a,1])linear_extrude(height=h-2)translate([8,3])
    import("d:\\Downloads\\autonomus-only-logo-_1_.svg",center=true );
    cylinder(d1=0.5,d2=0,h=2);
  }
}

module logo_blees(h) {
  b=5.0;
  w=0.9;
  mirror([1,0])minkowski() {  
  scale([b,b,1])linear_extrude(height=h-2)translate([-2.3,-2.3])
    union() {
      translate([0,0])square([4.9,w]);
      translate([2.3,2.4])square([2.6,w]);
      translate([2.3,2.4])square([w,2.5]);
      translate([0,4])square([2.5,w]);
      translate([4,0])square([w,2.5]);
    }
    cylinder(d1=0.5,d2=0,h=2);
  }
}

module stamp_as() {
  difference() {
    union() {
      rotate([0,0,45/2])cylinder(d=50,h=5,$fn=8);
      logo(7);
    }
    translate([0,0,-.01])cylinder(d=2.7,h=4.5,$fn=24);
  }
}
module case() {
  difference() {
    rotate([0,0,45/2]) hull() {
      cylinder(d=51.5,h=1+7+7,$fn=8);
      cylinder(d=53,h=1+7+7-5,$fn=8);
    }
    translate([0,0,1])rotate([0,0,45/2])cylinder(d=50.2,h=20,$fn=8);
    cylinder(d=3,h=50,center=true,$fn=24);
  }
}
module stamp_as2() {
  difference() {
    union() {
      rotate([0,0,45/2])cylinder(d=50,h=5,$fn=8);
      logo2(7);
    }
    translate([0,0,-.01])cylinder(d=2.7,h=4.5,$fn=24);
  }
}

module stamp_blees() {
  difference() {
    union() {
      rotate([0,0,45/2])cylinder(d=50,h=5,$fn=8);
      logo_blees(7);
    }
    translate([0,0,-.01])cylinder(d=2.7,h=4.5,$fn=24);
  }
}

module handle_part1() {
  h1=10;
  h2=3;
  h3=2;
  difference() {
    union() {
      cylinder(d=8,h=h1,$fn=60);
      translate([0,0,h1+h2-h3])cylinder(d=20,h=h3,$fn=60);
      translate([0,0,h1+h2-h3-3])cylinder(d1=8,d2=20,h=4,$fn=60);
    }
    translate([0,0,h1])cylinder(d=5.5,h=10,$fn=60);
    translate([0,0,-.01])cylinder(d=3,h=h1-0.2,$fn=60);
  }
}
module handle_part2() {
  h=2;
  translate([0,0,15])mirror([0,0,1])difference() {
    union() {
      cylinder(d1=28,d2=30,h=1.01,$fn=60);
      translate([0,0,1])cylinder(d=30,h=1.01,$fn=60);
      translate([0,0,2]) {
        difference() {
          union() {
            cylinder(d=30,h=h-0.99,$fn=60);
            translate([0,0,h-1])cylinder(d1=30,d2=28,h=1,$fn=60);
          }
          cylinder(d=20,h=10,$fn=60);
        }
      }
      //cylinder(d=8,h=5,$fn=60);
      //cylinder(d=8,h=5,$fn=60);
      //translate([0,0,4])cylinder(d=20,h=1,$fn=60);
    }
    translate([0,0,-.01])cylinder(d=3,h=20,$fn=60);
  }
}

//case();
//stamp_as2();
//stamp_blees();
handle_part1();
//handle_part2();