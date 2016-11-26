$fs=0.2; // default 2
$fa=3; // default 12

module stand(dia=80) {
    trunk_height=30;
    module trunk() {
        difference() {
            linear_extrude(height=trunk_height, scale=5/10) {
                circle(d=10);
            }
        }
    }

    module legs() {
        module legs_mold() {
            for(i=[0:120:359]) {
                rotate([0,0,i]) translate([-2,0,0]) cube([4,dia/2,15]);
            }
            difference() {
                cylinder(r=dia/2+0.1,h=2);
                translate([0,0,-1]) cylinder(r=dia/2-4,h=4);
            }
        }
        intersection() {
            legs_mold();
            linear_extrude(height=15, scale=0) {
                circle(r=dia/2*1.14);
            }
        }
    }
    difference() {
        union() {
            legs();
            trunk();
        }
        cylinder(d=1.5,h=trunk_height*4,center=true);
    }
}
stand(80);
translate([85,0,0]) stand(80);
translate([42,62,0]) stand(60);
