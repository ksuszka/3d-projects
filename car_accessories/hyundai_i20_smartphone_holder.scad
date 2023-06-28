
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



module rcube(xyz, r) {
  hull()
  for(x=[r, xyz[0]-r])
    for(y=[r, xyz[1]-r])
      for(z=[r, xyz[2]-r])
        translate([x,y,z]) sphere(r=r,$fn=24);
}
module phone(width=79,depth=12,height=100) {
  r=3;
  translate([-width/2,0,0])rcube([width,depth,height],r);
}

module holder_vertical() {
  x1=12;
  difference() {
    minkowski() {
      move_z(-0.5)phone(79+x1,12,60);
      sphere(r=1.5,$fn=12);
    }
    // flat top
    move_z(58)cube2([100,30,100],CCL);
    // flat bottom
    move_z(-1.5)cube2([100,30,100],CCR);
    
    // main phone cavity
    phone(80,12,100);
    hull() {
      phone(79+x1,12,40);
      phone(79,12,50);
    }
    
    // spring brackets
    translate([0,6,10])cube2([80+3,10.2,100],CCL);
    translate([0,6,56])cube2([80+3+3+2,10.2,20],CCL);
    copy_x() {
      translate([80/2+3,12/2,46])cube2([1.6,10.2,20],LCL);
    }
    // front opening
    hull() {
      translate([0,0.1,5])cube2([70,10,100],CRL);
      translate([0,-2,2])cube2([76,1,100],CRL);
    }
    
    // chargin port
    translate([0,6,-5])hull()copy_x()copy_y()translate([10,3])cylinder(d=2,h=10,$fn=12);
    for(a=[-1,1])translate([a*25,6,-5])hull()copy_x()copy_y()translate([10,2])cylinder(d=2,h=10,$fn=12);
    
  }
}

module holder_combo() {
  x1=12 ;
  difference() {
    union() {
      //vertical
      minkowski() {
        move_z(-1)phone(79+x1,12,60);
        sphere(r=1.5,$fn=12);
      }
      //horizontal
      translate([0,0,30]) minkowski() {
        move_z(-1)phone(165,12,60);
        sphere(r=1.5,$fn=12);
      }

    }
    // flat top
    move_z(58)cube2([200,30,100],CCL);
    // flat bottom
    move_z(-1.5)cube2([100,30,100],CCR);
    
    // main phone cavity
    phone(80,12,100);
    hull() {
      phone(79+x1,12,15);
      phone(79,12,25);
    }
    hull() {
      move_z(29)phone(79+x1,12,10);
      move_z(20)phone(79,12,10);
    }
    translate([0,0,30]) phone(165,12,100);

    
    // spring brackets
    translate([0,6,10])cube2([80+3,10.2,100],CCL);
    translate([0,6,28])cube2([80+3+3+3,10.2,20],CCL);
    copy_x() {
      translate([80/2+4,12/2,18])cube2([1.6,10.2,20],LCL);
    }
    // front opening vertical
    hull() {
      translate([0,0.1,5])cube2([70,10,100],CRL);
      translate([0,-2,2])cube2([76,1,100],CRL);
    }
    // front opening horizontal
    hull() {
      translate([0,0.1,5+30])cube2([154,10,100],CRL);
      translate([0,-2,2+30])cube2([154+6,1,100],CRL);
    }
    
    // chargin port
    translate([0,6,-5])hull()copy_x()copy_y()translate([10,3])cylinder(d=2,h=10,$fn=12);
    for(a=[-1,1])translate([a*25,6,-5])hull()copy_x()copy_y()translate([10,2])cylinder(d=2,h=10,$fn=12);
    
  }
  translate([0,12,80])rotate([-90,0]) hull() {
    cylinder(d=40,h=1.5);
    translate([0,50])cube2([60,1,1.5],CCL);
  }
}
module holder_combo_xiaomi_redmi_note_11() {
  x1=12;
  back_thickness=3;
  thickness=10;
  phone_w=77;
  phone_l=163;
  v2h_x=20;
  difference() {
    union() {
      //vertical
      minkowski() {
        move_z(-1)phone(phone_w,thickness+back_thickness-1.5,60);
        sphere(r=1.5,$fn=24);
      }
      //horizontal
      translate([v2h_x,0,30]) minkowski() {
        move_z(-1)phone(phone_l,thickness+back_thickness-1.5,60);
        sphere(r=1.5,$fn=24);
      }
      
      // screw base
      translate([-(phone_w-2)/2,9,-20])rcube([phone_w-2,4,30],2);
      copy_x()translate([11,0,-20])rcube([13,13,30],2);
    }
    // flat top
    move_z(58)cube2([300,30,100],CCL);
    // flat bottom
    //move_z(-1.5)cube2([100,30,100],CCR);
    
    // main phone cavity
    phone(phone_w,thickness,100);
    translate([v2h_x,0,30]) phone(phone_l,thickness,100);

    
    // front opening vertical
    hull() {
      translate([0,0.1,3])cube2([phone_w-6,10,100],CRL);
      translate([0,-2,0])cube2([phone_w,1,100],CRL);
    }
    // front opening horizontal
    hull() {
      translate([v2h_x,0.1,30+3])cube2([phone_l-6,10,100],CRL);
      translate([v2h_x,-2,30])cube2([phone_l,1,100],CRL);
    }
    
    // chargin port
    translate([0,thickness/2,-20])hull()copy_x()copy_y()translate([10,6])cylinder(d=2,h=30,$fn=12);
    for(a=[-1,1])translate([a*29,thickness/2-2,-20])hull()copy_x()copy_y()translate([4,5])cylinder(d=2,h=30,$fn=12);
    
    // screws
    depth=9             ;
    copy_x() translate([35/2,14,-4]) rotate([100,0,0]) {
      cube2([7.5,7.5,depth],CCL);
      cylinder(d=3.4,h=100,$fn=24);
      translate([0,0,depth+1])cylinder(d1=3.4,d2=6.4,h=1.51,$fn=24);
      translate([0,0,depth+2.5])cylinder(d=6.4,h=10,$fn=24);
    }    
  }
  
  translate([0,thickness,80])rotate([-90,0]) hull() {
    cylinder(d=40,h=back_thickness);
    translate([0,50])cube2([60,1,back_thickness],CCL);
  }
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
module spring_vertical() {
  h=10;
  linear_extrude(height=h,center=true){
    path([[-3,10],[-3,0],[0,0],[0,8],
      [1,15],
      [1,15],
      [2,20],
      [3,30],
      [3,45],
      [2,55],
      [1,55],
      [-2,45],
      [-3,40],
      [-4,30],
      [-4,25]
    ]);
  }
}
module spring_combo() {
  h=10;
  linear_extrude(height=h,center=true){
    path([[-3,10],[-3,0],[-1,0],
      [0,0.5],
      [0.5,1],
      [1,1.5],
      [1.5,2.5],
      [2,4],
      [3,8],
      [4,13],
      [5,20],
      [6,27],
      [2,27],
      [0,26],
      [-1,25],
      [-2,24],
      [-3,22],
      [-4,19],
      [-4,17],
      [-3,14],
      [-2,12],
    ]);
  }
}

//phone();
intersection() {
  holder_combo_xiaomi_redmi_note_11();
  //translate([0,6])cube2([200,2,200],CLC);
}
//color("red")move_y(10)cube2([76,1,100],CCL);
//color("green")move_y(12)cube2([79,1,100],CCL);
//color("lightgreen")translate([-41.75,6,29])rotate([-90,0])spring_combo();