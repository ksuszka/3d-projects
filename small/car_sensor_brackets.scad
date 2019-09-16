
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


module switch_bracket() {
    dist_x=141/2;
    hook_x=34;
    points1=[[dist_x,hook_x],[dist_x,hook_x+47.5],[-dist_x,hook_x],[-dist_x,hook_x+47.5]];
    holes1=[[dist_x,hook_x],[-dist_x,hook_x+36.8],[-dist_x,hook_x],[dist_x,hook_x+47.5]];
    holes2=[[50,0],[0,0],[-50,0]];
    points=concat(points1,holes2);
    module joint(array, i1, i2) {
        hull() {
            translate(array[i1]) cylinder(d=12,h=4);
            translate(array[i2]) cylinder(d=12,h=4);
        }
    }
    difference() {
        union() {
            joint(points, 0, 1);
            joint(points, 1, 3);
            joint(points, 3, 2);
            joint(points, 2, 6);
            joint(points, 6, 5);
            joint(points, 5, 4);
            joint(points, 4, 0);
        }
        
        for(xy=holes2)translate(xy)cylinder(d=3.2,h=20,center=true,$fn=24);
        for(xy=holes1)translate(xy) {
            cylinder(d=3.2,h=20,center=true,$fn=24);
            translate([0,0,-0.01])cylinder(d1=6.2,d2=3.2,h=3,$fn=24);
        }
    }
}

module realsense_bracket() {
    distance_x=62.25/2;
    difference() {
        union() {
            cube2([72,6,50-6],TFF);
            mirror_x()translate([25,-12.5])cube2([12,13,25-6-2],TFF);
            
            mirror_x()translate([distance_x,0])cube2([12,35,5],TFF);
            mirror_x()translate([distance_x+6,0])hull() {
                cube2([3,35,5],TFF);
                cube2([3,6,50-6],TFF);
            }
        }
        mirror_x()translate([50/2,0,12.5-6]) {
            rotate([90,0])cylinder(d=3.2,h=100,center=true,$fn=24);
            translate([0,25-12.5+6])rotate([90,0])cylinder(d=6,h=25,$fn=36);
        }
        mirror_x()translate([45/2,0,25+12.5-6]) {
            rotate([90,0])cylinder(d=3.2,h=100,center=true,$fn=24);
        }
        mirror_x() for(a=[10,20,30])translate([distance_x,a])cylinder(d=3.2,h=30,$fn=24,center=true);
    }
}

switch_bracket();
//realsense_bracket();