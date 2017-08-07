draft = false;

$fa = draft ? 12 : 1;
$fs = draft ? 2 : 0.01;

steps_per_bezier = draft ? 10 : 40;
rotate_extrude_steps = draft ? 60 : 360;

ext_pipe_outer_dia = 32;
ext_pipe_inner_dia = 29;
int_pipe_outer_dia = 26.5;

module handle_insert() {
  module stub() {
    translate([0,0,-1]) cylinder(d=ext_pipe_outer_dia, h=1);
    cylinder(d=ext_pipe_inner_dia,h=100);
    translate([0,0,15])rotate([0,90,0]) cylinder(d=6,h=ext_pipe_outer_dia/2);
  }
  
  difference() {
    stub();
    translate([0,0,-10]) cylinder(d=int_pipe_outer_dia,h=200);
    translate([0,0,50]) rotate([0,90,0]) cylinder(d=16,h=ext_pipe_outer_dia/2);
  }
}

handle_insert();
