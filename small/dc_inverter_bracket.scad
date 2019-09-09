
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


holes_x=180;
holes_y=32;
holed_d=6.2;
difference() {
    union() mirror_y() {
        for(a=[0,1])translate([holes_x*a+10,holes_y/2]) cylinder(d=16,h=9);
        cube2([36,50,17],FTF);
        cube2([45,50,9],FTF);
        translate([50,94/2])cube2([130,10,9],FTF);
        translate([holes_x+10,0])cube2([16,50,9],TTF);
        hull() {
            translate([170,94/2+4])cube2([16,1,9],FFF);
            translate([holes_x+10,24])cube2([16,1,9],TTF);
        }
        hull() {
            translate([50,94/2+4])cube2([16,1,9],FFF);
            translate([36,24])cube2([16,1,9],TTF);
        }
    }
    mirror_y() {
        for(a=[0,1])translate([holes_x*a+10,holes_y/2]) {
           cylinder(d=6.2,h=30,center=true,$fn=24);
           translate([0,0,4])rotate([0,0,30])cylinder(d=10*2/sqrt(3),h=30,$fn=6);
        }
        translate([0,94/2,6])cube2([500,5,10],TTF);
        for(a=[62,171])translate([a,0]) {
            cube2([5,200,4],TTT);
            translate([0,0,7])cube2([5,200,4],TTF);
        }
    }
}
