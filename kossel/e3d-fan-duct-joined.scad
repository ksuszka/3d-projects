$fa=12; //3
$fs=1; //0.2

radiator_height = 26;
radiator_diameter = 22;
radiator_radius = radiator_diameter / 2;
thin_wall_radius = 1;
radiator_cut_angle = 65;

//dependency:https://github.com/jcrocholl/kossel/raw/master/effector.stl
%translate([0,0,40]) import(".dependencies/effector.stl");

//dependency:https://cdn.thingiverse.com/assets/5d/65/0d/e6/4c/E3D_v6_To_Spec.stl
%rotate([0,0,90]) translate([5.195,-3.384,24.52]) import(".dependencies/E3D_v6_To_Spec.stl");

//cylinder(r=1.4, h=10, center=true);

// fan mount part
fan_width = 40;
fan_wall_thickness = 1;
fan_wall_spacing = 1;
fan_mount_corner_radius = 3;
fan_mount_distance_to_center = 35;
fan_plate_thickness = 1;
fan_duct_height = fan_width + 2 * fan_wall_thickness + 2 * fan_wall_spacing;

module fan_mount() {
    fan_mount_thickness = 5 + fan_plate_thickness;
    module outer_hull() {
        linear_extrude(height=fan_mount_thickness) {
            offset(r=fan_mount_corner_radius + fan_wall_spacing + fan_wall_thickness)
            offset(delta=-fan_mount_corner_radius)
                square([fan_width, fan_width], true);
        };
    }
    module inner_hull() {
        translate([0,0,fan_plate_thickness])
        linear_extrude(height=fan_mount_thickness) {
            offset(r=fan_mount_corner_radius + fan_wall_spacing)
            offset(delta=-fan_mount_corner_radius)
                square([fan_width, fan_width], true);
        };
    }
   // cube([fan_width, fan_width, fan_plate_thickness], true);
    difference() {
        outer_hull();
        inner_hull();
    }
}
//!fan_mount();

module fan_screws_mold() {
    hole_dia = 4;
    hole_screw_head_dia = 8;
    hole_spacing = 32;
    
    for(x=[-hole_spacing/2:hole_spacing:hole_spacing/2])
        for(y=[-hole_spacing/2:hole_spacing:hole_spacing/2])
            union() {
                translate([x,y,50-1])
                    cylinder(r=hole_dia/2, h=100, center=true);
                translate([x*2,y*2,0])
                    mirror([0,0,1])
                    linear_extrude(height=fan_mount_distance_to_center, scale=0.7) {
                        minkowski() {
                            square([hole_spacing, hole_spacing],true);
                            circle(r=hole_screw_head_dia/2, center=true);
                        }
                    }
            }
}
//!fan_screws_mold();

module fan_mount_outer_hull_mold() {
    module outer_hull() {
        linear_extrude(height=200) {
            offset(r=fan_mount_corner_radius + fan_wall_spacing + fan_wall_thickness)
            offset(delta=-fan_mount_corner_radius)
                square([fan_width, fan_width], true);
        };
    }
    translate([0,0,-100])
        outer_hull();
}
//!fan_mount_outer_hull_mold();

module fan_mount_position() {
    translate([0,-fan_mount_distance_to_center,0])
        rotate([80,0,0])
            translate([0,fan_duct_height/2,0])
                children();
}


module fan_mount_duct_part_mold() {
    fan_mount_position()
        translate([0,0,-50+fan_plate_thickness])
            cube([100,100,100],true);
}
//!fan_mount_duct_part_mold();

// A form of a radiator to be cut from other parts
module radiator_trunk() {
    module holding_ring() {
        ring_number = 4;
        translate([0, 0, 0.75 + 2.5 * ring_number])
            rotate_extrude($fn=100)
                translate([radiator_diameter / 2, 0, 0])
                    polygon ([[-1,0.5], [-1,1.5], [1,2], [1,0]]);
    }
    
    difference () {
        translate([0, 0, - 2*radiator_height])
            cylinder(r = radiator_diameter / 2, h = radiator_height * 4);
        holding_ring();
    }
}
//!radiator_trunk();

module mounting_plates() {
    width = 44;
    height = 22;
    thickness = 5;
    hole_x_distance = width / 2 - 4;
    hole_y1_distance = 6;
    hole_y2_distance = hole_y1_distance + 10;
    hole_radius = 1.25;
    difference() {
        minkowski() {
            translate([0, -thickness, height / 2]) cube([width - 2, thickness - 1, height - 2], center=true);
            rotate([90,0,0]) cylinder(r=1, h=1, center=true);
        }
        translate([hole_x_distance,0,hole_y1_distance])
            rotate([90,0,0]) cylinder(r=hole_radius, h=thickness*100, center=true);
        translate([hole_x_distance,0,hole_y2_distance])
            rotate([90,0,0]) cylinder(r=hole_radius, h=thickness*100, center=true);
        translate([-hole_x_distance,0,hole_y1_distance])
            rotate([90,0,0]) cylinder(r=hole_radius, h=thickness*100, center=true);
        translate([-hole_x_distance,0,hole_y2_distance])
            rotate([90,0,0]) cylinder(r=hole_radius, h=thickness*100, center=true);
        //radiator_trunk();
    };
}
//!mounting_plates();

// A triangle-like shape cut from the front so air output is free
module radiator_cut_2D() {
    polygon([[0,0],
        [-r*sin(radiator_cut_angle),r*cos(radiator_cut_angle)],
        [-r,r],
        [r,r],
        [r*sin(radiator_cut_angle),r*cos(radiator_cut_angle)]]);
};

module holding_arms_half_2D() {
    minkowski() {
            r = radiator_diameter;  // much bigger then radiator radius
        intersection() {
            circle(radiator_radius + thin_wall_radius, center = true);
            polygon([[0,0],
                [r*sin(radiator_cut_angle),r*cos(radiator_cut_angle)],
                [r,r],
                [r,-r],
                [0,-r]]);
        }
        circle(r = thin_wall_radius);
    };
};

module trunk_half_2D() {
    hull () {
        translate([0, -fan_mount_distance_to_center, 0]) square([fan_width + fan_wall_thickness*2+ fan_wall_spacing*2,1],center=true);
        holding_arms_half_2D();
    }
}

module trunk_2D() {
    trunk_half_2D();
    mirror([1,0,0]) trunk_half_2D();
}

module holding_arms() {
    linear_extrude(height=26) {
        holding_arms_half_2D();
        mirror([1,0,0]) holding_arms_half_2D();
    }
}

module fan_duct_zy_mold() {
    rotate([90,0,90])
        linear_extrude(h=200,center=true)
            polygon([
                [100,0],
                [100,radiator_height],
                [0,radiator_height],
                [-9,radiator_height+1],
                [-9,100],
                [-100,0]]);
}

module fan_duct_trunk() {
    difference() {
        union() {
            intersection() {
                union() {
                    air_duct_wall_mold();   
                    holding_arms();
                }
                //linear_extrude(height=50) trunk_2D();
                //fan_mount_position() fan_mount_outer_hull_mold();
                fan_duct_zy_mold();
                fan_mount_duct_part_mold();

            }
            fan_mount_position() fan_mount();
        }
        fan_mount_position() fan_screws_mold();
        radiator_trunk();
    }
}

module fan_screws_walls_mold() {
    intersection() {
        fan_duct_trunk();
        fan_mount_position() minkowski() {
            fan_screws_mold();
            cube([1,1,fan_plate_thickness*2],true);
        }
    }
}


module air_duct_mold() {
    module back_plate() {
        fan_mount_position() translate([0,0,1]) cylinder(r=fan_width/2-1, h=0.1, center=true);
    }
    module front_plate() {
        translate([-radiator_diameter/2,-radiator_diameter/2,1])
            cube([radiator_diameter, radiator_diameter/2, radiator_height-2]);
    }
    module ideal_duct() {
        hull() {
            front_plate();
            back_plate();
        }
    }
    intersection() {
        ideal_duct();
        rotate([90,0,90])
        linear_extrude(h=200,center=true)
            polygon([
                [100,0],
                [100,radiator_height-1],
                [-radiator_diameter/2+1,radiator_height-1],
                [-100,100],
                [-100,0]]);

    }
}

module air_duct_wall_mold() {
    minkowski() {
        air_duct_mold();
        //cube([4,4,4],true);
        sphere(r=2);
    }
}

module final_part() {
    union() {
        difference() {
            fan_duct_trunk();
            air_duct_mold();
        }
        fan_screws_walls_mold();
//        difference() {
//            mounting_plates();  
//            radiator_trunk();
//            air_duct_mold();
//        }
    }
}

color("lightblue")final_part();
//            color("lightblue") mounting_plates();  

module side_fan_mount_position() {
    translate([29,0,1])
        rotate([0,60,0])
            //translate([0,fan_duct_height/2,0])
                children();
}

module side_fan_mount_duct_part_mold() {
    side_fan_mount_position()
        translate([0,0,-50+fan_plate_thickness])
            cube([100,100,100],true);
}

module side_air_duct_mold() {
    module back_plate() {
        side_fan_mount_position() translate([0,0,1]) cylinder(r=fan_width/2-1, h=0.1, center=true);
    }
    module front_plate() {
        translate([14,0,-15.5])
            cube([0.1,fan_width-10, 3],true);
    }
    module ideal_duct() {
        hull() {
            front_plate();
            back_plate();
        }
    }
    difference() {
        ideal_duct();
        rotate([90,0,0])
        linear_extrude(h=200,center=true)
            polygon([
                [21,30],
                [19,-1],
                [12, -20],
                [-100,0]]);

    }
}

module side_air_duct_wall_mold() {
    minkowski() {
        side_air_duct_mold();
        //cube([4,4,4],true);
        sphere(r=1.5);
    }
}

module side_fan_duct_trunk() {
    difference() {
        union() {
            intersection() {
                side_air_duct_wall_mold();   
                side_fan_mount_duct_part_mold();
                translate([64,0,32]) cube([100,100,100],true);
            }
            side_fan_mount_position() fan_mount();
        }
        side_fan_mount_position() fan_screws_mold();
    }
}
module side_fan_screws_walls_mold() {
    intersection() {
        side_fan_duct_trunk();
        side_fan_mount_position() minkowski() {
            fan_screws_mold();
            cube([1,1,fan_plate_thickness*2],true);
        }
    }
}

module side_joint() {
    difference() {
        intersection() {
            translate([0,-9,0])
                rotate([90,0,0])
                    linear_extrude(height=5,center=true)
                        polygon([
                            [30,20],
                            [30,0],
                            [10, 0],
                            [10,20]]);
            side_fan_mount_duct_part_mold();
        }
        side_air_duct_mold();
        radiator_trunk();
        air_duct_mold();
    }
   
}

module side_final_part() {
    union() {
        difference() {
            side_fan_duct_trunk();
            side_air_duct_mold();
        }
        side_fan_screws_walls_mold();
        side_joint();
    }
}
side_final_part();
mirror([1,0,0]) side_final_part();



//side_fan_duct_trunk();
//side_fan_mount_position() fan_mount();
//color("green")side_air_duct_wall_mold();
//side_air_duct_wall_mold();
//color("red")cube([30,1,1]);
//translate([0,0,-20])color("red") cube([100,40,2], true);
module side_mounting_plates() {
    width = 9;
    height = 22;
    thickness = 5;
    hole_x_distance = width / 2 - 4;
    hole_y1_distance = 6;
    hole_y2_distance = hole_y1_distance + 10;
    hole_radius = 1.5;
    translate([18.5,0,0])
    difference() {
        minkowski() {
            translate([0, 0, height / 2]) cube([width - 2, thickness - 1, height - 2], center=true);
            rotate([90,0,0]) cylinder(r=1, h=1, center=true);
        }
        translate([-hole_x_distance,0,hole_y1_distance])
            rotate([90,0,0]) cylinder(r=hole_radius, h=thickness*100, center=true);
        translate([-hole_x_distance,0,hole_y2_distance])
            rotate([90,0,0]) cylinder(r=hole_radius, h=thickness*100, center=true);
        //radiator_trunk();
    };
}
//side_mounting_plates();
