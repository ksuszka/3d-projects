use <BezierScad.scad>;

// dimension
// heights:
// - base = 0mm
// - slope highest point = 26.5mm
// - slope mid point = 14mm
// - hook lowest edge = 19mm

module outer_horizontal_boundary(dim, x0, y0, x1, y1, y2) {
    module half() {
        BezLine([
          [0, 0],
          [dim*y0, dim*x0],
          [dim*y1, dim*x1],
          [dim*y2, dim],
          [0, dim],
          ], width = [0.1, 0.1], resolution = 6);
    }
    half();
    mirror([1,0,0]) half();
}

/*
#color("green") difference() {
translate([0,-19.5, 3]) hull() linear_extrude(height=10) outer_horizontal_boundary(52, 0.06, 0.72, 0.66, 0.41, 0.30);
  translate([0,0.5,0]) battery_tower2();
}
*/

/*
#color("green") difference() {
      translate([0,-19.5, -55]) hull() linear_extrude(height=10)    outer_horizontal_boundary(52, 0.04, 0.68, 0.66, 0.45, 0.30);
  translate([0,0.5,0]) battery_tower();
}//*/


//translate([0,-15,-16]) hull() outer_horizontal_boundary(46.4, 0.9, 0.58, 0.37, 0.26);
module outline(height=10, type=1) {
  translate([0,-19.5, -height/2]) hull() linear_extrude(height=height) {
    if (type == 1) {
      outer_horizontal_boundary(52, 0.04, 0.68, 0.66, 0.45, 0.30);
    } else if (type == 2) {
      outer_horizontal_boundary(52, 0.04, 0.73, 0.81, 0.43, 0.2);
    }
  }
}

module thin_wall() {
  type = 2;
  intersection() {
//*    
  minkowski() {
    difference() {
      cube([100,100,100], true);
      outline(110,type);
    }
    sphere(r=1);
  }
//    */
    outline(110,type);
  }
}

module hook() {
  radius=40;
  intersection() {
    translate([0,radius,0]) {
      translate([0,0,19]) cylinder(r=radius+1.5,h=4,$fn=120);
      cylinder(r=radius,h=20,$fn=120); 
    };
    cube([10,10,50],true);
  }
  intersection() {
    translate([0,radius,0]) {
      cylinder(r=radius-0.5,h=23,$fn=120); 
    };
    translate([2,0,0]) cube([14,10,50],true);
  }
}
module hooks() {
  for(a=[0:1:1]) {
    mirror([a,0,0]) translate([17.5,14,0]) color("green")rotate([0,0,112]) hook();
  }

}
//translate([20,-5,60]) cube([1,29,1],true);
%translate([50,-19.5,26.5]) rotate([-19,0,0]) translate([0,0,0.5])color("gray") cube([1,100,1],true);
%translate([50,22.5,0]) rotate([-65,0,0]) translate([0,0,0.5])color("gray") cube([1,100,1],true);

module mold() {
  hull() 
  {
  translate([0,13.63,11.91]) rotate([0,90,0]) cylinder(d=6,h=100,center=true,$fn=36);
//  translate([0,11,10.1]) rotate([0,90,0]) cylinder(d=10,h=100,center=true,$fn=36);
  translate([0,-19.5,26.5])rotate([-19,0,0])translate([0,0,-20])cube([100,2,40],true);
  translate([0,22.5,0])rotate([-65,0,0])translate([0,0,-1])cube([100,20,2],true);
  }
}
//color("red")mold();
difference() {
  union() {
//    intersection() {
//      thin_wall();  
//      translate([0,0,15]) cube([1000,1000,30], true);
//    }
    color("blue")difference() {
//      translate([0,0,26+5]) outline(16,2);
      translate([0,0,20]) outline(40,2);
      translate([0,0.5,-0.01]) battery_tower();
    }
  }
  mold();
  hooks();
}
//battery_tower();



//translate([0,0,120])color("green")cube([46,1,1],true);
//translate([0,-18, 50]) hull() outer_horizontal_boundary(50, 0.83, 0.62, 0.37, 0.26);

module battery_tower() {
    clearance = 0.0;
    battery_r = 11 + clearance;
    battery_distance = 9.4;
    cell_h = 60;
    big_tower_h = cell_h + 10;
    battery_d = battery_r * 2;
    big_tower_w = battery_d * 1.1;
    triangle_h = battery_distance * sqrt(3);
    big_tower_offset = triangle_h - battery_r;
    
    module trunk(height) {
        hull() {
            translate([-battery_distance, 0, 0])
                cylinder(height, r=battery_r,$fn=60);
            translate([battery_distance, 0, 0])
                cylinder(height, r=battery_r,$fn=60);
            translate([0, triangle_h, 0])
                cylinder(height, r=battery_r+0.0,$fn=60);
        }
    }
    
    trunk(cell_h);
    
    module edge(height) {
      hull() {
      translate([12.8,21.5])cylinder(d=1.5+ clearance*2,h=height, $fn=36);
      translate([12.8,19.4])cylinder(d=1.5+ clearance*2,h=height, $fn=36);
      translate([10,19.2])cylinder(d=4+ clearance*2,h=height, $fn=36);
      }
    }
    color("red") edge(big_tower_h);
    color("red") mirror([1,0,0]) edge(big_tower_h);
    intersection() {
        trunk(big_tower_h);
        translate([-big_tower_w / 2, big_tower_offset, 0])
            cube([big_tower_w, big_tower_w, big_tower_h]);
    }
    
    color("blue") translate([6.5, 15, big_tower_h]) cube([0.2, 7, 10], center = true);
    color("blue") translate([-6.5, 15, big_tower_h]) cube([0.2, 7, 10], center = true);
}





