
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




grid=96;
module template() {
    points = [[grid,0],[-grid,0],[0,grid],[0,-grid]];
    difference() {
        union() {
            for(xy=points)translate(xy)cylinder(d=20,h=10,$fn=72);
            for(c=[1,2])for(a=[0:4])hull()for(b=[0,c])translate(points[(a+b)%4])cylinder(d=5,h=10,$fn=72);
            for(c=[1,2])for(a=[0:4])hull()for(b=[0,c])translate(points[(a+b)%4]*0.6)cylinder(d=5,h=10,$fn=72);
            translate([0,0,5])for(a=[0,90])rotate([0,0,45+a])cube([5,140,10],true);
            cylinder(d=40,h=10,$fn=72);
        }
        for(xy=points)translate(xy)cylinder(d=3.1,h=50,center=true,$fn=36);
        cylinder(d=22.1,h=50,center=true,$fn=72);
        for(xy=points)translate(xy)translate([0,0,9])cylinder(d=28,h=50,$fn=36);
    }
}

module cart() {
    difference() {
        union() {
            cube2([48,36,30],TTF);
        }
        cube2([100,30.2,4],TTT);
        for(a=[1,0,-1])translate([a*16,0])cylinder(d=5.2,h=100,center=true,$fn=36);
        translate([0,10,21])rotate([0,90])cylinder(d=5.2,h=100,center=true,$fn=36);
    }
}

module motor_bracket() {
    difference() {
        union() {
            translate([0,10]) {
                cube2([5,49,42],TTF);
                mirror_y() translate([0,42/2+0.5]) {
                    hull() union() {
                        cube2([30,3,3],FFF);
                        cube2([3,3,42],FFF);
                    }
                    translate([-2.5,0])cube2([32.5,10,3]);
                }
            }
            translate([-13,0])cube2([13,50,2],FTF);
            cube2([5,36,30],TTF);
        }
        translate([0,10,21])rotate([0,90])cylinder(d=24,h=20,center=true,$fn=72);
        d=31/2;
        translate([0,10,21])for(a=[1,-1])for(b=[1,-1])translate([0,a*d,b*d])rotate([0,90])cylinder(d=3.2,h=20,center=true,$fn=24);
        translate([-14,0])cube2([11.5,30.2,10],FTT);
        mirror_y() translate([-8,20])cylinder(d=3.2,h=20,center=true,$fn=24);
        translate([0,10]) mirror_y(){
              for(a=[6,25])translate([a,28])cylinder(d=3.2,h=20,center=true,$fn=24);
        }
    }
}
module rear_bracket() {
    difference() {
        union() {
            hull() union() {
                translate([0,10,21])rotate([0,90])cylinder(d=10,h=5,$fn=72);
            cube2([5,50,2],FTF);
            }
            cube2([13,50,2],FTF);
        }
        translate([0,10,21])rotate([0,90])cylinder(d=6,h=20,center=true,$fn=72);
        d=31/2;
        translate([5,0])cube2([11.5,30.2,10],FTT);
        mirror_y() translate([9,20])cylinder(d=3.2,h=20,center=true,$fn=24);
    }
}
module manual_bracket() {
    // wip
    difference() {
        union() {
            translate([0,10]) {
                cube2([5,49,42],TTF);
                mirror_y() translate([0,42/2+0.5]) {
                    hull() union() {
                        cube2([30,3,3],FFF);
                        cube2([3,3,42],FFF);
                    }
                    translate([-2.5,0])cube2([32.5,10,3]);
                }
            }
            translate([-13,0])cube2([13,50,2],FTF);
            cube2([5,36,30],TTF);
        }
        translate([0,10,21])rotate([0,90])cylinder(d=24,h=20,center=true,$fn=72);
        d=31/2;
        translate([0,10,21])for(a=[1,-1])for(b=[1,-1])translate([0,a*d,b*d])rotate([0,90])cylinder(d=3.2,h=20,center=true,$fn=24);
        translate([-14,0])cube2([11.5,30.2,10],FTT);
        mirror_y() translate([-8,20])cylinder(d=3.2,h=20,center=true,$fn=24);
        translate([0,10]) mirror_y(){
              for(a=[6,25])translate([a,28])cylinder(d=3.2,h=20,center=true,$fn=24);
        }
    }
}

//template();
translate([-50,0])cart();
//motor_bracket();
translate([-100,0])rear_bracket();
manual_bracket();