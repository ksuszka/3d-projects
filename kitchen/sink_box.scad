

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

wt=2; // wall thickness
bl=240; // box length
module inner_corner(h=100,rc=10,hollow=true) {
  re=3; //edge radius
  bb=(rc+re)*1.1;
  module cyl(r) {
    rotate_extrude($fn=24) 
    intersection() {
      hull(){
        mirror_y()translate([rc-re,h/2-re])circle(r=r,$fn=24);
        square([rc-re,h+(r-re)*2],center=true);
      }
      translate([0,-h])square([100,h*2]);
    }
  }
  rotate([0,-90]) intersection() {
    difference() {
      cyl(re);
      if (hollow) {
        cyl(re-wt);
        cylinder(r=rc-re,h=h-wt*2,center=true,$fn=24);
      }
    }
    cube2([bb,bb,h*1.1],FFT);
  }
}
module outer_corner(h=100,rc=10,hollow=true) {
  re=3; //edge radius
  // rc = corner outer radius
  bb=(rc+re)*1.1;
  module cyl(r,offset=0) {
    rotate_extrude($fn=48) 
    intersection() {
      hull()mirror_y()translate([rc+re,h/2-re])circle(r=r,$fn=24);
      translate([0,-h])square([100,h*2]);
    }
    difference() {
      cube2([rc+re+offset,rc+re+offset,h+(r-re)*2],FFT);
      cylinder(r=rc+re,h=h*1.1,center=true);
    }
  }
  rotate([0,-90])
  intersection() {
    difference() {
      cyl(re);
      if (hollow)cyl(re-wt,1);
    }
    cube2([rc+re,rc+re,h*1.1],FFT);
  }
}
module wall(h=100,w=10,d=20,hollow=true) {
  re=3; //edge radius
  module cyl(r,offset=0) {
    hull() {
      intersection () {
        mirror_x()translate([h/2-re,0,0])rotate([-90,0])cylinder(r=r,h=w,$fn=24);
        mirror([0,0,1])cube2([h*1.1,h,w],TTF);
      }
      translate([0,-offset/2,0])cube2([h+(r-re)*2,w+offset,d-re+offset],TFF);
    }
  }
  translate([0,0,re])difference() {
    cyl(re);
    if (hollow)cyl(re-wt,1);
  }
}

module box_v1() {
  translate([0,75+5,25-5])rotate([90,0])outer_corner(bl,5);
  translate([0,75-3,3])rotate([-90,0])inner_corner(bl,3);
  translate([0,5,5])rotate([180,0])inner_corner(bl,5);
  translate([0,5,0])wall(bl,67,30);
  translate([0,0,30])rotate([-90,0])wall(bl,25,30);
  translate([0,75,3])rotate([90,0])wall(bl,17,5);
  translate([0,75+5,25])wall(bl,25,5);
  translate([0,70,25])intersection(){
    wall(bl,25,5);
    translate([0,0,3])cube2([bl*1.1,100,100],TTF);
  }
}
module box_v2(hollow=true) {
  angle=7;
  translate([0,75+5,25-5])intersection() {
    translate([0,3])rotate([90,0])outer_corner(bl,5,hollow=hollow);
    rotate([-angle,0])cube2([bl*2,100,100],TTF);
    
  }
  translate([0,75-3,4])difference () {
    rotate([-90,0])inner_corner(bl,4,hollow=hollow);
    rotate([-angle,0])cube2([bl*2,100,100],TTF);
  }
  translate([0,75-3,4])rotate([-angle,0])translate([0,4])rotate([90,0])wall(bl,17,8,hollow=hollow);
  translate([0,5,5])rotate([180,0])inner_corner(bl,5,hollow=hollow);
  translate([0,5,0])wall(bl,67,30,hollow=hollow);
  translate([0,0,30])rotate([-90,0])wall(bl,25,30,hollow=hollow);
  translate([0,75+5+3,25])wall(bl,25,5,hollow=hollow);
  translate([0,70,25])intersection(){
    wall(bl,25,5,hollow=hollow);
    translate([0,0,3])cube2([bl*1.1,100,100],TTF);
  }
  translate([0,65,17.5])intersection(){
    wall(bl,10,12,hollow=hollow);
    translate([0,0,3])cube2([bl*1.1,100,100],TTF);
  }
}
box_v2();
for(a=[-120+3+35,-120+40+35])translate([a,0])intersection() {
box_v2(hollow=false);
  cube2([2,300,300],TTT);
}
