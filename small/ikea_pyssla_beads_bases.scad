draft = true;
$fa = draft ? 12 : 3;
$fs = draft ? 2 : 0.1;
pin_fn = draft ? 12 : 24;

pin_height = 2.8;
pin_distance = 5;
pin_dia = 2.3;
base_height = 2;

board_type = "circle";
n = 8;

thing(board_type, n);

module thing(board_type, n) {
  if (board_type == "circle") circle_board(n);
  if (board_type == "square") rectangular_board(n,n);
  if (board_type == "heart") heart_board(n);
  if (board_type == "triangle") triangle_board(n);
  if (board_type == "hexagon") hexagon_board(n);
  if (board_type == "star") star_board(n);
}


module pin() {
  round_d=pin_dia/2;
  intersection() {
    minkowski() {
      translate([0,0,0]) cylinder(d=pin_dia-round_d,h=pin_height-round_d/2,$fn=pin_fn);
      sphere(d=round_d,$fn=pin_fn);
    }
    cylinder(d=pin_dia*2,h=pin_height,$fn=pin_fn);
  }
}

module circle_board(n=8) {
  module pins() {
    pin();
    for(i=[1:1:n]) {
      r = i*pin_distance;
      c = i*6;
      for(a=[0:360/c:359]) {
        rotate([0,0,a]) translate([r,0,0]) pin();
      }
    }
  }
  translate([0,0,base_height-0.01]) pins();
  cylinder(r=(n+1)*pin_distance,h=base_height);
}

module rectangular_board(sx=1, sy=1) {
  translate([0,0,base_height-0.01]) {
    for(x=[1:1:sx]) for(y=[1:1:sy]) {
      translate([x*pin_distance,y*pin_distance,0]) pin();
    }
  }
  cube([(sx+1)*pin_distance,(sy+1)*pin_distance,base_height]);
}

module heart_board(n=3) {
  module half_circle_board(n) {
    intersection() {
      circle_board(n);
      inf=10000;
      translate([0,inf/2-pin_distance/2,0]) cube([inf,inf,inf],center=true);
    }
  }
  w = n*2 + 1;
  rectangular_board(w,w);
  translate([w*pin_distance,0,0]) rectangular_board(n-1,w);
  translate([0,w*pin_distance,0]) rectangular_board(w,n-1);
  translate([(n+1)*pin_distance,(w+n)*pin_distance,0]) half_circle_board(n);
  translate([(w+n)*pin_distance,(n+1)*pin_distance,0]) rotate([0,0,-90])half_circle_board(n);
}

function triangle_h(a) = a*sqrt(3)/2;

module triangle_board(n=3) {
  translate([0,0,base_height-0.01]) {
    for(x=[0:1:n-1]) for(y=[n - x-1:-1:0]) {
      translate([pin_distance*triangle_h(x-(n-1)/3), pin_distance*(y+x/2-(n-1)/2),0]) pin();
    }
  }
  minkowski() {
    cylinder(d=pin_distance*((n-1)*2*sqrt(3)/3),h=base_height-0.5,$fn=3);
    cylinder(r=pin_distance,h=0.5);
  }
}

module hexagon_board(n=3) {
  for(a=[0:60:359]) {
    rotate([0,0,a]) {
      translate([-pin_distance*triangle_h(n-1)*2/3,0,0])
        triangle_board(n);
    }
  }
}

module star_board(n=3) {
  for(a=[0:60:359]) {
    rotate([0,0,a]) {
      translate([-pin_distance*triangle_h(n-1)*2/3,0,0])
        triangle_board(n);
      translate([-pin_distance*triangle_h(n-1)*4/3,0,0])
        mirror([1,0,0])
        triangle_board(n);
    }
  }
}
