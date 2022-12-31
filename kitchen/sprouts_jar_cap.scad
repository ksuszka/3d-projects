
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
    //move_z(1)metric_thread(diameter=78.4, pitch=3, length=11,thread_size=3,angle=40,internal=true,leadin=2,leadfac=1,n_starts=2);
    
    for(a=[0:15:359])rotate([0,0,a])move_x(d1/2+5)cylinder(d=12,h=30,center=true,$fn=48);
  }
  move_z(1)difference(){
    cylinder(d=82,h=12,$fn=120);
    cylinder(d=78,h=30,$fn=120,center=true);
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
    //move_z(1)metric_thread(diameter=78.4, pitch=3, length=11,thread_size=3,angle=40,internal=true,leadin=2,leadfac=1,n_starts=2);
    
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
module strainer() {
  outer_d=96;
  hole_d=1.5;
  dy=hole_d+0.9;
  dx=dy*sqrt(3)/2;
  difference() {
    cylinder(d=outer_d,h=2,$fn=120);
    for(a=[-25:25]) for(b=[-25+(a%2)*0.5:25]) {
      x=a*dx;
      y=b*dy;
      if ((x*x+y*y)<(outer_d/2-4)^2) {
        translate([x,y])cylinder(d=hole_d,h=5,center=true,$fn=6);
      }
    }
  }
}
module cap_96mm() {
  outer_d=105;
  height=30;
  bottom_h=15;
  difference() {
    union () {
      cylinder(d=88+6+6,h=height,$fn=120);
      hull() {
        cylinder(d=outer_d,h=height-14,$fn=120);
        cylinder(d=88+6+6,h=height-9,$fn=120);
      }
    }
    move_z(-.02)cylinder(d=88,h=40,$fn=120);
    cylinder(d=96.2,h=bottom_h,$fn=120);
    hull() {
      move_z(-.01)cylinder(d=97,h=bottom_h-2,$fn=120);
      cylinder(d=96.2,h=bottom_h-1,$fn=120);
    }
    move_z(bottom_h+2)cylinder(d1=88,d2=88+6,h=3.01,$fn=120);
    move_z(bottom_h+5)cylinder(d=88+6,h=20,$fn=120);
    
    //legs
    for(a=[0:45:359])rotate([0,0,a]) {
      translate([40,0,bottom_h+6])hull() {
        cube2([20,3,10],LCL);
        move_z(10)cube2([20,3+20,10],LCL);
      }
    }
    
    //thread
    for(a=[0:60:359])rotate([0,0,a])move_z(-2)
      for(a=[0:60:129])rotate([0,0,a])move_z(a*4/60)
      {
      hull()for(a=[0:2:60])rotate([0,0,a])move_z(a*4/60)
      hull() {
        cube2([99.5,1,1],CCC);
        cube2([99.5-4,1,1+4],CCC);
      }
    }
    
    // grip groves
    for(a=[0:15:359])rotate([0,0,a])move_x(outer_d/2+5)cylinder(d=12,h=50,center=true,$fn=48);
  }
}
module cap_78mm() {
  inner_d=78;
  outer_d=inner_d+3.5+3.5;
  bottom_h=12;
  height=bottom_h+5+12;
  difference() {
    union () {
      cylinder(d=inner_d+4,h=height,$fn=120);
      hull() {
        cylinder(d=outer_d,h=bottom_h+1,$fn=120);
        cylinder(d=inner_d+2,h=bottom_h+7,$fn=120);
      }
      move_z(bottom_h+3)cylinder(d1=inner_d+4,d2=outer_d,h=height-bottom_h-3,$fn=120);
    }
    move_z(bottom_h+5)cylinder(d1=inner_d,d2=outer_d-4,h=height-bottom_h-3,$fn=120);
    move_z(-.01)cylinder(d=inner_d-4,h=40,$fn=120);
    move_z(-.02)cylinder(d=inner_d,h=bottom_h,$fn=120);
    move_z(bottom_h+2)cylinder(d1=inner_d-4,d2=inner_d,h=3.01,$fn=120);
    move_z(bottom_h+5)cylinder(d=inner_d,h=20,$fn=120);
    
    //legs
    for(a=[0:45:359])rotate([0,0,a]) move_z(bottom_h+5)hull() {
      cube2([0.1,0.1,40],CCL);
      move_x(outer_d) cube2([1,35,2],CCL);
      move_x(outer_d) move_z(30)cube2([1,50,1],CCL);
    }
    
    //thread
    outer_thread_d=inner_d+3.5;
    for(a=[0:60:359])rotate([0,0,a])move_z(-2) {
      for(a=[0:60:129])rotate([0,0,a])move_z(a*3.5/60) {
        hull()for(a=[0:2:60])rotate([0,0,a])move_z(a*3.5/60) hull() {
          cube2([outer_thread_d,1,0.5],CCC);
          cube2([outer_thread_d-4*1.2,1,0.5+4],CCC);
        }
        hull()for(a=[0:2:60])rotate([0,0,a])move_z(a*3.5/60) hull() {
          cube2([outer_thread_d-2.5*1.2,1,2+2.5],CCC);
          cube2([outer_thread_d-4*1.2,1,2+4],CCC);
        }
      }
    }
    
    // grip groves
    for(a=[0:15:359])rotate([0,0,a])move_z(-.03)move_x(outer_d/2+5.2)cylinder(d=12,h=bottom_h+5,$fn=48);
  }
}
module cap_78mm_support1() {
  inner_d=78;
  outer_d=inner_d+3.5+3.5;
  bottom_h=12;
  height=bottom_h+5+12;
  difference() {
    union () {
      cylinder(d=inner_d+4,h=height,$fn=120);
      hull() {
        cylinder(d=outer_d,h=bottom_h+1,$fn=120);
        cylinder(d=inner_d+2,h=bottom_h+7,$fn=120);
      }
      move_z(bottom_h+3)cylinder(d1=inner_d+4,d2=outer_d,h=height-bottom_h-3,$fn=120);
    }
    move_z(bottom_h+5)cylinder(d1=inner_d,d2=outer_d-4,h=height-bottom_h-3,$fn=120);
    move_z(-.01)cylinder(d=inner_d-4,h=40,$fn=120);
    move_z(-.02)cylinder(d=inner_d,h=bottom_h,$fn=120);
    move_z(bottom_h+2)cylinder(d1=inner_d-4,d2=inner_d,h=3.01,$fn=120);
    move_z(bottom_h+5)cylinder(d=inner_d,h=20,$fn=120);
    
    //legs
    for(a=[0:45:359])rotate([0,0,a]) move_z(bottom_h+5)hull() {
      cube2([0.1,0.1,40],CCL);
      move_x(outer_d) cube2([1,35,2],CCL);
      move_x(outer_d) move_z(30)cube2([1,50,1],CCL);
    }
    
    //thread
    outer_thread_d=inner_d+3.5;
    for(a=[0:60:359])rotate([0,0,a])move_z(-2) {
      for(a=[0:60:129])rotate([0,0,a])move_z(a*3.5/60) {
        hull()for(a=[0:2:60])rotate([0,0,a])move_z(a*3.5/60) hull() {
          cube2([outer_thread_d,1,0.5],CCC);
          cube2([outer_thread_d-4*1.2,1,0.5+4],CCC);
        }
        hull()for(a=[0:2:60])rotate([0,0,a])move_z(a*3.5/60) hull() {
          cube2([outer_thread_d-2.5*1.2,1,2+2.5],CCC);
          cube2([outer_thread_d-4*1.2,1,2+4],CCC);
        }
      }
    }
    
    // grip groves
    for(a=[0:15:359])rotate([0,0,a])move_z(-.03)move_x(outer_d/2+5.2)cylinder(d=12,h=bottom_h+5,$fn=48);
  }
  difference() {
    cylinder(d=inner_d-2.8,h=bottom_h,$fn=120);
    cylinder(d=inner_d-2.8-1,h=bottom_h*3,center=true,$fn=120);
  }
  difference() {
    cylinder(d=inner_d-2.8+1.8,h=bottom_h,$fn=120);
    cylinder(d=inner_d-2.8+1.8-1,h=bottom_h*3,center=true,$fn=120);
  }
}

module cap_78mm_v2_base() {
  inner_d=78;
  outer_d=inner_d+3.5+3.5;
  bottom_h=12;
  height=bottom_h+2;
  difference() {
    union () {
      hull() {
        cylinder(d=outer_d,h=bottom_h+1,$fn=120);
        cylinder(d=outer_d-3,h=bottom_h+3,$fn=120);
      }
    }
    move_z(bottom_h+5)cylinder(d1=inner_d,d2=outer_d-4,h=height-bottom_h-3,$fn=120);
    move_z(-.01)cylinder(d=inner_d-4,h=40,$fn=120);
    move_z(-.02)cylinder(d=inner_d,h=bottom_h,$fn=120);
    move_z(bottom_h+1.4)cylinder(d1=inner_d-4,d2=inner_d,h=3.01,$fn=120);
    move_z(bottom_h+5)cylinder(d=inner_d,h=20,$fn=120);
    
    // crown groove
    move_z(bottom_h+2)difference() {
      cylinder(d=outer_d-4+0.1,h=10,$fn=120);
      cylinder(d=outer_d-4-4,h=30,center=true,$fn=120);
      for(a=[0:45:359])rotate([0,0,a])cube2([outer_d+10,1.4,10],CCC);
    }
    //thread
    outer_thread_d=inner_d+3.5;
    for(a=[0:60:359])rotate([0,0,a])move_z(-2) {
      for(a=[0:60:129])rotate([0,0,a])move_z(a*3.5/60) {
        hull()for(a=[0:2:60])rotate([0,0,a])move_z(a*3.5/60) hull() {
          cube2([outer_thread_d,1,0.5],CCC);
          cube2([outer_thread_d-4*1.2,1,0.5+4],CCC);
        }
        hull()for(a=[0:2:60])rotate([0,0,a])move_z(a*3.5/60) hull() {
          cube2([outer_thread_d-2.5*1.2,1,2+2.5],CCC);
          cube2([outer_thread_d-4*1.2,1,2+4],CCC);
        }
      }
    }
    
    // grip groves
    for(a=[0:15:359])rotate([0,0,a])move_z(-.03)move_x(outer_d/2+5.2)cylinder(d=12,h=bottom_h+5,$fn=48);
  }
}



module stand(d=90) {
  difference() {
    cylinder(d1=d+2.4,d2=d+2.4+3,h=10,$fn=120);
    move_z(1)cylinder(d1=d,d2=d+3,h=10,$fn=120);
  }
}

module stand_90mm() {
  stand(90);
}
module stand_110mm() {
  stand(110);
}

color("green")intersection() {
  //strainer();
  //rotate([0,0,0])cap_78mm_support1();
  //translate([0.01,0])cube2([0.1,150,150],LCC);
  //move_z(-1)cube2([120,120,12],CCL);
}
stand_110mm();
//sealer();
//move_z(30)cap1();
