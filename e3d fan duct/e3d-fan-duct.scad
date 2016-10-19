$fa=12;
$fs=0.2;

radiator_height = 26;
radiator_diameter = 22;
radiator_radius = radiator_diameter / 2;
thin_wall_radius = 1;
radiator_cut_angle = 60;

//%translate([-22, -19.6, 25.9])
//    rotate([-90, 0, 0])
//        import("Part1 - E3D_DoubleDuct2.stl");
//color("green") cylinder(r = radiator_diameter/2, h = radiator_height);
//%translate([0,0,40]) import("Effector_E3d.stl");


// fan mount part
fan_width = 40;
fan_wall_thickness = 0.5;
fan_wall_spacing = 1;
fan_mount_corner_radius = 3;
fan_mount_distance_to_center = 27;
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

module center_column() {
    linear_extrude(height=26) {
        holding_arms_half_2D();
        mirror([1,0,0]) holding_arms_half_2D();
    }
}

module fan_duct_zy_mold() {
    rotate([90,0,90])
        linear_extrude(h=200,center=true)
            polygon([
                [-100,0],
                [100,0],
                [100,26],
                [0,26],
                [-fan_mount_distance_to_center,fan_duct_height],
                [-100,fan_duct_height]]);
}

module fan_duct_trunk() {
    difference() {
        union() {
            intersection() {
                union() {
                    air_duct_wall_mold();   
                    center_column();
                }
                //linear_extrude(height=50) trunk_2D();
                fan_mount_position() fan_mount_outer_hull_mold();
                fan_duct_zy_mold();
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

module fan_mount_position() {
    translate([0,-fan_mount_distance_to_center,21.5]) rotate([90,0,0]) children();
}


module air_duct_mold() {
    front_bottom_spacing = 0.6;
    front_diameter = radiator_diameter;
    back_diameter = fan_width - 2;
    back_distance = fan_mount_distance_to_center + fan_plate_thickness+1;
    module cone() {
        scale = back_diameter/front_diameter;
        front_center_offset = front_diameter/2 + front_bottom_spacing;
        back_center_offset = fan_width/2 + fan_wall_thickness + fan_wall_spacing;
        offset_z_before = (back_center_offset - front_center_offset) /(scale-1);
        offset_z_after = (front_center_offset*scale - back_center_offset)/(scale-1);
        
        translate([0,0,offset_z_after])
            rotate([90,0,0])
                linear_extrude(height=back_distance, scale=scale) {
                    translate([0,offset_z_before])
                        circle(d=front_diameter);
                }
    }
    module zy_mold() {
        back_height = back_diameter + 1 + fan_wall_thickness + fan_wall_spacing;
    rotate([90,0,90])
        linear_extrude(h=200,center=true)
            polygon([
                [0,0],
                [0,radiator_height-9],
                [-back_distance,back_height],
                [-100,back_height],
                [-100,0]]);
    }
    intersection() {
        cone();
        zy_mold();
    }
}

module air_duct_wall_mold() {
    intersection() {
        minkowski() {
            air_duct_mold();
            cube([3,1,3],true);
        }
        translate([-50,0,-50])
        mirror([0,1,0])
        cube([100,fan_mount_distance_to_center + fan_plate_thickness,100]);
    }
}

module final_part() {
    union() {
        difference() {
            fan_duct_trunk();
            air_duct_mold();
        }
        fan_screws_walls_mold();
        difference() {
            mounting_plates();  
            radiator_trunk();
            air_duct_mold();
        }
    }
}

final_part();