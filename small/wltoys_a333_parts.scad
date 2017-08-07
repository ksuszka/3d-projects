$fn=60;

module chassis_holder(width, hole_angle, pin_angle) {
  column_height = 19;
  hole_dia=1.5;
  for(x=[-15,15]) {
    translate([x,0,0]) {
      difference() {
        cylinder(d=4,h=column_height); 
        translate([0,0,5]) rotate([90,0,0]) cylinder(d=hole_dia,h=10,center=true);
      }
    }
  }
  translate([0,0,column_height]) {
    for(x=[-1,1]) {
      translate([x*width/2,0,0]) {
        translate([0,0,8]) rotate([pin_angle,0,0]) translate([0,5,0]) {
          difference() {
            union() {
              cylinder(d=4,h=6); 
              translate([0,0,6]) sphere(d=4);
            }
            translate([0,0,5]) rotate([hole_angle,90,0]) cylinder(d=hole_dia,h=10,center=true);
          }
          
        }
        hull() {
          translate([0,0,8]) rotate([pin_angle,0,0]) translate([0,5,0]) cylinder(d=10,h=2);
          translate([0,0,4]) translate([x*1,0,0]) cylinder(d=4,h=6);
          translate([0,0,4]) translate([x*-2,0,0])cylinder(d=4,h=6);
        }
        translate([x*1,0,0]) cylinder(d=4,h=6);
      }
    }
  }
  translate([0,0,column_height+2]) cube([width+2,4,4],true);
}

module chassis_back_holder() {
  chassis_holder(width=80,hole_angle=0,pin_angle=0);
}

module chassis_front_holder() {
  chassis_holder(width=70,hole_angle=90,pin_angle=10);
}

rotate([90,0,0]) chassis_back_holder();
translate([5,-17,0]) rotate([90,0,180]) chassis_front_holder();