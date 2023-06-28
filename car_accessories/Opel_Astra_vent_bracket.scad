

$fa=3;
$fs=0.2;

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

module bracket_with_screws() {
  difference() {
    offset=10;
    rotate([3.2,0,0]) translate([0,10,-2]) {
      /*
      for(a=[-2:2]) translate([a*10,0,6]) {
        translate([0,0,6]) cube2([5,8,4],TFF);
        cube2([5,5,10],TFF);
      }
      */
      difference() {
        union() {
          translate([0,0,offset+6]) cube2([46.5,8,4],TFF);
          translate([0,0,offset]) cube2([46.5,5,10],TFF);
          translate([0,0,offset+10])rotate([-15,0,0])mirror([0,0,1])cube2([46.5,5,10],TFF);
        }
        for(a=[0:3]) translate([a*10-46.5/2+5,0,offset]) cube2([5,100,100],FTT);
          
      }
      difference() {
        cube2([55,20,3+offset],TTF); 
        translate([0,0,800+offset+1.8])rotate([90,0,0])cylinder(r=800,h=100,center=true,$fn=360);
      }
    }
    mirror([0,0,1])cube2([100,100,100],TTF);
    for(a=[-1,1])translate([a*20,6,0]) {
      cylinder(d=3.2,h=100,center=true);
      translate([0,0,3]) cylinder(d=4.9,h=100);
    }
  }
}

module bracket_for_rods() {
  module teeth(mode) {
    rotate([3.2,0,0]){
      if (mode=="teeth") {
        difference() {
          union() {
            translate([0,0,6]) cube2([46.5,8,4],TFF);
            translate([0,0,0]) cube2([46.5,5,10],TFF);
            translate([0,0,10])rotate([-15,0,0])mirror([0,0,1])cube2([46.5,5,10],TFF);
          }
          for(a=[0:3]) translate([a*10-46.5/2+5,0,0]) cube2([5,100,100],FTT);
        }
      } else if (mode=="curvature") {
        translate([0,0,800+1.8])rotate([90,0,0])cylinder(r=800,h=100,center=true,$fn=360);
      }
    }
  }
  difference() {
    union() {
      offset=20;
      translate([0,0,offset]) teeth("teeth");
      difference() {
        translate([0,3,0]) intersection() {
          cube2([65,15,30],TTF); 
          translate([0,0,42.5])rotate([0,45,0])cube2([100,100,100],TTT);
        }
        translate([0,0,offset]) teeth("curvature");
      }
    }
    for(a=[-1,1])translate([a*25,0,7.5]) rotate([90,0,0]){
      cylinder(d=8,h=100,center=true);
    }
  }
}

module tablet_bracket() {
  difference() {
    intersection() {
      union() {
        translate([0,-7,0]) cube2([120,29,10],TTF);
        translate([-60,-14,0]) cube2([10,15,20],FTF);
      }
      translate([-58+100,-14,2+100]) translate([87-2*1.4142,0])rotate([0,45,0])cube2([400,200,400], TTT);
    }
    for(a=[-1,1])translate([a*25,0,0]){
      cylinder(d=8,h=100,center=true);
    }
    for(a=[-1,1])translate([a*68,100-47,0]) cylinder(r=60,h=100,center=true);
    translate([-58+100,-14,2+100]) intersection() {
      cube2([200,11.2,200],TTT);
      translate([87,0])rotate([0,45,0])cube2([400,20,400], TTT);
    }
  }
}
//bracket_for_rods();
//bracket_with_screws();
tablet_bracket();
