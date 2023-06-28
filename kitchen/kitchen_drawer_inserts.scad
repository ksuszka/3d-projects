

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

// first drawer dimensions: 1116x456x60
// second drawer dimensions: 842x406x60
first_drawer_cell_width=76;
second_drawer_cell_width=58;
module box(cells_w,cells_d,height,width_extra=0,depth_extra=0,cell_width=50) {
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
      cube2([w-skew*2-5,d-skew*2-5-corner_skew,1],CCL);
      cube2([w-skew*2-5-corner_skew,d-skew*2-5,1],CCL);
      translate([0,0,floor_h+r*0.5])cube2([w-skew*2,d-skew*2-corner_skew,1],CCL);
      translate([0,0,floor_h+r*0.5])cube2([w-skew*2-corner_skew,d-skew*2,1],CCL);
      translate([0,0,h-rim_h])cube2([w,d-corner_skew,rim_h],CCL);
      translate([0,0,h-rim_h])cube2([w-corner_skew,d,rim_h],CCL);
    }
  }
  module base_hull_top_corners() {
    hull() {
      translate([0,0,h-rim_h])cube2([w,d,rim_h],CCL);
      intersection() {
        base_hull();
        translate([0,0,h-2-corner_skew])cube2([w*1.1,d*1.1,h],CCL);
      }
    }
  }
  module lock_base() {
    cube2([10,16,h],LCL);
  }
  module lock_groove() {
    lock_h=10;
    translate([0,0,-.01])cube2([2,6,lock_h],CCL);
    hull() {
      translate([0.5,0,-.01])cube2([1,6,lock_h],LCL);
      translate([1.5,0])cube2([0.5,8,lock_h],LCL);
      translate([-1,0,-.01])cube2([0.1,6,lock_h+5],LCL);
    }
    
  }
  difference() {
    union() {
      base_hull();
      base_hull_top_corners();
      copy_x()for(a=[1:d/cw05-1])translate([-w/2,-d/2 + a*cw05])lock_base();
      copy_y()for(a=[1:w/cw05-1])translate([-w/2 + a*cw05,-d/2])rotate([0,0,90])lock_base();
    }
    hull()copy_x()copy_y() {
      translate([w/2-r-wall-skew,d/2-r-wall-skew,r+floor_h])sphere(r=r,$fn=24);
      translate([w/2-r-wall,d/2-r-wall,h])cylinder(r=r,$fn=24);
    }
    copy_x()for(a=[1:d/cw05-1])translate([-w/2,-d/2 + a*cw05])lock_groove();
    copy_y()for(a=[1:w/cw05-1])translate([-w/2 + a*cw05,-d/2])rotate([0,0,90])lock_groove();
  }
}

module splitted_box(cells_w, cells_d, height, width_extra=0,depth_extra=0,cell_width=50) {
  d=cells_d*cell_width + depth_extra;
  module lock(h=1) {
    copy_x() translate([4,0])cylinder(d=5,h=h,$fn=24);
    cube2([8,3,h],CCL);
  }
  module locks(s=1,h=1,support=false) {
    g=4;
    for(a=[0:d/4/g-2]) {
      b=s*((a%2-0.5)*4*(a+a%2)-1)*g;
      translate([0,b]) difference() {
        lock(h);
        if (support) {
          copy_y()translate([0,0.7])cube2([12,0.5,10],CCC);
          cube2([12,2.5,0.2],CCL);
        }
      }
    }
  }
  difference() {
    union() {
      intersection() {
        box(cells_w,cells_d,height,width_extra,depth_extra,cell_width);
        cube2([cells_w*cell_width+width_extra,cells_d*cell_width+depth_extra,height*3],LCC);
      }
      locks(1,0.4);
      
      // fill side gaps
      copy_y() translate([0,-d/2]) {
        hull() {
          cube2([7,1,height],LLL);
          cube2([7,3,10],LLL);
        }
        hull() {
          cube2([7,1,6],LLL);
          cube2([7,6,1],LLL);
        }
      }
      
      // make side lap
      translate([0,-d/2])cube2([10,0.7,height],CLL);
    }
    translate([0,0,-.01])locks(-1,0.6,true);
    // make side lap
    mirror([0,-1])translate([0,-d/2-0.01,-.01])cube2([10,0.8,height+.02],CLL);
    // side locks
/*
    copy_y() {
      for(a=[20:15:height-5]) {
        translate([0,d/2+.01,a])rotate([90,0])lock(1);
      }
    }
*/
  }
}
module hook() {
  lock_h=10;
  copy_x() hull(){
      translate([0,0,-.01])cube2([1,5.5,lock_h],LCL);
      translate([1.5,0])cube2([0.5-0.15,8.2,lock_h],LCL);
  }
  translate([0,0,-.01])cube2([3,5.5,lock_h],CCL);
}
module hook2() {
  lock_h=10;
  copy_x() hull(){
      translate([0.5,0,-.01])cube2([1,6,lock_h],LCL);
      translate([1.5,0])cube2([0.5-0.15,8,lock_h],LCL);
  }
  translate([0,0,-.01])cube2([3,6,lock_h],CCL);
}

//box(1,1.5,60);
//splitted_box(6,2,60,0,167-2*first_drawer_cell_width,first_drawer_cell_width);
//hook();
//splitted_box(7,2,60,0,20,second_drawer_cell_width);
//splitted_box(7,1,60,0,0,second_drawer_cell_width);
//splitted_box(5.5,2.5,60,0,0,second_drawer_cell_width);
//box(2.5,1.5,60,0,0,second_drawer_cell_width);
//splitted_box(5.5,1.5,60,0,25,37*2); // second drawer first long box
//color("red")cube2([5,125,5],CCC);
splitted_box(6.5,2,60,22.7,10,second_drawer_cell_width);
