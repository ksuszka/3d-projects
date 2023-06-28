
LLL="LLL";LLC="LLC";LLR="LLR";LCL="LCL";LCC="LCC";LCR="LCR";LRL="LRL";LRC="LRC";LRR="LRR";
CLL="CLL";CLC="CLC";CLR="CLR";CCL="CCL";CCC="CCC";CCR="CCR";CRL="CRL";CRC="CRC";CRR="CRR";
RLL="RLL";RLC="RLC";RLR="RLR";RCL="RCL";RCC="RCC";RCR="RCR";RRL="RRL";RRC="RRC";RRR="RRR";
module cube2(size, center) {
  function align(i)=center[i]=="R"?-2:center[i]=="C"?-1:0;
  translate([align(0)*size[0]/2,align(1)*size[1]/2,align(2)*size[2]/2])cube(size);
}
module copy_x() { for(a=[0,1])mirror([a,0,0])children(); }
module copy_y() { for(a=[0,1])mirror([0,a,0])children(); }
module copy_z() { for(a=[0,1])mirror([0,0,a])children(); }
module move_x(d) { translate([d,0,0])children(); }
module move_y(d) { translate([0,d,0])children(); }
module move_z(d) { translate([0,0,d])children(); }


module cuber(size, radius, center) {
  function align(i)=center[i]=="R"?-1:center[i]=="C"?0:1;
  translate([align(0)*size[0]/2,align(1)*size[1]/2,align(2)*size[2]/2])
  hull()copy_x()copy_y()copy_z()translate([for (a=size) a*0.5-radius])sphere(r=radius,$fn=24);
}

module path(points) {
  for (i = [0:len(points)-2]) {
    xy1=points[i];
    xy2=points[i+1];
    hull() {
      translate(xy1)circle(d=1.5,$fn=12);
      translate(xy2)circle(d=1.5,$fn=12);
    }
  }
}
module hook() {
  module sketch(offset=0) {
    path([[-7,-3.5],
      [-4.5+offset,-3.5],
      [-4+offset,-3],
      [-4+offset,8],
      [-5.5,13],
      [-7.5,17],
      [-10,19],
      [-13,20],
      [-30,20],
      [-32,10],
      [-36,10],
      [-37,15],
      [-41,20],
      [-70,20],
    ]);
  }
  linear_extrude(10) sketch();
  for(a=[0:0.1:1.5])move_z(10+a*2)linear_extrude(0.2) sketch(a);
  move_z(10+1.5*2)linear_extrude(2) sketch(1.5);
  linear_extrude(15) {
    path([[-20,20],[-20,21]]);
    path([[-60,20],[-60,21]]);
  }
}
module hook2() {
  module sketch(offset=0) {
    path([[-7,-3.5],
      [-4.5+offset,-3.5],
      [-4+offset,-3],
      [-4+offset,8],
      [-5.5,13],
      [-7.5,17],
      [-10,19],
      [-13,20],
      [-31,20],
      [-31,3],
      [-37,3],
      [-37,15],
      [-41,20],
      [-70,20],
    ]);
  }
  difference() {
    union() {
      linear_extrude(10) sketch();
      for(a=[0:0.1:1.5])move_z(10+a*2)linear_extrude(0.2) sketch(a);
      move_z(10+1.5*2)linear_extrude(2) sketch(1.5);
      linear_extrude(15) {
        path([[-20,20],[-20,21]]);
        path([[-60,20],[-60,21]]);
      }
    }
    translate([-30,0,12])rotate([10,0])cube2([30,100,100],CCL);
  }
}

module phone(width=79,depth=12,height=100,r=3) {
  r2=8;
  r3=r2+r;
  minkowski() {
    hull()
    for(x=[-width/2+r3,width/2-r3])
      for(y=[depth/2])
        for(z=[r3,height-r3])
          translate([x,y,z]) rotate([90,0])cylinder(r=r2,$fn=24,center=true,h=depth-2*r);
    sphere(r=r,$fn=24);
  }
}

module phone2(width=79,depth=12,height=100,r=3) {
  hull()
  for(x=[-width/2+r,width/2-r])
    for(y=[r,depth-r])
      for(z=[r,height-r])
        translate([x,y,z]) sphere(r=r,$fn=24);
}

module holder() {
  x1=0 ;
  difference() {
    union() {
      difference() {
        //horizontal
        translate([0,-1.5,-1.5])
          phone(165+3,12+4.5,60+3,4.5);
        // flat top
        move_z(30)cube2([200,30,100],CCL);
      }
  
      //backplate
      rb=8;
      translate([0,12,79/2])rotate([-90,0]) hull() {
        copy_x()copy_y()translate([159/2-rb,70/2-rb])cylinder(r=rb,h=3);
      }

    }
    
    // main phone cavity
    phone(165,12,100);

    // front opening horizontal
    hull() {
      translate([0,2,79/2])cuber([165-14,10,79-14],8,CRC);
      translate([0,-10,79/2])cuber([165+10,10,79+10],8,CRC);
    }

    // bottom cutout
    cube2([80,24,50],CCC);
    
    // back grooves
    copy_x()for(a=[0,40])translate([129/2,13,12+a])cube2([15.5,10,1.6],RLC);
    
  }
}
//translate([40,40,72])rotate([0,-90,180])hook();
translate([40,40,72])rotate([0,-90,180])hook2();
//phone(165,12,100);
//move_y(20)phone2(165,12,100);

//holder();