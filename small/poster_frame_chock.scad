$fa=3;
$fs=0.2;

module chock() {
    length = 200;
    module bulk() {
        hull() {
            cylinder(r=2.5, h=length, center=true);
            translate([0.5,7,0]) cylinder(r=2, h=length, center=true);
        }
    }
    bulk();
    translate([0,5,0]) cube([0.5,10,length],true);
}

rotate([0,0,0]) translate([0,-10,0]) chock();
rotate([0,0,120]) translate([0,-10,0]) chock();
rotate([0,0,240]) translate([0,-10,0]) chock();

