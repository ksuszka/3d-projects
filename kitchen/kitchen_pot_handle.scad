



module handle1() {
difference() {
  union() {
    cylinder(d1=37,d2=39,h=15,$fn=120);
    hull() {
      rotate_extrude($fn=120) translate([22,20])circle(d=10);
      translate([0,0,10])cylinder(d=38,h=5,$fn=120);
    }
  }
  translate([0,0,-.01]) {
    cylinder(d=5,h=100,$fn=24);
    cylinder(d=18,h=2,$fn=72);
  }
  translate([0,0,10]) cylinder(d=8*2/sqrt(3),h=50,$fn=6);
}
}

module handle_v2() {
difference() {
  union() {
    cylinder(d1=37,d2=39,h=15,$fn=120);
    hull() {
      rotate_extrude($fn=120) translate([22,20])circle(d=10);
      translate([0,0,10])cylinder(d=38,h=5,$fn=120);
      translate([0,0,24])cylinder(d=48,h=1,$fn=120);
    }
  }
  difference() {
    hull() {
      cylinder(d=5,h=20,$fn=24);
      cylinder(d=1,h=23,$fn=24);
    }
    translate([0,0,9.8])cylinder(d=20,h=0.2);
  }
  translate([0,0,-80])sphere(r=80+2,$fn=120);
  translate([0,0,10]) cylinder(d=8*2/sqrt(3),h=4,$fn=6);
}
}
module spacer_v2_1() {
  difference() {
    translate([0,0,.01])hull() {
      cylinder(r=30,h=2,$fn=120);
      cylinder(r=30-4,h=2+4,$fn=120);
    }
    difference() {
      hull() {
        cylinder(r=30-5,h=4.5,$fn=120);
        cylinder(r1=30-1,r2=30-1.5,h=1.5,$fn=120);
      }
        translate([0,0,3])cylinder(d=16,h=10,$fn=60);
        translate([0,0,1.5])cylinder(d=8,h=10,$fn=60);
    }
    cylinder(d=5,h=30,center=true,$fn=24);
  }
}
module handle3() {
difference() {
  union() {
    difference(){
      cylinder(d1=37,d2=39,h=15,$fn=120);
      translate([0,0,-.01])cylinder(d1=30,d2=18,h=1,$fn=72);
    }
    hull() {
      rotate_extrude($fn=120) translate([22,20])circle(d=10);
      translate([0,0,10])cylinder(d=38,h=5,$fn=120);
    }
    translate([0,0,-2.5])cylinder(d=15.9,h=10,$fn=120);
  }
  cylinder(d=5,h=10,$fn=24,center=true);
  translate([0,0,-.01]) {
    //cylinder(d1=30,d2=18,h=1.5,$fn=72);
  }
  translate([0,0,-2.5+3.5]) {
   cylinder(d=8*2/sqrt(3),h=4.01,$fn=6);
   translate([0,0,4])cylinder(d1=8*2/sqrt(3),d2=0,h=5,$fn=6);
  }
}
}

module spacer() {
  difference() {
    union() {
      cylinder(d=71, h=1, $fn=120);
      difference() {
        cylinder(d1=67.5,d2=66, h=3.5, $fn=120);
        cylinder(d=60, h=10, $fn=120);
      }
      cylinder(d=15.9, h=5, $fn=120);
    }
    cylinder(d=5, h=20, $fn=30,center=true);
    translate([0,0,1])cylinder(d1=10,d2=0, h=5, $fn=30);
    translate([0,0,-.01])cylinder(d=10, h=1.02, $fn=30);
  }
}

module spacer2() {
  difference() {
    union() {
      cylinder(d=71, h=1, $fn=120);
      difference() {
        cylinder(d1=68.5,d2=66, h=3, $fn=120);
        cylinder(d=60, h=10, $fn=120);
      }
      cylinder(d=15.9, h=5, $fn=120);
      cylinder(d=20, h=3.4, $fn=120);
    }
    cylinder(d=5, h=20, $fn=30,center=true);
    translate([0,0,1])cylinder(d1=10,d2=0, h=5, $fn=30);
    translate([0,0,-.01])cylinder(d=10, h=1.02, $fn=30);
  }
}
module spacer3() {
  difference() {
    union() {
      cylinder(d=71, h=1, $fn=120);
      difference() {
        cylinder(d1=68.5,d2=66, h=3, $fn=120);
        cylinder(d=60, h=10, $fn=120);
      }
    }
    translate([0,0,-.01])cylinder(d=8.7, h=10, $fn=30);
  }
}

//spacer3();
intersection() {
  //translate([0,0,6])handle_v2();
  spacer_v2_1();
  //translate([50,0,0])cube([100,100,100],true);
}
//handle3();
