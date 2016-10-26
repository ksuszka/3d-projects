// render with wall 1.5
beam_size = 15;
beam_size_half = beam_size/2;

$fn=50;
// dependency: https://cdn.thingiverse.com/assets/95/99/30/ae/e4/TL-400-0101-001CLR_-_OpenBeam_1515_Extrusion_Clear_Anodized.STL
//color("green") translate([-beam_size_half,-beam_size,-1000]) import("TL-400-0101-001CLR_-_OpenBeam_1515_Extrusion_Clear_Anodized.stl");

opening = 0.4;

module negative() {
    module half() {
        offset(r=+0.5) offset(delta=-0.5) polygon([[10,0],[1.6,0],[1.6,1.4],[10,1.4]]);
        polygon([[2,1],[10,20],[10,1]]);
        polygon([[0,0],[opening,0],[0.6,1.7],[8.6,20.7],[0,20]]);
        offset(r=-0.5) offset(delta=0.5) polygon([[2.9,0],[2.9,4],[0,4.9],[0,20],[10,20],[10,0]]);
    }
    
    linear_extrude(height=1000, center=true) {
        half();
        mirror() half();
        polygon([[-opening,0],[opening,0],[0.7,-2],[0,-2]]);
    }
}

module clip(clip_width = 20) {
    module positive() {
        linear_extrude(height=clip_width, center=true) {
            polygon([[-beam_size_half,-2],[-beam_size_half,10],[beam_size_half,10],[beam_size_half,-2]]);
            
            translate([-1.5,-20]) square([1.5,20]);
            translate([0,-20]) rotate([0,0,-7]) translate([-1.5,0]) square([1.5,20]);
        }
    }
    difference() {
        positive();
        negative();
    }
}

module clips(count=6, clip_width=20) {
    for(a=[0:1:count-1]) {
        x = a * 7 + 1*(a%2);
        y = -a*3 + 30*(a%2);
        translate([x,y,0]) rotate([0,0,180+180 * (a % 2)]) clip();
    }
}

clips(1);
