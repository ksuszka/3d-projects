
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

/*
intersection() {
    translate([0,0,300-3]) rotate([0,90,0])cylinder(d=600,h=100,center=true,$fn=360);
    cube([100,40,6],true);
}
*/
module phone1() {
    
}

// hook
module top_hook() {
    module shaft() {
        intersection() {
            cube2([10,6,70],TTF);
            translate([0,5])rotate([0,0,180+45])cube2([100,100,200],FFT);
        }
    }
    difference() {
        union() {
            difference() {
                intersection() {
                    cube2([60,22,10],TFF);
                    translate([0,11,21]) rotate([0,90,0]) cylinder(d=40,h=100,center=true,$fn=72);
                }
            translate([0,13,12+5]) rotate([0,90,0])cylinder(d=20,h=100,center=true,$fn=72);
            translate([0,13,3+5]) rotate([0,90,0])cylinder(d=5,h=100,center=true,$fn=36);
            }

            translate([0,3,9]) shaft();
        }
        translate([0,8,7]) rotate([90,0,0]) cylinder(d=2.5,h=20,$fn=36);

    }
}

module bottom_hook() {
    module shaft() {
        intersection() {
            cube2([10.2,6.2,100],TTF);
            translate([0,5.1])rotate([0,0,180+45])cube2([100,100,200],FFT);
        }
    }
    difference() {
        union() {
            difference() {
                translate([0,-2,-5])cube2([60,24,15],TFF);
            translate([0,13,12+5]) rotate([0,90,0])cylinder(d=20,h=100,center=true,$fn=72);
            translate([0,13,3+5]) rotate([0,90,0])cylinder(d=5,h=100,center=true,$fn=36);
            }
            translate([0,-2])cube2([16,8,76],TFF);
        }
        translate([0,3,-1]) shaft();
        translate([0,10,5]) rotate([90,0,0]) cylinder(d=2.5,h=20,$fn=36);
    }
    
}
rotate([90-7,0,0]) 
intersection() {
    difference() {
        rotate([7,0,0]) {
            translate([0,0,86])mirror([0,0,1])top_hook();
    //        bottom_hook();
            //translate([0,13,7])color("red")cube2([100,5,72],TTF);
        }
        //screws
        for(a=[-1,1])translate([a*20,2]) {
            cylinder(d=3.2,h=30,center=true,$fn=24);
            translate([0,0,4])cylinder(d=6,h=30,$fn=24);
        }
    }
    cube2([1000,1000,1000],TTF);
}



module base() {
  r1 = (100*100+3*3)/(2*3);
  r2 = (100*100+10*10)/(2*10);
  echo(r1);
  echo(r2);

  h1=2;

  intersection() {
    union() {
      for (a=[0:0.0333:0.5]) {
        r3outer = r2+(r1-r2)*(1-a);
        r3inner = r2+(r1-r2)*a;
        difference() {
          union() {
            translate([0,r3outer+58*a])cylinder(r=r3outer,h=h1+1.5*sin(a*180),$fn=360);
          }
          translate([0,r3inner+58*(1-a)])cylinder(r=r3inner,h=20,$fn=360,center=true);
        }
      }
    }
    cube([160,200,200],true);
  }
}








