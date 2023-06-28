
//dependency:http://dkprojects.net/openscad-threads/threads.scad
include <.dependencies/threads.scad>

FFF=[false,false,false];FFT=[false,false,true];
FTF=[false,true,false];FTT=[false,true,true];
TFF=[true,false,false];TFT=[true,false,true];
TTF=[true,true,false];TTT=[true,true,true];
module cube2(size, center) {
  translate([
    center[0] ? -size[0]/2 : 0,
    center[1] ? -size[1]/2 : 0,
    center[2] ? -size[2]/2 : 0]) cube(size);
}
module mirror_x() {
  for(a=[0,1])mirror([a,0,0])children();
}
module mirror_y() {
  for(a=[0,1])mirror([0,a,0])children();
}
module mirror_z() {
  for(a=[0,1])mirror([0,0,a])children();
}
function sum(vector) = [for(p=vector) 1]*vector;

module zyxel_xxx_switch_bracket() {
    dist_x=141/2;
    hook_x=34;
    points1=[[dist_x,hook_x],[dist_x,hook_x+47.5],[-dist_x,hook_x],[-dist_x,hook_x+47.5]];
    holes1=[[dist_x,hook_x],[-dist_x,hook_x+36.8],[-dist_x,hook_x],[dist_x,hook_x+47.5]];
    holes2=[[50,0],[0,0],[-50,0]];
    points=concat(points1,holes2);
    module joint(array, i1, i2) {
        hull() {
            translate(array[i1]) cylinder(d=12,h=4);
            translate(array[i2]) cylinder(d=12,h=4);
        }
    }
    difference() {
        union() {
            joint(points, 0, 1);
            joint(points, 1, 3);
            joint(points, 3, 2);
            joint(points, 2, 6);
            joint(points, 6, 5);
            joint(points, 5, 4);
            joint(points, 4, 0);
        }
        
        for(xy=holes2)translate(xy)cylinder(d=3.2,h=20,center=true,$fn=24);
        for(xy=holes1)translate(xy) {
            cylinder(d=3.2,h=20,center=true,$fn=24);
            translate([0,0,-0.01])cylinder(d1=6.2,d2=3.2,h=3,$fn=24);
        }
    }
}

module zyxel_gs1200_8_bracket() {
    dist_y=10;
    height=3;
    points1=[[68,dist_y+20],[68,dist_y+64],[-68,dist_y+17],[-68,dist_y+64]];
    holes1=[[66.7,dist_y+25.5],[66.7,dist_y+63.5],[-64.5,dist_y+11.2],[-68.3,dist_y+55.7]];
    holes2=[[50,0],[0,0],[-50,0]];
    points=concat(points1,holes2);
    module joint(array, i1, i2) {
        hull() {
            translate(array[i1]) cylinder(d=12,h=height);
            translate(array[i2]) cylinder(d=12,h=height);
        }
    }
    difference() {
        union() {
            joint(points, 0, 1);
            joint(points, 1, 3);
            joint(points, 3, 2);
            joint(points, 2, 6);
            joint(points, 6, 5);
            joint(points, 5, 4);
            joint(points, 4, 0);
        }
        
        for(xy=holes2)translate(xy)cylinder(d=3.2,h=20,center=true,$fn=24);
        for(xy=holes1)translate(xy) {
            cylinder(d=3.2,h=20,center=true,$fn=24);
            translate([0,0,0.2])cylinder(d1=6.2,d2=3.2,h=1.5,$fn=24);
            translate([0,0,-0.01])cylinder(d=6.2,h=0.22,$fn=24);
        }
    }
}

// electrical box mounting points:
// 4 rows, with distances 32.25,30,32.25
module realsense_bracket() {
    distance_x=62.25/2;
    difference() {
        union() {
            cube2([72,6,50-6],TFF);
            mirror_x()translate([25,-12.5])cube2([12,13,25-6-2],TFF);
            
            mirror_x()translate([distance_x,0])cube2([12,35,5],TFF);
            mirror_x()translate([distance_x+6,0])hull() {
                cube2([3,35,5],TFF);
                cube2([3,6,50-6],TFF);
            }
        }
        mirror_x()translate([50/2,0,12.5-6]) {
            rotate([90,0])cylinder(d=3.2,h=100,center=true,$fn=24);
            translate([0,25-12.5+6])rotate([90,0])cylinder(d=6,h=25,$fn=36);
        }
        mirror_x()translate([45/2,0,25+12.5-6]) {
            rotate([90,0])cylinder(d=3.2,h=100,center=true,$fn=24);
        }
        mirror_x() for(a=[10,20,30])translate([distance_x,a])cylinder(d=3.2,h=30,$fn=24,center=true);
    }
}

module zed_bracket() {
  distance_x=94.5/2;
  difference() {
    union() {
        //cube2([72,6,50-6],TFF);
      mirror_x() {
        translate([distance_x-2,32])cube2([16,42,5],TFF);
        hull() {
          translate([distance_x-10,32])cube2([2,42,5],TFF);
          translate([5,32,30])cube2([1,5,5]);
        }
        hull() {
          translate([distance_x-10,32])cube2([2,5,5],TFF);
          translate([5,32,30])cube2([20,5,5]);
        }
      }
      hull() {
        translate([0,15,30])cylinder(d=20,h=5);
        translate([0,32,30])cube2([50,5,5],TFF);
      }
    }
    translate([0,15])cylinder(d=6.3,h=100,center=true,$fn=24);
   
    mirror_x() {
      hull()for(a=[-1,1])translate([distance_x+a*0.5,32+6]) cylinder(d=4,h=30,$fn=24,center=true);
      hull()for(a=[-1,1])translate([distance_x,68+a*0.5]) cylinder(d=4,h=30,$fn=24,center=true);
    }
  }
}

module realsense_d435() {
  // WxHxD: 90x25x25.1
  translate([0,25.1])rotate([90,0])difference() {
    hull()mirror_x() translate([65/2,0]){
      cylinder(d=19,h=4);
      translate([0,0,1])cylinder(d=22,h=4);
      translate([0,0,2])cylinder(d=24,h=4);
      translate([0,0,4])cylinder(d=25,h=4);
      translate([0,0,12])cylinder(d=24,h=1);
      translate([0,0,24])cylinder(d=19.5,h=1.1);
    }
    mirror_x()translate([45/2,0,-1])cylinder(d=3,h=2,$fn=12);
    translate([0,0,24]) {
      //rgb
      translate([-65/2,0])cylinder(d=8,h=2,$fn=24);
      
      translate([65/2,0])cylinder(d=10,h=2,$fn=24);
      translate([65/2-50,0])cylinder(d=10,h=2,$fn=24);
      translate([12,0])hull()mirror_x()translate([3,0])cylinder(d=13,h=2,$fn=24);
    }
  }
  
}
module zed() {
  hole_d=5.3;
  hole_distance=14.7;
  intersection() {
    cube2([180,31.7,40],TFT);
    difference() {
      rotate([-90,0]) hull()mirror_x()translate([(175-30)/2,0]) {
        cylinder(d=28,h=1);
        translate([0,-0.125,32])cylinder(d=30,h=1);
      }
      translate([0,hole_distance,13])cylinder(d=5.3,h=2);
    }
  }
}
module junction_box_sbox_416(single_wall=false) {
  floor_thickness=2.3;
  mounting_row_height=6.5;
  rh=mounting_row_height+floor_thickness;
  ratio = single_wall?2:1;
  depth=146;
  translate([0,depth/2-5.5,-rh]) {
    difference() {
      cube2([190,depth,70],TTF);
      translate([0,-depth/2+5.5,floor_thickness])cube2([(190-5)*ratio,(depth-8)*ratio,70],TFF);
    }
    mirror_x()for(a=[30/2,30/2+32.25])translate([a,7.5])cube2([5,50,rh],TFF);
    mirror_x()for(a=[30/2,30/2+32.25])mirror([0,1])translate([a,7.5])cube2([5,28,rh],TFF);
    mirror_x()translate([10,0])cube2([70,5,rh],FTF);
  }
}
module zed_realsense_combo_bracket() {
  distance_x=94.5/2;
  difference() {
    union() {
        //cube2([72,6,50-6],TFF);
      mirror_x() {
        //leg
        translate([distance_x-2,33])cube2([16,41,5],TFF);
        hull() {
          translate([distance_x-2,33])cube2([16,1,5],TFF);
          translate([0,25.1])cube2([distance_x*2-15,13,5],TFF);
        }
        hull() {
          translate([distance_x-10,33])cube2([2,41,5],TFF);
          translate([5,33,47])cube2([1,5,5]);
        }
        difference() {
          hull() {
            translate([0,25.1])cube2([distance_x*2-15,13,5],TFF);
            translate([0,25.1,47])cube2([50,13,5],TFF);
          }
          translate([0,33,15])mirror([0,1])cube2([100,100,100],TFF);
        }
      }
      intersection() {
        rotate([2,0])hull() {
          translate([0,15,46])cylinder(d=20,h=5);
          translate([0,35,46])cube2([50,5,5],TFF);
        }
        cube2([100,38,100],TFF);
      }
    }
    translate([0,14.7])cylinder(d=6.5,h=200,center=true,$fn=24);
   
    mirror_x() {
      //leg holes
      hull()for(a=[-1,1])translate([distance_x+a*1,32+6]) cylinder(d=4,h=30,$fn=24,center=true);
      hull()for(a=[-1,1])translate([distance_x,67.5+a*1]) cylinder(d=4,h=30,$fn=24,center=true);
      // d435 holes
      translate([45/2,25.1+5,5]) rotate([-90,0]) {
        cylinder(d=3.2,h=100,center=true,$fn=24);
        cylinder(d=6,h=100,$fn=24);
      }
      translate([0,0,33])cube2([10,100,25],TTT);
    }
  }

}
module cable_gland_base(thread_diameter=25, nut_size=30) {
  d=thread_diameter;
  difference() {
      union() {
          intersection() {
              cylinder(d=nut_size*2/sqrt(3),h=5,$fn=6);
              rotate([0,0,30])cylinder(d=nut_size*1.3,h=20,center=true,$fn=6);
          }
          translate([0,0,5])metric_thread(diameter=d, pitch=2, angle=40, length=15);
      }
      translate([0,0,-0.01])cylinder(d1=d,d2=0,h=d/2,$fn=72);
      cylinder(d=d-7,h=50,center=true,$fn=72);
      translate([0,0,11.1])cylinder(d1=d-7,d2=d-3,h=10,$fn=72);
  }
}

module cable_gland_base_custom1() {
  thread_diameter=25;
  nut_size=30;
  d=thread_diameter;
  difference() {
      union() {
          intersection() {
              cylinder(d=nut_size*2/sqrt(3),h=5,$fn=6);
              rotate([0,0,30])cylinder(d=nut_size*1.3,h=20,center=true,$fn=6);
          }
          for(a=[1,-1])translate([10*a,0]){
            cylinder(d=14,h=7,$fn=36);
            cylinder(d=18,h=5,$fn=36);
          }
          translate([0,0,5])metric_thread(diameter=d, pitch=2, angle=40, length=15);
      }
      translate([0,0,-0.01])cylinder(d1=d,d2=0,h=d/2,$fn=72);
      cylinder(d=d-7,h=50,center=true,$fn=72);
      translate([0,0,11.1])cylinder(d1=d-7,d2=d-3,h=10,$fn=72);
  }
}

module cable_gland_flat_nut(thread_diameter=25, nut_size=30,height=4) {
  difference() {
    union() {
      intersection() {
        cylinder(d=nut_size*2/sqrt(3),h=height,$fn=6);
        rotate([0,0,30])cylinder(d=nut_size*1.3,h=20,center=true,$fn=6);
      }
    }
    translate([0,0,-0.1])metric_thread(diameter=thread_diameter+0.5, pitch=2, angle=40, length=10,internal=true);
  }
}
module cable_gland_top_nut(thread_diameter=25,nut_size=30,thread_length=8) {
  height = thread_length + 3;
  difference() {
    intersection() {
      cylinder(d=nut_size*2/sqrt(3),h=height,$fn=6);
      rotate([0,0,30])cylinder(d=nut_size*1.3,h=height*3,center=true,$fn=6);
      translate([0,0,height-thread_diameter*0.62])sphere(d=thread_diameter*1.6);
    }
      cylinder(d=thread_diameter-7,h=height*3,center=true,$fn=72);
      translate([0,0,-0.1])metric_thread(diameter=thread_diameter+0.5, pitch=2, angle=40, length=thread_length,internal=true);
    }
}
module cable_gland_32_insert(part=1) {
  module insert() {
    holes = [5,5,5,5];
    difference() {
      cylinder(d1=25,d2=29,h=10,$fn=72);
      translate([5,5])cylinder(d=6.7,h=30,center=true,$fn=24);
      translate([-5,5])cylinder(d=6.7,h=30,center=true,$fn=24);
      translate([5,-5])cylinder(d=4.7,h=30,center=true,$fn=24);
      translate([-5,-5])cylinder(d=4.7,h=30,center=true,$fn=24);
    }
  }
  translate([0,0,11]) intersection() {
    insert();
    y=10;
    translate([0,(part-2)*y]) cube2([100,y,100],TTT);
  }
}
module cable_gland_25_insert(part=1) {
  d=25;
  module insert() {
    difference() {
      cylinder(d1=d-7,d2=d-3,h=10,$fn=72);
      translate([3.5,3])cylinder(d=4.7,h=30,center=true,$fn=24);
      translate([-3.5,3])cylinder(d=5.2,h=30,center=true,$fn=24);
      translate([1.5,-5])cylinder(d=3.2,h=30,center=true,$fn=24);
      translate([-1.5,-5])cylinder(d=3.2,h=30,center=true,$fn=24);
    }
  }
  translate([0,0,11]) intersection() {
    insert();
    translate([0,(part-2)*8-1]) cube2([100,8,100],TTT);
  }
}

module cable_gland_25_insert2(part=1) {
  d=25;
  module insert() {
    difference() {
      cylinder(d1=d-7,d2=d-3,h=10,$fn=72);
      translate([4,0])cylinder(d=5.2,h=30,center=true,$fn=24);
      translate([-4,0])cylinder(d=5.2,h=30,center=true,$fn=24);
    }
  }
  translate([0,0,11]) intersection() {
    insert();
    translate([0,(part-2)*16]) cube2([100,16,100],TFT);
  }
}

module cable_gland_insert_2_parts(d=26, holes=[5], part=1) {
  holes_outer_width = d-7-4;
  assert(sum(holes) < holes_outer_width);
  assert(len(holes) > 0);
  gap1 = (len(holes) > 1) ? (holes_outer_width - sum(holes))/(len(holes)-1) : 0;
  gap = gap1 < 3 ? gap1 : 3;
  holes_width = sum(holes) + gap*(len(holes)-1);
  start = -holes_width/2;
  module insert() {
    difference() {
      cylinder(d1=d-7,d2=d-3,h=10,$fn=72);
      for(hole_index=[0:len(holes)-1]) {
        dia = holes[hole_index];
        offset = dia/2 + ((hole_index > 0)?sum([for(i=[0:hole_index-1])holes[i]+gap]):0);
        translate([offset+start,0])cylinder(d=holes[hole_index],h=30,center=true,$fn=24);
      }
    }
  }
  intersection() {
    insert();
    translate([0,(part-2)*16]) cube2([100,16,100],TFT);
  }
}
module cable_gland_insert_2_parts2(d=26, part=1) {
  module insert() {
    difference() {
      cylinder(d1=d-7,d2=d-3,h=10,$fn=72);
      translate([4,0])cylinder(d=5.2,h=30,center=true,$fn=24);
      translate([-4,0])cylinder(d=5.2,h=30,center=true,$fn=24);
    }
  }
  intersection() {
    insert();
    translate([0,(part-2)*16]) cube2([100,16,100],TFT);
  }
}

module cable_gland(d=25,part=1) {
  module base() {
    difference() {
        union() {
            intersection() {
                cylinder(d=d+11,h=5,$fn=6);
                rotate([0,0,30])cylinder(d=d+15,h=20,center=true,$fn=6);
            }
            translate([0,0,5])metric_thread(diameter=d, pitch=2, angle=40, length=15);
        }
        translate([0,0,-0.01])cylinder(d1=d,d2=0,h=d/2,$fn=72);
        cylinder(d=d-7,h=50,center=true,$fn=72);
        translate([0,0,11.1])cylinder(d1=d-7,d2=d-3,h=10,$fn=72);
    }
  }
  module nut() {
    difference() {
        union() {
            intersection() {
                cylinder(d=d+11,h=4,$fn=6);
                rotate([0,0,30])cylinder(d=d+15,h=20,center=true,$fn=6);
            }
        }
        translate([0,0,-0.1])metric_thread(diameter=d+0.5, pitch=2, angle=40, length=10,internal=true);
    }
  }
  module cover_nut() {
    intersection() {
      difference() {
          cylinder(d=d+8,h=10,$fn=72);
          for(a=[0:7])rotate([0,0,a*360/8])translate([d*0.8,0])cylinder(d=d*0.4,h=100,center=true,$fn=24);
          cylinder(d=d-7,h=199,center=true,$fn=72);
          translate([0,0,-0.1])metric_thread(diameter=d+0.5, pitch=2, angle=40, length=7,internal=true);
        }
      translate([0,0,-d*0.3])sphere(d=d*1.8);
    }
  }
  module insert() {
    holes = [5,5,5,5];
    difference() {
      cylinder(d1=d-7,d2=d-3,h=10,$fn=72);
      for(a=[0:3])rotate([0,0,45+90*a])translate([d*0.24,0])cylinder(d=holes[a],h=30,center=true,$fn=24);
    }
  }
  if (part == 1) {
    base();
  } else if (part == 2) {
    translate([0,0,7]) nut();
  } else if (part == 3) {
    translate([0,0,12])cover_nut();
  } else if (part >= 4 && part <= 6) {
    translate([0,0,11]) intersection() {
      insert();
      y=d*0.24*sqrt(2);
      translate([0,(part-5)*y]) cube2([100,y,100],TTT);
    }
  }
}

module cable_gland_v2_base(thread_diameter=25, nut_size=30,outer_thread_length=8,inner_thread_length=8) {
  d=thread_diameter;
  whole_length=outer_thread_length+6+inner_thread_length;
  difference() {
    union() {
      translate([0,0,outer_thread_length]) {
        intersection() {
          od = nut_size*2/sqrt(3);
          cylinder(d=od,h=6,$fn=6);
          rotate([0,0,30])cylinder(d=nut_size*1.3,h=20,center=true,$fn=6);
          translate([0,0,0])cylinder(d1=od-12,d2=od+12,h=10,$fn=72);
        }
        translate([0,0,5.99])cube2([d/2+2,2,2],FTF);
      }
      
      metric_thread(diameter=d, pitch=2, angle=40, length=whole_length);
    }
    translate([0,0,-1.01])cylinder(d1=d-3,d2=d-7,h=10,$fn=72);
    cylinder(d=d-7,h=50,center=true,$fn=72);
    translate([0,0,whole_length-9+.1])cylinder(d1=d-7,d2=d-3,h=10,$fn=72);
  }
}

module cable_gland_v3_base(outer_thread_diameter=25, inner_thread_diameter=25,outer_thread_length=8,inner_thread_length=8,nut_size=30) {
  d=outer_thread_diameter;
  nut_length=3;
  ring_length=2;
  whole_length=outer_thread_length+nut_length+ring_length+inner_thread_length;
  difference() {
    union() {
      metric_thread(diameter=inner_thread_diameter, pitch=2, angle=40, length=inner_thread_length+0.01);
      translate([0,0,inner_thread_length]) {
        cylinder(d=inner_thread_diameter,h=ring_length+.01,$fn=72);
        cube2([inner_thread_diameter/2+2,2,ring_length+.01],FTF);
      }
      translate([0,0,inner_thread_length+ring_length]) intersection() {
          od = nut_size*2/sqrt(3);
          cylinder(d=od,h=nut_length+.01,$fn=6);
          rotate([0,0,30])cylinder(d=nut_size*1.3,h=20,center=true,$fn=6);
        }
        translate([0,0,inner_thread_length+ring_length+nut_length]) metric_thread(diameter=outer_thread_diameter, pitch=2, angle=40, length=outer_thread_length);
    }
    translate([0,0,-1.01])cylinder(d1=d-3,d2=d-7,h=2,$fn=72);
    cylinder(d=d-7,h=50,center=true,$fn=72);
    translate([0,0,whole_length-9+.1])cylinder(d1=d-7,d2=d-3,h=10,$fn=72);
  }
}

module cable_gland_insert_2_mold(d=26, holes=[5]) {
  difference() {
    cylinder(h=9.98,d=d+1);
    translate([0,-0.5,-.01])cable_gland_insert_2_parts(d,holes,1);
    translate([0,0.5,-.01])cable_gland_insert_2_parts(d,holes,2);
  }
}

//cable_gland_base(32,36);
//cable_gland_top_nut(32,36);
//cable_gland_flat_nut(32,36);
//cable_gland_32_insert(1);

//cable_gland_base(25,30);
//cable_gland_top_nut(25,30);
//cable_gland_flat_nut(25,30);
//cable_gland_25_insert(3);
//cable_gland_insert_2_parts(25,1);

//cable_gland(25,1);
//cable_gland(25,2);
//cable_gland(25,4);
//zyxel_gs1200_8_bracket();
//realsense_bracket();
//zed_bracket();

//cable_gland_base_custom1();

//%junction_box_sbox_416(true);
//%translate([0,0,5]) color("lightgreen")realsense_d435();
//%translate([0,0,32]) color("lightgreen")zed();
//zed_realsense_combo_bracket();

//cable_gland_v2_base(32,36);
//cable_gland_v2_base(25,30);
//translate([35,0,2])cable_gland_base(25,30);


//cable_gland_top_nut(26,30);
//cable_gland_v3_base(26,25,8,6,30);
//cable_gland_flat_nut(25,30,6);
cable_gland_insert_2_parts(26,[4.5,4.5],2);
//cable_gland_insert_2_mold(26,[5,5]);