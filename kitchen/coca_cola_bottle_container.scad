
//dependency:https://dkprojects.net/openscad-threads/threads.scad
include <.dependencies/threads.scad>

LLL="LLL";LLC="LLC";LLR="LLR";LCL="LCL";LCC="LCC";LCR="LCR";LRL="LRL";LRC="LRC";LRR="LRR";
CLL="CLL";CLC="CLC";CLR="CLR";CCL="CCL";CCC="CCC";CCR="CCR";CRL="CRL";CRC="CRC";CRR="CRR";
RLL="RLL";RLC="RLC";RLR="RLR";RCL="RCL";RCC="RCC";RCR="RCR";RRL="RRL";RRC="RRC";RRR="RRR";
module cube2(size, center) {
  function align(i)=center[i]=="R"?-2:center[i]=="C"?-1:0;
  translate([align(0)*size[0]/2,align(1)*size[1]/2,align(2)*size[2]/2])cube(size);
}
module copy_x() { for(a=[0,1])mirror([a,0,0])children(); }
module copy_y() { for(a=[0,1])mirror([0,a,0])children(); }
module copy_z() { for(a=[0,1])mirror([0,0,a])children(); }
module move_x(d) { translate([d,0,0])children(); }
module move_y(d) { translate([0,d,0])children(); }
module move_z(d) { translate([0,0,d])children(); }

bottle_od=97;
bottle_id=96.1;
module cap1() {
  difference() {
    cylinder(d=98);
  }
}
module bottom_ring_v1() {
  od=bottle_od+2*1;
  id=bottle_id-2*1;
  hid=70;
  module bottle_rim(h=10) {
    difference() {
      cylinder(d=bottle_od,h=h,$fn=120);
      cylinder(d=bottle_id,h=h*3,center=true,$fn=120);
    }
  }
  module profile() {
    difference() {
      union() {
        hull() {
          square([od/2,11]);
          square([od/2-0.5,12]);
          square([82/2,20]);
          square([84/2,19.5]);
        }
      }
      translate([bottle_id/2,-.01])square([(bottle_od-bottle_id)/2,10]);
      translate([0,-0.1])square([hid/2,30]);
      r1=8;
      circle1_pos=[hid/2+r1,20];
      difference() {
        union() {
          square([hid/2+r1-r1/sqrt(2),20]);
        }
        translate(circle1_pos)circle(r=r1,$fn=60);
      }
      r2=46;
      translate(circle1_pos)rotate([0,0,45])translate([-r1-r2,0])circle(r=r2,$fn=120);
    }
  }
  difference() {
    union() {
      rotate_extrude($fn=120) profile();
      translate([0,0,20]) {
        metric_thread(diameter=78, pitch=3, length=8,thread_size=2.5,angle=40,internal=false,leadin=1,leadfac=1);
        hull() {
          cylinder(d=75,h=10,$fn=120);
          cylinder(d=76,h=9.5,$fn=120);
        }
      }
    }
    cylinder(d=hid,h=30,$fn=120);
    move_z(29.5)cylinder(d1=hid,d2=hid+2,h=1,$fn=120);
  }
}

module bottom_ring_v2() {
  od=bottle_od+2*1;
  id=bottle_id-2*1;
  hid=71.2;
  module bottle_rim(h=10) {
    difference() {
      cylinder(d=bottle_od,h=h,$fn=120);
      cylinder(d=bottle_id,h=h*3,center=true,$fn=120);
    }
  }
  module profile() {
    difference() {
      union() {
        hull() {
          square([od/2,11]);
          square([od/2-0.5,12]);
          square([82/2,20]);
          square([84/2,19.5]);
        }
        hull() {
          translate([hid/2,0])square([2.2,20+13]);
          translate([hid/2+0.5,0])square([1.2,20+13.5]);
        }
        
      }
      translate([bottle_id/2,-.01])square([(bottle_od-bottle_id)/2,10]);
      translate([0,-0.1])square([hid/2,30]);
      r1=8;
      circle1_pos=[hid/2+r1,20];
      difference() {
        union() {
          square([hid/2+r1-r1/sqrt(2),20]);
        }
        translate(circle1_pos)circle(r=r1,$fn=60);
      }
      r2=40;
      translate(circle1_pos)rotate([0,0,45])translate([-r1-r2,0])circle(r=r2,$fn=120);
    }
  }
  difference() {
    union() {
      rotate_extrude($fn=120) profile();
      translate([0,0,22]) {
        metric_thread(diameter=77.8, pitch=3, length=8,thread_size=2.5,angle=40,internal=false,leadin=2,leadfac=1,n_starts=2);
//        hull() {
//          cylinder(d=75,h=10,$fn=120);
//          cylinder(d=76,h=9.5,$fn=120);
//        }
      }
    }
    cylinder(d=hid,h=40,$fn=120);
//    move_z(29.5)cylinder(d1=hid,d2=hid+2,h=1,$fn=120);
  }
}
module bottom_ring() {
  od=bottle_od+2*1;
  id=bottle_id-2*1;
  hid=71.2;
  module bottle_rim(h=10) {
    difference() {
      cylinder(d=bottle_od,h=h,$fn=120);
      cylinder(d=bottle_id,h=h*3,center=true,$fn=120);
    }
  }
  module profile() {
    difference() {
      union() {
        hull() {
          square([od/2,11]);
          square([od/2-0.5,12]);
          square([82/2,20]);
          square([84/2,19.5]);
        }
        hull() {
          translate([hid/2,0])square([2.2,20+13]);
          translate([hid/2+0.5,0])square([1.2,20+13.5]);
        }
        
      }
      translate([bottle_id/2,-.01])square([(bottle_od-bottle_id)/2,10]);
      translate([0,-0.1])square([hid/2,30]);
      r1=8;
      circle1_pos=[hid/2+r1,20];
      difference() {
        union() {
          square([hid/2+r1-r1/sqrt(2),20]);
        }
        translate(circle1_pos)circle(r=r1,$fn=60);
      }
      r2=40;
      translate(circle1_pos)rotate([0,0,45])translate([-r1-r2,0])circle(r=r2,$fn=120);
    }
  }
  difference() {
    union() {
      rotate_extrude($fn=120) profile();
      translate([0,0,22]) {
        metric_thread(diameter=77.8, pitch=3, length=9,thread_size=2.5,angle=40,internal=false,leadin=2,leadfac=1,n_starts=2);
//        hull() {
//          cylinder(d=75,h=10,$fn=120);
//          cylinder(d=76,h=9.5,$fn=120);
//        }
      }
    }
    cylinder(d=hid,h=40,$fn=120);
//    move_z(29.5)cylinder(d1=hid,d2=hid+2,h=1,$fn=120);
  }
}

module cap1_v1() {
  hid=71;
  h1=13+1+2;
  d1=78+6;
  difference() {
    union () {
      hull() {
        move_z(.01)cylinder(d=d1-4,h=h1,$fn=120);
        move_z(.01)cylinder(d=d1-2,h=2,$fn=120);
        move_z(1)cylinder(d=d1,h=h1-3,$fn=120);
      }
    }
    // oring
    difference() {
      cylinder(d=75.8,h=14,$fn=120);
      cylinder(d=71,h=50,center=true,$fn=120);
    }
    cylinder(d=75,h=12,$fn=120);
    move_z(11.9)cylinder(d1=69,d2=69-4,h=2,$fn=120);
    
    cylinder(d1=80,d2=70,h=5,$fn=120);
    cylinder(d=78.2,h=3.01,$fn=120);
    move_z(3)cylinder(d1=78.2,d2=70,h=4,$fn=120);
    move_z(1)metric_thread(diameter=78.8, pitch=3, length=11,thread_size=3,angle=40,internal=true,leadin=2,leadfac=1,n_starts=2);
    
    for(a=[0:15:359])rotate([0,0,a])move_x(d1/2+5)cylinder(d=12,h=30,center=true,$fn=48);
  }
  move_z(1)difference(){
    cylinder(d=82,h=12,$fn=120);
    cylinder(d=78.2,h=30,$fn=120,center=true);
  }
}
module cap1() {
  hid=71;
  h1=13+1+2;
  d1=78+6;
  difference() {
    union () {
      hull() {
        move_z(.01)cylinder(d=d1-4,h=h1,$fn=120);
        move_z(.01)cylinder(d=d1-2,h=2,$fn=120);
        move_z(1)cylinder(d=d1,h=h1-3,$fn=120);
      }
    }
    // oring
    difference() {
      cylinder(d=75.8,h=14,$fn=120);
      cylinder(d=71,h=50,center=true,$fn=120);
    }
    cylinder(d=75,h=12,$fn=120);
    move_z(11.9)cylinder(d1=69,d2=69-4,h=2,$fn=120);
    
    cylinder(d1=80,d2=70,h=5,$fn=120);
    cylinder(d=78,h=3.01,$fn=120);
    move_z(3)cylinder(d1=78,d2=70,h=4,$fn=120);
    move_z(1)metric_thread(diameter=78.4, pitch=3, length=11,thread_size=3,angle=40,internal=true,leadin=2,leadfac=1,n_starts=2);
    
    for(a=[0:15:359])rotate([0,0,a])move_x(d1/2+5)cylinder(d=12,h=30,center=true,$fn=48);
  }
  move_z(1)difference(){
    cylinder(d=82,h=12,$fn=120);
    cylinder(d=78,h=30,$fn=120,center=true);
  }
}

module sealer() {
  difference() {
    cylinder(d=75.8-0.2,h=1.5,$fn=120);
    cylinder(d=71+0.2,h=6,center=true,$fn=120);
  }
}

color("gray")intersection() {
  move_z(-0.4)bottom_ring();
  //translate([0.01,0])cube2([0.1,150,150],LCC);
//  cube2([150,150,150],LCC);
}
color("green")intersection() {
  //translate([0,0,20.5])cap1();
  //translate([0.01,0])cube2([0.1,150,150],LCC);
}
//sealer();
//move_z(30)cap1();
