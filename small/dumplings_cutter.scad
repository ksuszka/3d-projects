draft = false;

show_intersection = false;

form_r = 25;
flange_width = 5;
flange_height = 3;
flange_notches_count = floor(form_r*1.1);
flange_notch_r = 1.5;
inner_r = form_r - flange_width;
outer_r = form_r + 1;
handle_top = 50;
handle_bottom = 0.99;
handle_bottom_width = outer_r-inner_r;
handle_bottom_x = (outer_r+inner_r)/2;

handle_control_points =[[handle_bottom_x,-1000,handle_bottom_width],
        [handle_bottom_x,0,handle_bottom_width],
        [handle_bottom_x-15,30,2],
        [handle_bottom_x-5,48,8]
    ];


$fs = draft ? 2 : 0.2;
$fa = draft ? 12 : 2 ;
steps_per_bezier = draft ? 10 : 40;
rotate_extrude_steps = draft ? 60 : 360;


module flange() {
    module flange_shell() {
        rotate_extrude() {
            polygon([
                [inner_r, 0],
                [inner_r, 1],
                [outer_r, 1],
                [outer_r, -flange_height/2],
                [(form_r + outer_r)/2, -flange_height],
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

module handle_silhouette() {
    intersection() {
        Line2d(Curve(handle_control_points));
        translate([0,handle_bottom])
            scale([1000,handle_top-handle_bottom])
                translate([-0.5,0])
                    square(1);
    }
}

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
    if (show_intersection) cube([1000,1,1000],true);
}

//--------------------------------------------------------------------------
// Helpers
//--------------------------------------------------------------------------

// Bezier functions taken from http://www.thingiverse.com/thing:8443/
function BEZ03(u) = pow((1-u), 3);
function BEZ13(u) = 3*u*(pow((1-u),2));
function BEZ23(u) = 3*(pow(u,2))*(1-u);
function BEZ33(u) = pow(u,3);

function PointAlongBez4(p0, p1, p2, p3, u) = [
	BEZ03(u)*p0[0]+BEZ13(u)*p1[0]+BEZ23(u)*p2[0]+BEZ33(u)*p3[0],
	BEZ03(u)*p0[1]+BEZ13(u)*p1[1]+BEZ23(u)*p2[1]+BEZ33(u)*p3[1],
	BEZ03(u)*p0[2]+BEZ13(u)*p1[2]+BEZ23(u)*p2[2]+BEZ33(u)*p3[2],];

function length(v) = sqrt(v*v);

function Curve(points, steps=steps_per_bezier) = [
    for (i = [ 0 : len(points) - 2 ])
    let (   prev = points[i>0?i-1:i],
            p0 = points[i], 
            p3 = points[i+1],
            next = points[i+2<len(points)?i+2:i+1])
    let (   v0 = p3 - prev,
            v3 = next - p0)
    let (   s0 = length(p3-p0)/(length(p3-p0) + length(p0-prev)),
            s3 = length(p3-p0)/(length(p3-p0) + length(next-p3)))
    let (   p1 = p0+v0*s0*0.5,
            p2 = p3-v3*s3*0.5)
    for (u = [ 0 : 1/steps : 1])
    PointAlongBez4(p0, p1, p2, p3, u)
];

module Line2d(path) {
    for (i = [0 : len(path)-2]) hull() {
        translate([path[i][0],path[i][1]]) circle(d=path[i][2],$fn=30);
        translate([path[i+1][0],path[i+1][1]]) circle(d=path[i+1][2],$fn=30);
    }
}
