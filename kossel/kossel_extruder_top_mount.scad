beam_size = 15;

module beam(length) {
    cube([beam_size, beam_size, length], true);
}

long_beam_distance = 383;
long_beam_length = 750;
short_beam_length = 360;
short_beam_offset = 16.8; // ???

module frame() {
    half_beam_size = beam_size / 2;
    module long_beam() {
        translate([0, 0, long_beam_length / 2])
            beam(long_beam_length);
    }
    
    module short_beam() {
        translate([0, 0, half_beam_size])
        rotate([0, 90, 0])
            beam(short_beam_length);
    }
    
    module side() {
        translate([0, -short_beam_offset, 0])
            short_beam();
        translate([0, -short_beam_offset, beam_size * 2])
            short_beam();
        translate([0, -short_beam_offset, long_beam_length - beam_size]) 
            short_beam();
    }
    translate([0,-long_beam_distance*sqrt(3)/3,0]) {
        long_beam();
        rotate([0, 0, 60])
            translate([long_beam_distance, 0, 0])
                rotate([0, 0, 60])
                    long_beam();
        rotate([0, 0, 120])
            translate([long_beam_distance, 0, 0])
                rotate([0, 0, 120])
                    long_beam();
        
        rotate([0, 0, 60])
            translate([long_beam_distance/2, 0, 0])
                side();
        
        rotate([0, 0, 300])
            translate([-long_beam_distance/2, 0, 0])
                side();
        
        rotate([0, 0, 60])
            translate([long_beam_distance, 0, 0])
                rotate([0, 0, 120])
                    translate([long_beam_distance/2, 0, 0])
                        side();
    }
}

module bed() {
    bed_diameter = 250;
    translate([0, 0, beam_size * 3 + 4])
        cylinder(r = bed_diameter / 2, h = 3);
}

frame();
bed();

module one_third() {
    short_wall_distance = 20;
    long_wall_distance = 43;
    short_wall_width = 120;
    long_wall_width = 380;

    //short_wall_distance = 7;
    //long_wall_distance = 50;
    //short_wall_width = 153;
    //long_wall_width = 329;
    
    //short_wall_distance = 5;
    //long_wall_distance = 50;
    //short_wall_width = 155.9;
    //long_wall_width = 324.75;
    
    //short_wall_distance = 7.35;
    //long_wall_distance = 50;
    //short_wall_width = 153;
    //long_wall_width = 330;
    wall_ext=3.3;
    color("red") {
        translate([0,-35.62 -7.5,750+ 3])
            cube([15,356,6],true);
    }
    color("blue") {
        translate([0,356/2+25-35.62 -7.5,750+ 3])
            cube([15,50,6],true);
    }
    wall_height = 720;
    #translate([0,-long_beam_distance*sqrt(3)/3 -9-short_wall_distance,750/2+15]) {
        color("Green") cube([short_wall_width,3,wall_height], true);
        color("PaleGreen") cube([short_wall_width+wall_ext,0.05,wall_height], true);
    }
    #rotate([0,0,60]) translate([0,-(356/2-35.62 -7.5+1.5+long_wall_distance),750/2+15]) {
        color("Green") cube([long_wall_width,3,wall_height], true);
        color("PaleGreen") cube([long_wall_width+wall_ext,0.05,wall_height], true);
    }

    
//    xx = 260;
//    yy = 90;
//    translate([xx,yy,0]) color("green") cube([2,2,10000],true);
//    translate([-xx,-yy,0])
//    rotate([0,0,60]) translate([0,-(356/2-35.62 -7.5+1.5+long_wall_distance),750/2+15]) {
//        color("Green") cube([long_wall_width,3,wall_height], true);
//        color("PaleGreen") cube([long_wall_width+wall_ext,0.05,wall_height], true);
//    }

}

//one_third();
//rotate([0,0,120]) one_third();
//rotate([0,0,-120]) one_third();


module extruder_holder(part="all") {
    brace_wall_thickness = 4;
    rotor_r = 18;
    clamp_h = 22;
    clamp_thickness = 7;
    offset_y = -25;
    height = 152.5;
    
    module brace_negative() {
        difference() {
            union() {
                translate([0,0,500+beam_size/2])cube([1000,1000,1000],true);
                translate([0,500+beam_size/2,0])cube([1000,1000,1000],true);
                translate([0,500-beam_size/2,500-beam_size/2])cube([1000,1000,1000],true);
            }
            translate([0,0,-beam_size/2]) cube([1000+1, 3, 5],true);
            translate([0,-beam_size/2,0]) cube([1000+1, 5, 3],true);
        }
    }

    module brace(length = 50) {
        difference() {
            cube([length, beam_size + brace_wall_thickness*2, beam_size + brace_wall_thickness*2],true);
            brace_negative();
        }
    }
    
    module brace_screw_mold() {
        cylinder(d=3, h=1000, center=true, $fn=60);
        translate([0,0,-500- beam_size/2-brace_wall_thickness]) cylinder(d=6, h=1000, center=true, $fn=60);
        translate([0,0,500- beam_size/2]) cylinder(d=7, h=1000, center=true, $fn=60);
    }

    module clamp_hole() {
        cylinder(r=rotor_r, h=clamp_h+1, center=true);
    }
    
    module screw_mold(length=8, head_length=100) {
        cylinder(d=3, h=length+head_length*2, center=true, $fn=60);
        translate([0,0,head_length/2+length/2]) cylinder(d=6.2, h=head_length, center=true, $fn=6);
        translate([0,0,-head_length/2-length/2]) cylinder(d=6, h=head_length, center=true, $fn=60);
    }

    module clamp_screws_mold() {
        module clamp_screw_mold() {
            rotate([0,90,0]) translate([0,0,-3]) screw_mold(16);
        }
        screw_offset_y = rotor_r + clamp_thickness+5;
        screw_offset_z = 6;
        translate([0,screw_offset_y,screw_offset_z]) clamp_screw_mold();
        translate([0,screw_offset_y,-screw_offset_z]) clamp_screw_mold();
        translate([0,-screw_offset_y,screw_offset_z]) clamp_screw_mold();
        translate([0,-screw_offset_y,-screw_offset_z]) clamp_screw_mold();
    }
    module clamp() {
        difference() {
            union() {
                cylinder(r=rotor_r+clamp_thickness, h=clamp_h, center=true);
                cube([16,(rotor_r + clamp_thickness+10)*2,clamp_h],true);
            }
            clamp_hole();
            //clamp_screws_mold();
        }
    }

    module extruder_holder_arms() {
        base_x_offset = (offset_y + (long_beam_distance + short_beam_offset*2*sqrt(3))*sqrt(3)/3)/sqrt(3);
        module arms() {
            difference() {
                union() {
                    translate([base_x_offset,0,0]) rotate([0,0,-120]) brace(60);
                    arm_w = 10;
                    translate([0,clamp_h/2,0]) rotate([90,0,0]) linear_extrude(height=clamp_h) {
                        polygon([[base_x_offset+arm_w, -arm_w],
                            [+arm_w+10, -arm_w-height-5],
                            [-arm_w+10, +arm_w-height-5],
                            [base_x_offset-arm_w, +arm_w]]);
                    };
                    translate([0,0,-height+20]) cube([60,clamp_h,20],true);
                    translate([0,0,-height+30]) cube([16,clamp_h,30],true);
                }
                translate([base_x_offset,0,0]) rotate([0,0,-120]) brace_negative();
                translate([0,0,-height]) rotate([90,0,0]) clamp_hole();
//                translate([0,0,-height]) rotate([90,0,0]) clamp_screws_mold();
                translate([0,-500-clamp_h/2,0]) cube([1000,1000,1000],true);
                
                translate([base_x_offset,0,0]) rotate([0,0,-120]) {
                    translate([-5,0,0]) brace_screw_mold();
                    translate([10,0,0]) rotate([-90,0,0]) brace_screw_mold();
                    translate([-20,0,0]) rotate([-90,0,0]) brace_screw_mold();
                }
                
                translate([120,0,-20]) rotate([90,0,0]) cylinder(d=3,h=1000,center=true);
                translate([110,0,-20]) rotate([90,0,0]) cylinder(d=3,h=1000,center=true);
                translate([120,0,-30]) rotate([90,0,0]) cylinder(d=3,h=1000,center=true);
                translate([110,0,-30]) rotate([90,0,0]) cylinder(d=3,h=1000,center=true);
                translate([100,0,-30]) rotate([90,0,0]) cylinder(d=3,h=1000,center=true);
                translate([110,0,-40]) rotate([90,0,0]) cylinder(d=3,h=1000,center=true);
                translate([100,0,-40]) rotate([90,0,0]) cylinder(d=3,h=1000,center=true);
                translate([100,0,-50]) rotate([90,0,0]) cylinder(d=3,h=1000,center=true);
                translate([90,0,-50]) rotate([90,0,0]) cylinder(d=3,h=1000,center=true);
                translate([90,0,-60]) rotate([90,0,0]) cylinder(d=3,h=1000,center=true);
                translate([80,0,-60]) rotate([90,0,0]) cylinder(d=3,h=1000,center=true);
                translate([80,0,-70]) rotate([90,0,0]) cylinder(d=3,h=1000,center=true);
                translate([70,0,-70]) rotate([90,0,0]) cylinder(d=3,h=1000,center=true);
                translate([70,0,-80]) rotate([90,0,0]) cylinder(d=3,h=1000,center=true);
                translate([60,0,-80]) rotate([90,0,0]) cylinder(d=3,h=1000,center=true);
                translate([70,0,-90]) rotate([90,0,0]) cylinder(d=3,h=1000,center=true);
                translate([60,0,-90]) rotate([90,0,0]) cylinder(d=3,h=1000,center=true);
                translate([60,0,-100]) rotate([90,0,0]) cylinder(d=3,h=1000,center=true);
                translate([50,0,-100]) rotate([90,0,0]) cylinder(d=3,h=1000,center=true);
                translate([50,0,-110]) rotate([90,0,0]) cylinder(d=3,h=1000,center=true);
                translate([40,0,-110]) rotate([90,0,0]) cylinder(d=3,h=1000,center=true);
                translate([40,0,-120]) rotate([90,0,0]) cylinder(d=3,h=1000,center=true);
                translate([40,0,-130]) rotate([90,0,0]) cylinder(d=3,h=1000,center=true);
            }
        }
        translate([0,offset_y,0]) {
            difference() {
                union() {
                    translate([0,0,-height]) rotate([90,90,0]) clamp();
                    arms();
                    mirror([1,0,0]) arms();
                }
                translate([0,0,-height]) rotate([90,90,0]) clamp_screws_mold();
                translate([0,6,-height+37]) rotate([0,90,0]) screw_mold(10,10);
                translate([0,-6,-height+37]) rotate([0,90,0]) screw_mold(10,10);
                    
            }
        }
    }

    if (part == "left") {
        intersection() {
            extruder_holder_arms(); 
            translate([500,0,500-height]) cube([1000,1000,1000],true);
        }
    } else if (part == "right") {
        intersection() {
            extruder_holder_arms(); 
            translate([-500,0,500-height]) cube([1000,1000,1000],true);
        }
    } else if (part == "bottom") {
        intersection() {
            extruder_holder_arms(); 
            translate([0,0,-500-height]) cube([1000,1000,1000],true);
        }
    } else {
        extruder_holder_arms();
    }
}

!translate([0,0,long_beam_length-beam_size/2]) extruder_holder("all");
translate([0,0,260+beam_size * 3 + 7]) color("red") cube([4,4,520],true);