
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


outer_dimensions=[76,58,35];
corner_r=3;
pcb_distance=12.5+1.6;
screw_height=25;
module shell_form(r=corner_r) {
  minkowski() {
    translate([corner_r,0,corner_r])
      cube2([outer_dimensions[0]-2*corner_r,outer_dimensions[1]-2*corner_r,outer_dimensions[2]-2*corner_r],FTF);
    sphere(r=r,$fn=24);
  }
}
module shell() {
  difference() {
    shell_form(corner_r);
    shell_form(1.8);
  }
}

module screw_towers() {
  mirror_y()translate([63,58/2,screw_height])rotate([90,0,0])cylinder(d1=12,d2=6,h=3.01,$fn=24);
}
module case() {
  difference() {
    union() {
      shell();
      for(a=[0,pcb_distance])translate([0,0,5+a]) {
        translate([5,0]) cube2([60,57,6],FTT);
        translate([1,0]) cube2([2,50,6],FTT);
      }
      screw_towers();
      //translate([60,23,21])cube2([10,10,13]);
    }
    //translate([2+46,19,22])cube2([11,100,100]);
    for(a=[0,pcb_distance])translate([0,0,5+a]) {
      translate([4,0]) {
        cube2([70,54,1.6],FTT);
        cube2([70,52,7],FTT);
      }
      translate([2,0]) cube2([2,52,1.6],FTT);
    }
    mirror_y() {
      translate([63,0,screw_height])rotate([90,0,0])cylinder(d=3.2,h=100,center=true,$fn=24);
      translate([63,58/2+0.1,screw_height])rotate([90,0,0])cylinder(d1=6,d2=0,h=3.01,$fn=24);
    }
    translate([68,0])cube2([200,200,200],FTT);
  }
}

module front() {
  difference() {
    union() {
      difference() {
        union() {
          intersection() {
            shell_form(corner_r);
            translate([68,0])cube2([200,200,200],FTT);
          }
          intersection() {
            shell_form(1.8);
            translate([65,0])cube2([200,200,200],FTT);
          }
        }
        translate([1.5,0])shell_form(0);
      }
      translate([59,0,screw_height]) cube2([16,52,9],FTT);
    }
    translate([58.5,0,screw_height]) cube2([16,44,10],FTT);
    difference() {
      screw_towers();
      translate([68,0])cube2([200,200,200],FTT);
    }
    translate([63,0,screw_height])rotate([90,0,0])cylinder(d=2.5,h=100,center=true,$fn=24);
    
    for(a=[0,pcb_distance])translate([0,0,5+a])
        cube2([70,54,1.6],FTT);
    
    translate([70,-11,5.8 ])cube2([20,12.5,11],TTF);
    translate([70,19.5,5.8 ])cube2([20,9,11],TTF);
    translate([70,-58/2+2+0.35+20.8,5.8+pcb_distance+6.25]) {
      hull()mirror_y() {
        translate([0,12.5])rotate([0,90])cylinder(d=6,h=20,$fn=24,center=true);
      }
      hull()mirror_y() {
        translate([0,6,-3])rotate([0,90])cylinder(d=4,h=20,$fn=24,center=true);
        translate([0,7,3])rotate([0,90])cylinder(d=4,h=20,$fn=24,center=true);
      }
      
    }
    //2+0.35+8.3
    //2+0.35+8.3+25
  }
}


//case();
front();