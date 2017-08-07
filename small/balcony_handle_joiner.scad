

joiner_width = 40;
joiner_height = 14;

module cut_cube(dim) {
  cut = 1;
  a = (dim[0] + dim[2])/sqrt(2)-cut;
  b = (dim[0] + dim[1])/sqrt(2)-cut;
  c = (dim[1] + dim[2])/sqrt(2)-cut;
  intersection() {
    cube(dim, center=true);
    rotate([0,45,0]) cube([a,dim[1]*2,a],center=true);
    rotate([0,0,45]) cube([b,b,dim[2]*2],center=true);
    rotate([45,0,0]) cube([dim[0]*2,c,c],center=true);
  }
}

module bar() {
  cut_cube([80, joiner_width, joiner_height]);
}

module corner() {
  translate([20,0,0]) cut_cube([80, joiner_width, joiner_height]);
  rotate([0,0,90]) translate([20,0,0]) cut_cube([80, joiner_width, joiner_height]);

}


module corners_x4() {
  corner();
  translate([85,45,0]) rotate([0,0,180]) corner();
  translate([0,90,0]) {
  corner();
  translate([85,45,0]) rotate([0,0,180]) corner();
  }
}

module corners_x2() {
  corner();
  translate([85,45,0]) rotate([0,0,180]) corner();
}

module stairs_handle() {
  a = atan(1/2);
  x = 1;
  module half() {
    intersection() {
    rotate([0,-a/2,0]) translate([25-x,0,joiner_height/2]) cut_cube([50,joiner_width, joiner_height]);
      translate([500,0,0]) cube([1000,1000,1000],center=true);
    }
  }
  half();
  mirror([1,0,0]) half();
}

module stairs_handle_x2() {
  rotate([90,0,0]) {
    stairs_handle();
    translate([0,0,20]) stairs_handle(); 
  }
}

//stairs_handle_x2();
//corners_x2();

module bar_x8() {
  for(x=[1:6]) {
    translate([0,18*x,0])
    rotate([90,0,0]) bar();
  }
  for(x=[-1,1]) translate([x*50,60,0]) rotate([90,0,90]) bar();
}
//bar_x8();

module bar_x2_h() {
  bar();
  translate([0,45,0]) bar();
}
bar_x2_h();