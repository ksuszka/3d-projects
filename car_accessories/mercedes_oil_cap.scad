
//dependency:https://dkprojects.net/openscad-threads/threads.scad
use <.dependencies/threads.scad>;



//ceiling_cap();
//lamp_cap();





$fa=3;
$fs=0.2;

module nut(h=1) {
  intersection() {
    cylinder(d=36*2/sqrt(3),h=h,$fn=6);
    rotate([0,0,30])cylinder(d=36*2/sqrt(3)*1.12,center=true,h=h*3,$fn=6);
  }
}

module cap() {
  difference() {
    union() {
      translate([0,0,7.99])metric_thread(diameter=30, pitch=2, length=15);
      hull () {
        translate([0,0,7])cylinder(d=40,h=1);
        translate([0,0,5.5])nut(1);
      }
      nut(6);
    }
    translate([0,0,1.5])cylinder(d=22,h=50);
    translate([0,0,15+7-4])cylinder(d1=20,d2=30,h=10);
  }
}
module cap_v2() {
  difference() {
    union() {
      translate([0,0,7.99])metric_thread(diameter=30, pitch=2, length=15);
      hull () {
        translate([0,0,7])cylinder(d=40,h=1);
        translate([0,0,5.5])nut(1);
      }
      nut(6);
    }
    translate([0,0,-0.1])cylinder(d=22,h=50);
    translate([0,0,15+7-4])cylinder(d1=20,d2=30,h=10);
    translate([0,0,1.3])cylinder(d=27,h=1.7);
  }
}

cap_v2();
