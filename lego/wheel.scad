$fa=3;
$fs=0.2;

wheel_radius = 15;
wheel_width = 10;
thread_height = 1;
outer_rim_height = 2;

module single_wheel_thread(h = 1, start_angle=0) {
    for(a=[0:10:359]) {
        rotate([0,0,a + start_angle]) translate([wheel_radius-thread_height,0,0]) cube([thread_height*2,2,h],true);
    }
}

module wheel_thread() {
    translate([0,0,-3.5]) single_wheel_thread(3,0);
    translate([0,0,0]) single_wheel_thread(4,5);
    translate([0,0,+3.5]) single_wheel_thread(3,0);
}

module outer_rim() {
    difference() {
        cylinder(r=wheel_radius-thread_height, h=wheel_width, center=true);
        cylinder(r=wheel_radius-thread_height-outer_rim_height, h=wheel_width + 2, center=true);
    }
}

module mount_point() {
    spacing = 0.2;
    axis_long = 4.8 + spacing;
    axis_short = 1.8 + spacing;
    difference() {
        cylinder(r=4, h=wheel_width, center=true);
        translate([0,0,0]) cube([axis_short,axis_long,wheel_width+2],true);
        translate([0,0,0]) cube([axis_long,axis_short,wheel_width+2],true);
    }
}

module inner_rim() {
    for(a=[0:30:359]) {
        rotate([0,0,a]) translate([4+3,-1,0]) rotate([0,0,25])cube([14,1,wheel_width],true);
    }
}

wheel_thread();
outer_rim();
mount_point();
inner_rim();