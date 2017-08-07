$fa=3;
$fs=0.2;

module knitter(height=20, di=10, do=16, nail_dia=1.5, nail_depth=10) {
  difference() {
    cylinder(d=do, h=height);
    cylinder(d=di, h=height*3, center=true);
    for(i=[1:4]) {
      rotate([0,0,90*i])
        translate([(di+do)/4,0,height-nail_depth])
          cylinder(d=nail_dia, h=nail_depth*2);
    }
  }
}

//knitter(height=20, di=10, do=16, nail_dia=1.5, nail_depth=10);
knitter(height=40, di=12, do=20, nail_dia=1.5, nail_depth=15);