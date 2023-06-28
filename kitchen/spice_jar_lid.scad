

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


module cap_49mm_base() {
  inner_d=49.5;
  outer_d=55;
  bottom_h=11;
  height=15;
  difference() {
    union () {
      hull() {
        cylinder(d=outer_d,h=height-2,$fn=120);
        cylinder(d=outer_d-3,h=height,$fn=120);
      }
    }
    hull() {
      move_z(-.01)cylinder(d=inner_d-2,h=height-1-1.3,$fn=120);
      move_z(-.01)cylinder(d=inner_d,h=height-1-1.3-0.6,$fn=120);
    }
    move_z(-.01)cylinder(d=47.5,h=height-1,$fn=120);
    
    //thread
    pitch=3.5;
    outer_thread_d=52.5;
    for(b=[0:90:359])rotate([0,0,b])move_z(-2) {
      for(a=[0:90:189])rotate([0,0,a])move_z(a*pitch/90) {
        hull()for(a=[0:2:90])rotate([0,0,a])move_z(a*pitch/90) hull() {
          cube2([outer_thread_d,1,1.3],CCC);
          cube2([outer_thread_d-6,1,1.3+4],CCC);
        }
      }
    }
    
    // holes
    for(c=[0,180])rotate([0,0,c]) {
      for(b=[0:2:60])rotate([0,0,b])hull() {
        for(a=[0,2]) rotate([0,0,a]){
          translate([(43-3)/2,0])cylinder(d=3,h=20,$fn=24);
          translate([(43-3)/2-7,0])cylinder(d=3,h=20,$fn=24);
        }
      }
    }
    
  }
}

module cap_49mm_base_hollow() {
  inner_d=49.5;
  outer_d=55;
  bottom_h=11;
  height=15;
  difference() {
    union () {
      hull() {
        cylinder(d=outer_d,h=height-2,$fn=120);
        cylinder(d=outer_d-3,h=height,$fn=120);
      }
    }
    hull() {
      move_z(-.01)cylinder(d=inner_d-2,h=height-1-1.3,$fn=120);
      move_z(-.01)cylinder(d=inner_d,h=height-1-1.3-0.6,$fn=120);
    }
    move_z(-.01)cylinder(d=47.5,h=height-1,$fn=120);
    move_z(-.01)cylinder(d=52.5,h=height-5,$fn=120);
    

    // holes
    for(c=[0,180])rotate([0,0,c+10]) {
      for(b=[0:2:60])rotate([0,0,b])hull() {
        for(a=[0,2]) rotate([0,0,a]){
          translate([(43-3)/2,0])cylinder(d=3,h=20,$fn=24);
          translate([(43-3)/2-7,0])cylinder(d=3,h=20,$fn=24);
        }
      }
    }
    
  }
    //thread
    pitch=3.5;
    outer_thread_d=52.5;
    for(b=[0:90:359])rotate([0,0,b])move_z(2) {
      {
        for(a=[0:2:60])
          hull()for(c=[0,2])rotate([0,0,a+c])move_z((a+c)*pitch/90) {
          move_x(53/2)cube2([2,1,1],RCC);
          move_x(53/2)cube2([0.5,2,2],RCC);
          //cube2([outer_thread_d-6,1,1.3+4],CCC);
        }
      }
    }
      
}


module sieve_insert(length=22, holes_pattern="slits") {
  wall=0.6;
  ds=[43,40.5,40.5,41];
  hs=[0,10,length-1,length];
  module long_slits() {
    union() {
      for(a=[-2:2])translate([a*4,10])cube2([2,20,5],CLR);
      translate([0,-10])cube2([20,20,5],CRR);
    }
  }
  module long_slits() {
    for(a=[-2:2])translate([a*4,10])cube2([2,20,5],CLL);
    translate([0,-10])cube2([20,20,5],CRL);
  }
  module holes() {
    translate([0,18.8]) {
      for(a=[-1:1])translate([a*4,0])cylinder(d=2.5,h=5,$fn=12);
      for(a=[-2:1])translate([a*4+2,-4*sqrt(3)/2])cylinder(d=2.5,h=5,$fn=12);
      for(a=[-1:1])translate([a*4,2*-4*sqrt(3)/2])cylinder(d=2.5,h=5,$fn=12);
    }
    translate([0,-10])cube2([20,20,5],CRL);
  }
  difference() {
    union() {
      mirror([0,0,1])cylinder(d1=ds[0],d2=ds[0]+1.6,h=0.8,$fn=120);
      for(a=[0:len(ds)-2]) move_z(hs[a]) {
        cylinder(d1=ds[a],d2=ds[a+1],h=hs[a+1]-hs[a],$fn=120);
      }
      //move_z(15)cylinder(d=41,h=6,$fn=120);
      //move_z(21)cylinder(d1=41,d2=42,h=1,$fn=120);
    }
      for(a=[0:len(ds)-2]) move_z(hs[a]) {
        cylinder(d1=ds[a]-wall*2,d2=ds[a+1]-wall*2,h=hs[a+1]-hs[a]+.01,$fn=120);
      }
    intersection() {
      cylinder(d=41,h=20,center=true,$fn=120);
      move_z(0.01) mirror([0,0,1])
      if (holes_pattern == "slits") {
        long_slits();
      } else if (holes_pattern == "holes") {
        holes();
      }
    }
  }
}

color("green")intersection() {
  //strainer();
  //rotate([0,0,0])cap_49mm_base_hollow();
  //translate([0.01,0])cube2([0.1,150,150],LCC);
  //move_z(-1)cube2([120,120,12],CCL);
}
//sieve_insert(20.5, "slits");
sieve_insert(20.5, "holes");