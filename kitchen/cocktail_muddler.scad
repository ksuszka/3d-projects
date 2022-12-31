module handle() {
intersection_for(n=[0:5])rotate([0,0,n*60])
translate([-10,0])rotate_extrude($fn=30)
intersection() {
  square([30,205]);
  translate([10,0])difference() {
    union() {
      translate([0,50])square([12,155]);
      translate([0,190])square([15,50]);
      translate([-285,50])circle(d=600,$fn=240);
      translate([-185,190])circle(d=400,$fn=240);
    }
    translate([310,122])circle(d=600,$fn=240);
  }
}
}
difference() {
  handle();
  for(a=[0:120:359])rotate([0,0,a])
  for(x=[-2:2])translate([x*5,0,205])rotate([0,45])cube([3,50,3],center=true);
}