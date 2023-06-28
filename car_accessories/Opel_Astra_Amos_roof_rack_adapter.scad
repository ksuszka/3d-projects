

module spacer() {
  difference() {
    intersection() {
      translate([0,0,2])rotate([0,90+3,0])cylinder(d=34,h=100,center=true,$fn=72);
      translate([0,0,30])cube([50,50,50],true);
    }
    rotate([0,90,0])cylinder(d=33,h=100,center=true,$fn=72);
    hull()for(a=[-1,1])rotate([a*5,0]) cylinder(d=9,h=30,$fn=24);
  }
}

module knob() {
  difference() {
    union() {
      cylinder(d=20,h=7,$fn=72);
      translate([0,0,1]) {
        cylinder(d=33,h=7,$fn=72);
        for(a=[0:60:360])rotate([0,0,a])translate([15,0])cylinder(d=10,h=7,$fn=36);
        }
    }
    translate([0,0,2])cylinder(d=10*2/sqrt(3)+0.2,h=10,$fn=6);
    cylinder(d=6.2,h=100,$fn=36,center=true);
        for(a=[0:60:360])rotate([0,0,a+30])translate([19.5,0])cylinder(d=10,h=10,$fn=36);
  }
}


module knob2() {
  h=10;
  difference() {
    union() {
      cylinder(d=18,h=7,$fn=72);
      translate([0,0,1])hull() {
        intersection() {
          translate([0,20])cylinder(d=60,h=h,$fn=72*2);
          translate([0,-20])cylinder(d=60,h=h,$fn=72*2);
          cylinder(d=37,h=100,center=true,$fn=36);
        }
        translate([15,0])cylinder(d=10,h=h,$fn=36);
        translate([-15,0])cylinder(d=10,h=h,$fn=36);
        /*
        cylinder(d=20,h=7,$fn=72);
        translate([0,0,1]) {
          cylinder(d=33,h=7,$fn=72);
          for(a=[0:60:360])rotate([0,0,a])translate([15,0])cylinder(d=10,h=7,$fn=36);
          }
        */
      }
    }
    translate([0,0,3])cylinder(d=10*2/sqrt(3)+0.2,h=10,$fn=6);
    cylinder(d=6.2,h=100,$fn=36,center=true);
  }
}

//knob();
knob2();
//spacer();

