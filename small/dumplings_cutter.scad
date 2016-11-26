$fs=0.2; // default 2
$fa=3; // default 12

form_r = 25;
flange_width = 5;
flange_height = 3;
flange_notches_count = 28;
flange_notch_r = 1.5;
inner_r = form_r - flange_width;

module flange() {
    module flange_shell() {
        rotate_extrude() {
            polygon([
                [inner_r, 0],
                [inner_r, 1],
                [form_r + 1, 1],
                [form_r + 1, -flange_height/2],
                [form_r + 0.5, -flange_height],
                [form_r, -flange_height],
                [form_r, 0]
            ]);
        }
    }
    module flange_notches() {
        intersection() {
            for(i=[0:360/flange_notches_count:359]) {
                rotate([0,0,i])
                    translate([inner_r,0,0]) {
                        intersection() {
                            union() {
                                translate([flange_notch_r,0,0])
                                    sphere(r=flange_notch_r);
                                translate([flange_width/2+flange_notch_r,0,0])
                                    rotate([0,90,0])
                                        cylinder(r=flange_notch_r,h=flange_width,center=true);
                            }
                        }
                    }
            }
            translate([0,0,-4.5]) cylinder(r=form_r+0.1,h=10,center=true);
        }
    }
    flange_shell();
    flange_notches();
}
handle_inner_x0 = inner_r+0.1;
handle_outer_x0 = form_r + 1.52;
handle_inner_x1 = handle_inner_x0;
handle_outer_x1 = handle_inner_x1 + 3;
handle_y1 = 10;
handle_inner_x2 = 2;
handle_outer_x2 = handle_inner_x2 + 3;
handle_y2 = 28;
handle_inner_x3 = 3;
handle_outer_x3 = 0;
handle_inner_y3 = 30;
handle_outer_y3 = 32;
handle_outer_x4 = 300;
handle_inner_x4 = 100;
handle_y4 = 150;
handle_top = 40;
handle_bottom = 0.99;

//#translate([0,0,31]) rotate([0,-45,0])cube([1000,1,1],true);
module handle_outer_edge() {
    polygon([
        [handle_outer_x0, 2],
        [handle_outer_x1, handle_y1],
        [handle_outer_x2, handle_y2],
        [handle_outer_x3, handle_outer_y3],
        [handle_outer_x4, handle_y4],
        [-100, handle_y4],
        [-100, -100],
        [handle_outer_x0, -100]
    ]);
}
module handle_inner_edge() {
    polygon([
        [handle_inner_x0, 2],
        [handle_inner_x1, handle_y1],
        [handle_inner_x2, handle_y2],
        [handle_inner_x3, handle_inner_y3],
        [handle_inner_x4, handle_y4],
        [-100, handle_y4],
        [-100, -100],
        [handle_inner_x0, -100]
    ]);
}
//handle_inner_edge();
module handle_both_edges() {
    difference() {
        offset(r=-10) offset(delta=10)
            offset(r=25) offset(delta=-25)
                handle_outer_edge();
        offset(r=-10) offset(delta=10)
            offset(r=25) offset(delta=-25)
                handle_inner_edge();
    };
}

module handle_silhouette() {
    intersection() {
        offset(r=0.9) offset(delta=-0.9)
            intersection() {
                handle_both_edges();
                translate([0,handle_top-500]) square(1000, true);
            }
        translate([0,handle_bottom+500]) square(1000, true);
    }    
}
//handle_silhouette();
module handle() {
    rotate_extrude() {
        handle_silhouette();
    }
}

module cutter() {
    handle();
    flange();
}

intersection() {
    cutter();
//    cube([1000,1,1000],true);
}
