module caso_adapter_stand() {
  // Stojak na końcówke adaptera do pojemników Caso Germany
  module profile() {
    square([20,1]);
    hull() {
      square([25/2,1+2]);
      square([24.8/2,1+5]);
      square([10.5,1+5.5]);
    }
    hull() {
      square([10.5,1+5.5]);
      square([10,1+11]);
      square([8,1+11+2]);
    }
    hull() {
    translate([36/2+1,1])circle(d=2,$fn=24);
    translate([36/2+1,10])circle(d=2,$fn=24);
    }
    hull() {
    translate([36/2+1,10])circle(d=2,$fn=24);
    translate([38/2+1,15])circle(d=2,$fn=24);
    }
  }
  rotate_extrude($fn=120)profile();
}
caso_adapter_stand();