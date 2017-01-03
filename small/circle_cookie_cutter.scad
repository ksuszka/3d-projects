// Circle cookie cutter

draft = true;

steps_per_bezier = draft ? 10 : 40;
rotate_extrude_steps = draft ? 60 : 360;

// Bezier functions taken from http://www.thingiverse.com/thing:8443/
function BEZ03(u) = pow((1-u), 3);
function BEZ13(u) = 3*u*(pow((1-u),2));
function BEZ23(u) = 3*(pow(u,2))*(1-u);
function BEZ33(u) = pow(u,3);

function PointAlongBez4(p0, p1, p2, p3, u) = [
	BEZ03(u)*p0[0]+BEZ13(u)*p1[0]+BEZ23(u)*p2[0]+BEZ33(u)*p3[0],
	BEZ03(u)*p0[1]+BEZ13(u)*p1[1]+BEZ23(u)*p2[1]+BEZ33(u)*p3[1]];

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

module Line2d(path, d=1) {
    for (i = [0 : len(path)-2]) hull() {
        translate(path[i]) circle(d=d,$fn=10);
        translate(path[i+1]) circle(d=d,$fn=10);
    }
}

module Edge(d1,delta_d2=5, delta_di=-5, w=1.5) {
    r1 = d1/2;
    delta_r2 = delta_d2/2;
    v = [[r1,-2000],[r1,5],[r1+delta_di/2,22],[r1+delta_r2,45],[r1+delta_r2,2000]];
    intersection() {
        Line2d(Curve(v),d=w);
        translate([0,w]) square([10000,50-2*w]);
    }
    polygon([[r1-w/2,w],[r1+w/2,w],[r1+0.3,0],[r1-0.3,0]]);
    polygon([[r1+delta_r2-w/2,50-w],[r1+delta_r2+w/2,50-w],[r1+delta_r2+0.3,50],[r1+delta_r2-0.3,50]]);
}

module Edges() {
    for (i=[10:10:20])
        Edge(i);
    Edge(d1=30, delta_d2=10, delta_di=-5);
    for (i=[50:20:80])
        Edge(d1=i, delta_d2=10, delta_di=-10);
}

rotate_extrude($fn=rotate_extrude_steps) {
    Edges();
}