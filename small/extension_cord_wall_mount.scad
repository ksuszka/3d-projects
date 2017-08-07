$fa=1;
$fs=0.2;

// 43 - odstep miedzy gniazdkami
// 2.5 - dolny margines

// 54 - szerokosc w srodku
// 46 - szerokosc na brzegu
// 39 - glebokosc
module oval_cube(h=10) {
  intersection() {
    scale([1,1.4,1])cylinder(d=54,h=h,center=true);  
    cube([1000,39,1000],true);
  }
}
module inner_mold() {
  intersection() {
    // width on edge = 46mm
    oval_cube(60);
    rotate([0,90,0]) oval_cube(60);
  }
  translate([0,0,100]) oval_cube(200);
  #color("red") translate([0,-20,0]) cube([46,1,10],true);
}

module mold() {
  scale(1.01) inner_mold();
  // plugs
  for(x=[0:2]) translate([0,0,43*x+1]) rotate([90,0,0]) cylinder(d=40,h=30);
  // screws
  for(x=[0:1]) translate([0,39/2+8,90*x]) rotate([90,0,0])cylinder(d1=0, d2=8, h=8.1);
}

difference() {
  translate([0,0.5,36+6]) cube([60,39+5,43*3+12],true);
  mold();
}

