
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
module mirror_x() {
  for(a=[0,1])mirror([a,0,0])children();
}
module mirror_y() {
  for(a=[0,1])mirror([0,a,0])children();
}
module mirror_z() {
  for(a=[0,1])mirror([0,0,a])children();
}

module pipes() {
  module h1() {
    difference() {
      cylinder(d=10.2,h=50,center=true,$fn=48);
      translate([2,0])cube2([20,20,60],FTT);
      translate([0,1])cube2([20,20,60],TFT);
    }
  }
  module h2() {
    hull() {
      h1();
      translate([1,-2.9])cylinder(d=4,h=50,center=true,$fn=24);
    }
  }
  mirror_y()h2();
    translate([(10.2-3+0.2)/2,0])cylinder(d=3.1,h=50,center=true,$fn=24);
}

module plug_small_bottle_v1() {
  difference() {
    union() {
      hull() {
        cylinder(d=28,h=1,$fn=72);
        translate([0,0,1])cylinder(d=29,h=1,$fn=72);
      }
      cylinder(d=25,h=18+2+3,$fn=72);
      for(a=[2:4:20])translate([0,0,a])hull(){
        translate([0,0,2])cylinder(d=27,h=1,$fn=72);
        cylinder(d=24,h=1,$fn=72);
      }
      translate([0,0,22])hull(){
        translate([0,0,2])cylinder(d=28,h=1,$fn=72);
        cylinder(d=25,h=1,$fn=72);
      }      
    }
    pipes();
    translate([0,0,18+1])cylinder(d1=12,d2=32,h=9,$fn=72);
  }
}
module plug_small_bottle_v2() {
  difference() {
    union() {
      hull() {
        cylinder(d=28,h=1,$fn=72);
        translate([0,0,1])cylinder(d=29,h=1,$fn=72);
      }
//      cylinder(d=25,h=28,$fn=72);
      cylinder(d=25,h=18,$fn=72);
      for(a=[3:5.5:16])translate([0,0,a])hull(){
        translate([0,0,2])cylinder(d=27,h=1,$fn=72);
        cylinder(d=24,h=5,$fn=72);
      }
//      translate([0,0,24])hull(){
//        translate([0,0,2])cylinder(d=27,h=1,$fn=72);
//        cylinder(d=24,h=5,$fn=72);
//      }      
    }
    pipes();
    translate([0,0,18+1])cylinder(d1=12,d2=32,h=16,$fn=72);
  }
}

module plug_big_bottle_v2() {
  difference() {
    union() {
      hull() {
        cylinder(d=28,h=1,$fn=72);
        translate([0,0,1])cylinder(d=29,h=1,$fn=72);
      }
//      cylinder(d=25,h=28,$fn=72);
      cylinder(d=25,h=18,$fn=72);
      for(a=[4:5.5:13])translate([0,0,a])hull(){
        translate([0,0,2])cylinder(d=27,h=1,$fn=72);
        cylinder(d=24,h=5,$fn=72);
      }
      translate([0,0,16])hull(){
        translate([0,0,1])cylinder(d=25.5,h=1,$fn=72);
        cylinder(d=24,h=3,$fn=72);
      }      
    }
    pipes();
    translate([0,0,18+1])cylinder(d1=12,d2=32,h=16,$fn=72);
  }
}

module plug_big_bottle() {
  difference() {
    union() {
      hull() {
        cylinder(d=28,h=1,$fn=72);
        translate([0,0,1])cylinder(d=29,h=1,$fn=72);
      }
      cylinder(d=25,h=18+2+3,$fn=72);
      for(a=[2:4:16])translate([0,0,a])hull(){
        translate([0,0,2])cylinder(d=26,h=1,$fn=72);
        cylinder(d=24,h=1,$fn=72);
      }
      translate([0,0,22])hull(){
        translate([0,0,2])cylinder(d=27,h=1,$fn=72);
        cylinder(d=24,h=1,$fn=72);
      }      
    }
    pipes();
    translate([0,0,18+1])cylinder(d1=12,d2=32,h=9,$fn=72);
  }
}

module pipes_test() {
difference() {
  union() {
    cylinder(d=14,h=1,$fn=48);
//    cylinder(d=29,h=1,$fn=48);
//    cylinder(d=25,h=3,$fn=48);
  }
  pipes();
}
}
//pipes_test();
//plug_small_bottle_v2();
plug_big_bottle_v2();
