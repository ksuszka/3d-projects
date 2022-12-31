
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

cell_width=76;

module box(cells_w,cells_d,height,width_extra=0,depth_extra=0) {
  w=cells_w*cell_width + width_extra;
  d=cells_d*cell_width + depth_extra;
  h=height;
  r=5;
  skew=2;
  wall=1.5;
  floor_h=1;
  corner_skew=r*1.5;
  rim_h=5;
  cw05=cell_width/2;
  
  module base_hull() {
    hull() {
      cube2([w-skew*2-5,d-skew*2-5-corner_skew,1],TTF);
      cube2([w-skew*2-5-corner_skew,d-skew*2-5,1],TTF);
      translate([0,0,floor_h+r*0.5])cube2([w-skew*2,d-skew*2-corner_skew,1],TTF);
      translate([0,0,floor_h+r*0.5])cube2([w-skew*2-corner_skew,d-skew*2,1],TTF);
      translate([0,0,h-rim_h])cube2([w,d-corner_skew,rim_h],TTF);
      translate([0,0,h-rim_h])cube2([w-corner_skew,d,rim_h],TTF);
    }
  }
  module base_hull_top_corners() {
    hull() {
      translate([0,0,h-rim_h])cube2([w,d,rim_h],TTF);
      intersection() {
        base_hull();
        translate([0,0,h-2-corner_skew])cube2([w*1.1,d*1.1,h],TTF);
      }
    }
  }
  module lock_base() {
    cube2([10,16,h],FTF);
  }
  module lock_groove() {
    lock_h=10;
    translate([0,0,-.01])cube2([2,6,lock_h],TTF);
    hull() {
      translate([0.5,0,-.01])cube2([1,6,lock_h],FTF);
      translate([1.5,0])cube2([0.5,8,lock_h],FTF);
      translate([-1,0,-.01])cube2([0.1,6,lock_h+5],FTF);
    }
    
  }
  difference() {
    union() {
      base_hull();
      base_hull_top_corners();
      mirror_x()for(a=[1:d/cw05-1])translate([-w/2,-d/2 + a*cw05])lock_base();
      mirror_y()for(a=[1:w/cw05-1])translate([-w/2 + a*cw05,-d/2])rotate([0,0,90])lock_base();
    }
    hull()mirror_x()mirror_y() {
      translate([w/2-r-wall-skew,d/2-r-wall-skew,r+floor_h])sphere(r=r,$fn=24);
      translate([w/2-r-wall,d/2-r-wall,h])cylinder(r=r,$fn=24);
    }
    mirror_x()for(a=[1:d/cw05-1])translate([-w/2,-d/2 + a*cw05])lock_groove();
    mirror_y()for(a=[1:w/cw05-1])translate([-w/2 + a*cw05,-d/2])rotate([0,0,90])lock_groove();
  }
}

module splitted_box(cells_w, cells_d, height, width_extra=0,depth_extra=0) {
  d=cells_d*cell_width + depth_extra;
  module lock(h=1) {
    mirror_x() translate([4,0])cylinder(d=5,h=h,$fn=24);
    cube2([8,3,h],TTF);
  }
  module locks(s=1,h=1,support=false) {
    g=4;
    for(a=[0:d/4/g-2]) {
      b=s*((a%2-0.5)*4*(a+a%2)-1)*g;
      translate([0,b]) difference() {
        lock(h);
        if (support) {
          mirror_y()translate([0,0.7])cube2([12,0.5,10],TTT);
        }
      }
    }
  }
  difference() {
    union() {
      intersection() {
        box(cells_w,cells_d,height,width_extra,depth_extra);
        cube2([cells_w*cell_width,cells_d*cell_width*1.2,height*3],FTT);
      }
      locks(1,0.4);
      
      // fill side gaps
      mirror_y() translate([0,-d/2])cube2([7,3,20],FFF);
      
      // make side lap
      translate([0,-d/2])cube2([10,0.7,height],TFF);
    }
    translate([0,0,-.01])locks(-1,0.6,true);
    // make side lap
    mirror([0,-1])translate([0,-d/2-0.01,-.01])cube2([10,0.8,height+.02],TFF);
    // side locks
/*
    mirror_y() {
      for(a=[20:15:height-5]) {
        translate([0,d/2+.01,a])rotate([90,0])lock(1);
      }
    }
*/
  }
}
module hook() {
  lock_h=10;
  mirror_x() hull(){
      translate([0,0,-.01])cube2([1,5.5,lock_h],FTF);
      translate([1.5,0])cube2([0.5-0.15,8.2,lock_h],FTF);
  }
  translate([0,0,-.01])cube2([3,5.5,lock_h],TTF);
}
module hook2() {
  lock_h=10;
  mirror_x() hull(){
      translate([0.5,0,-.01])cube2([1,6,lock_h],FTF);
      translate([1.5,0])cube2([0.5-0.15,8,lock_h],FTF);
  }
  translate([0,0,-.01])cube2([3,6,lock_h],TTF);
}

//box(1,1.5,60);
splitted_box(6,2,60,0,167-2*cell_width);

//hook();