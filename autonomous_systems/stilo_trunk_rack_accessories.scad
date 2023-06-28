
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

module corner_bracket() {
  difference() {
    union() {
      hull() {
        for(xy=[[2,2],[38,2],[2,38],[38,10],[10,38]])
          translate(xy)cylinder(r=2,h=5,$fn=24);
        translate([20,20,30])cube2([2,2,2],TTT);
      }
    }
    translate([0,0,8])cube2([100,100,100],TTF);
    for(xy=[[8,8],[32,8],[8,32]])translate(xy) {
      cylinder(d=3.7,h=30,center=true,$fn=24);
      translate([0,0,3.5])cylinder(d1=0,d2=7,h=3.51,$fn=24);
      translate([0,0,7])cylinder(d=7,h=10,$fn=24);
    }
  }
}
module inner_corner_bracket() {
  difference() {
    union() {
      for(a=[0,1])mirror([a,-a])
      hull() {
        for(xy=[[2,2],[38,2],[38,14],[2,14]])
          translate(xy)cylinder(r=2,h=8,$fn=24);
        for(xy=[[3,3],[37,3],[37,13],[3,13]])
          translate(xy)cylinder(r=2,h=10,$fn=24);
      }
    }
    for(xy=[[8,8],[32,8],[8,32]])translate(xy) {
      cylinder(d=3.7,h=30,center=true,$fn=24);
      translate([0,0,3.5])cylinder(d1=0,d2=7,h=3.51,$fn=24);
      translate([0,0,7])cylinder(d=7,h=10,$fn=24);
    }
  }
}

module circle_bumper() {
  difference() {
    union() {
      hull() {
        cylinder(d=20,h=8,$fn=72);
        translate([0,0,30])cylinder(d=1,h=1);
      }
    }
    translate([0,0,10])cube2([100,100,100],TTF);
    {
      cylinder(d=3.7,h=30,center=true,$fn=24);
      translate([0,0,3.5])cylinder(d1=0,d2=7,h=3.51,$fn=24);
      translate([0,0,7])cylinder(d=7,h=10,$fn=24);
    }
  }
}
//corner_bracket();
//circle_bumper();
inner_corner_bracket();