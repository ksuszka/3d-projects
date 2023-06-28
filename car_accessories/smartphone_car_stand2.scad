

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

module hook() {
  difference() {
    union() {
      hull()for(a=[-5,5])translate([a,0])cylinder(d=5,h=3,$fn=72);
      cylinder(d=5,h=22,$fn=72);
      hull() {
        translate([0,0,19])cylinder(d=5,h=3,$fn=72);
        translate([0,0,22])cube2([7,7,5],TTF);
      }
    }
    translate([0,0,10])cylinder(d=2.7,h=200,$fn=12);
  }
}

module base() {
  hook_offset=25;
  difference() {
    union() {
      hull()mirror_x() {
        translate([14,hook_offset+13])cylinder(r=3,h=5,$fn=24);
        translate([25,7])cylinder(r=5,h=5);
      }
      hull()mirror_x() {
        translate([25,7])cylinder(r=5,h=5);
        translate([25,-5])cylinder(r=5,h=5);
        translate([35/2,3,-1]) rotate([10,0,0]) {
          translate([0,0,depth])cylinder(d=10,h=3,$fn=24);
        }
      }
      translate([0,hook_offset,4.5]) {
        translate([0,0,3])cube2([28,14,2],TFF);
        cube2([24,14,4],TFF);
      }
    }
    translate([0,hook_offset-10,0]) cube2([10,10,100],TFT);
    depth=7;
    mirror_x() translate([35/2,3,-1]) rotate([10,0,0]) {
      cube2([7.5,7.5,depth],TTF);
      cylinder(d=3.4,h=100,$fn=24);
      translate([0,0,depth+1])cylinder(d1=3.4,d2=6.4,h=3.01,$fn=24);
      translate([0,0,depth+4])cylinder(d=6.4,h=10,$fn=24);
    }
  }
}
base();
//hook();
