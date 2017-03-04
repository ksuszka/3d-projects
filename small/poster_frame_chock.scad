$fa=3;
$fs=0.2;

module chock() {
    length = 176;
    module bulk() {
        r1 = 2.4;
        r2 = 1.6;
        hull() {
            cylinder(r=r1, h=length, center=true);
            translate([r1-r2,7,0]) cylinder(r=r2, h=length, center=true);
        }
    }
    bulk();
//    translate([0,5,0]) cube([0.5,10,length],true);
}

//rotate([0,0,0]) translate([0,-10,0]) chock();
//rotate([0,0,120]) translate([0,-10,0]) chock();
//rotate([0,0,240]) translate([0,-10,0]) chock();

rotate([0,90,0]) chock();
translate([0,12,0]) rotate([0,90,0]) chock();
translate([0,24,0]) rotate([0,90,0]) chock();
