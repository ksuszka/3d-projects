include <terrain.scad>

// default, small hills terrain
translate([0,0])
    terrain(40,20,seed=1);

// plains
translate([50,0])
    terrain(40,20,steps=[[1,0.1],[2,0.2],[10,2]],seed=2);

// hills
translate([0,30])
    terrain(40,20,steps=[[1,0.2],[5,4],[7,4]],seed=3);

// mountains
translate([50,30])
    terrain(40,20,steps=[[1,0.2],[5,4],[8,10],[9,5],[11,2]],seed=7);