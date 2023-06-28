

FFF=[false,false,false];FFT=[false,false,true];
FTF=[false,true,false];FTT=[false,true,true];
TFF=[true,false,false];TFT=[true,false,true];
TTF=[true,true,false];TTT=[true,true,true];
module cube2(size, center) {
  translate([
    center[0] ? -size[0]/2 : 0,
    center[1] ? -size[1]/2 : 0,
    center[2] ? -size[2]/2 : 0]) cube(size);
}
module with_mirror_x() {
  for(a=[0,1])mirror([a,0])children();
}
module with_mirror_y() {
  for(a=[0,1])mirror([0,a])children();
}

module remote_jowisza_v1() {
  {
    hull() {
      with_mirror_x(){
        translate([15,3]) cylinder(d=6,h=15.2,$fn=24);
        translate([10,37]) cylinder(d=20,h=15.5,$fn=24);
        translate([15,64]) cylinder(d=8,h=13,$fn=24);
      }
      translate([0,54.5])cylinder(d=30,h=13,$fn=36);
      
    }
    translate([0,2,4])cylinder(d=12,h=6,$fn=24);
  }
}
module remote_jowisza_v2(hook=true) {
  dd=6;
  color("grey") {
    minkowski() {
      translate([0,0,dd/2])hull() {
        with_mirror_x(){
          translate([14,4]) cylinder(d=8-dd,h=15.2-dd,$fn=24);
          translate([0,30]) cylinder(d=20,h=15.5-dd,$fn=24);
          translate([10,37]) cylinder(d=20.2-dd,h=15.2-dd,$fn=24);
          translate([10,25]) cylinder(d=20.2-dd,h=15.2-dd,$fn=24);
          translate([15,64]) cylinder(d=8-dd,h=13-dd,$fn=24);
        }
        translate([0,54.5])cylinder(d=30-dd,h=13-dd,$fn=36);
        
      }
      sphere(d=dd,$fn=24);
    }
    if (hook) {
      translate([0,1,5])cylinder(d=14,h=6,$fn=24);
    }
  }
}
//%translate([0,2,2]) remote_v1();
//translate([0,2,2]) remote_v2();
module bracket_jowisza_v1() {
  difference() {
    union() {
      cube2([42,50,19],TFF);
      
      translate([0,25])with_mirror_y() {
        translate([0,20.5]) rotate([10,0])translate([0,0,-6])cube2([42,2,10],TFF);
      }
    }
    translate([0,2,2]) remote_jowisza_v1();
    translate([0,57,5])cylinder(d=42,h=20,$fn=36);
  }
}

module bracket_jowisza_v2() {
  difference() {
    union() {
      minkowski() {
        translate([0,2,2]) remote_jowisza_v2(false);
        sphere(d=2,$fn=36);
      }
      translate([0,4])for(xy=[[-8,7],[8,7],[8,17]])translate(xy)cube2([8,5,6],TTT);
    }
    translate([0,2,2]) remote_jowisza_v2();
    translate([0,57,0])rotate([45,0])cube2([100,100,100],TFT);
    //translate([0,57,5])cylinder(d=42,h=20,$fn=36);
  }
}
module remote_nice_v1() {
  translate([0,25,7.5]) hull(){
    for(a=[-0.5,0.5])translate([0,0,a])scale([1,1,14/48])sphere(d=48,$fn=60);
  }
}
module bracket_nice_v1() {
  difference() {
    union() {
      minkowski() {
        translate([0,2,2]) remote_nice_v1();
        sphere(d=2,$fn=36);
      }
      
      // backplate
      translate([0,26,1])intersection() {
        cylinder(d=42.5,h=5,$fn=60);
        cube2([30,38,10],TTT);
      }
      // joints
      translate([0,4,1])for(xy=[[-8,7],[8,7],[8,17]])translate(xy)cube2([8,5,8],TTT);
   
    }
    translate([0,2,2]) remote_nice_v1();
    //translate([0,57,0])rotate([45,0])cube2([100,100,100],TFT);
    translate([0,34,7])cube2([100,100,100],TFF);
    translate([0,10,7])rotate([0,0,45])cube2([50,50,50],FFF);
   
    translate([0,27,7])cylinder(d=40,h=20,$fn=60);
    //cube2([100,100,100],TFT);
    //translate([0,57,5])cylinder(d=42,h=20,$fn=36);
  }
}
module bracket_nice_v2() {
  dy=4;
  difference() {
    union() {
      translate([0,dy,2]) intersection() {
        minkowski() {
          remote_nice_v1();
          sphere(d=2,$fn=36);
        }
        translate([0,25,-50+16.9]) sphere(r=50,$fn=60);
        translate([0,25,-100+14.4]) sphere(r=100,$fn=60);
      }
      
      // backplate
      translate([0,29,1])hull() {
        for(x=[-11,11])for(y=[-22,22])translate([x,y])
          cylinder(r=5,h=4,$fn=60);
      }
   
    }
    // joints
    translate([0,4,1])for(xy=[[-8,5],[8,5],[8,15]])translate(xy)cube2([8,5,2],TTT);


    translate([0,dy,2]) remote_nice_v1();
    translate([0,dy+32,7])cube2([100,100,100],TFF);
    translate([0,dy+8,7])rotate([0,0,45])cube2([50,50,50],FFF);
   
    translate([0,dy+25,7])cylinder(d=40,h=20,$fn=60);
  }
}

module hook() {
  h=4;
  width=30;
  length=51;
  spring_id=12;
  spring_width=4;
  top_offset=spring_id+1;
  spring_od=spring_id+spring_width*2;
  hole1_y=length-top_offset;
  hole1_x=width/2-spring_od/2;
  hole2_y=length-top_offset-spring_id-spring_width;
  hole2_x=-width/2+spring_od/2;
  translate([0,4,-3]) difference() {
    union() {
      cube2([width,hole2_y,h],TFF);
      cube2([width/2,hole2_y+4,h],FFF);
      translate([0,hole1_y])cube2([width,top_offset,h],TFF);
      translate([-width/2,hole1_y-4])cube2([width/2,5,h],FFF);
      translate([hole1_x,hole1_y]) cylinder(d=spring_od,h=h,$fn=36);
      translate([hole2_x,hole2_y]) cylinder(d=spring_od,h=h,$fn=36);
      translate([0,(hole1_y+hole2_y)/2])cube2([10,7,h],TTF);
    }
    translate([hole1_x,hole1_y]) cylinder(d=spring_id,h=h*3,$fn=36,center=true);
    translate([hole2_x,hole2_y]) cylinder(d=spring_id,h=h*3,$fn=36,center=true);
    translate([hole2_x,hole2_y+spring_id/2-4])cube2([width,4,h*3],FFT);
    translate([-width,hole1_y-spring_id/2])cube2([width+hole1_x,4,h*3],FFT);
    for(a=[0,length])translate([0,a,h/2])rotate([0,90])cylinder(d=3,h=100,center=true,$fn=24);
    for(xy=[[-8,7],[8,7],[8,17]])translate(xy)cube2([8,5,20],TTT);
  }
}

module hook_v2() {
  h=4;
  width=30;
  length=51;
  spring_id=12;
  spring_width=4;
  top_offset=spring_id+1;
  spring_od=spring_id+spring_width*2;
  hole1_y=length-top_offset;
  hole1_x=width/2-spring_od/2;
  hole2_y=length-top_offset-spring_id-spring_width;
  hole2_x=-width/2+spring_od/2;
  translate([0,4,-3]) difference() {
    union() {
      cube2([width,hole2_y,h],TFF);
      cube2([width/2,hole2_y+4,h],FFF);
      translate([0,hole1_y])cube2([width,top_offset,h],TFF);
      translate([-width/2,hole1_y-4])cube2([width/2,5,h],FFF);
      translate([hole1_x,hole1_y]) cylinder(d=spring_od,h=h,$fn=36);
      translate([hole2_x,hole2_y]) cylinder(d=spring_od,h=h,$fn=36);
      translate([0,(hole1_y+hole2_y)/2])cube2([10,7,h],TTF);

      //joints
      translate([0,0,h])for(xy=[[-8,5],[8,5],[8,15]])translate(xy)cube2([8,5,1.6],TTT);
    }
    translate([hole1_x,hole1_y]) cylinder(d=spring_id,h=h*3,$fn=36,center=true);
    translate([hole2_x,hole2_y]) cylinder(d=spring_id,h=h*3,$fn=36,center=true);
    translate([hole2_x,hole2_y+spring_id/2-4])cube2([width,4,h*3],FFT);
    translate([-width,hole1_y-spring_id/2])cube2([width+hole1_x,4,h*3],FFT);
    for(a=[0,length])translate([0,a,h/2])rotate([0,90])cylinder(d=3,h=100,center=true,$fn=24);
  }
}
//bracket_jowisza_v1();
//bracket_jowisza_v2();
//remote_nice_v1();
//hook();

//bracket_nice_v2();
hook_v2();