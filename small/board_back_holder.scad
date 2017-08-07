$fn=60;

x = 20;
dia = 14;
module corner(z=1) {
difference() {
hull() {
  translate([0,0,0]) cylinder(d=dia,h=2);
  translate([x,0,0]) cylinder(d=dia,h=2);
  translate([0,x,0]) cylinder(d=dia,h=2);
}
  union() {
    translate([0,0,0]) translate([0,0,-1])cylinder(d1=3,d2=8,h=3.1*z);
    translate([x,0,0]) translate([0,0,-1])cylinder(d1=3,d2=8,h=3.1);
    translate([0,x,0]) translate([0,0,-1])cylinder(d1=3,d2=8,h=3.1);
  }
}
}
translate([0,0,0]) {
  corner();
  translate([23,40,0]) rotate([0,0,180])corner();
}
translate([40,0,0]) {
  corner();
  translate([23,40,0]) rotate([0,0,180])corner();
}
translate([80,0,0]) {
  corner(0);
  translate([23,40,0]) rotate([0,0,180])corner(0);
}
