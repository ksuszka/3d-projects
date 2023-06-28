from cadquery import cq, Workplane, Sketch, Vector, Location
from math import sqrt

def wheels_for_608():
    bearing = (
        cq.Workplane()
        .cylinder(7,22/2)
        .cylinder(15,12/2)
        .cut(cq.Workplane().cylinder(0.2,7).translate((0,0,3.5+0.1)))
        )
    r = (
        cq.Workplane()
        .cylinder(11,28/2)
        .chamfer(1.5)
        .cut(bearing)
        )
    return r

def wheel_spacer():
    r = (
        cq.Workplane()
        .circle(11.7/2)
        .extrude(4)
        .faces("<Z")
        .workplane()
        .hole(7.9)
        )
    return r

def wheel_spacer2():
    s1 = Sketch().circle(11.7/2)
    s2 = Sketch().rect(16,10).vertices().fillet(1)
    r = (
        cq.Workplane()
        .placeSketch(s1)
        .extrude(4)
        .faces(">Z")
        .placeSketch(s1,s2.moved(Location(Vector(0,0,6))))
        .loft()
        .faces(">Z")
        .placeSketch(s2)
        .extrude(10)
        .faces("<Z")
        .workplane()
        .hole(8.1)
        )
    return r

def wheel_spacer3():
    s1 = Sketch().circle(14/2)
    s2 = Sketch().rect(16,10).vertices().fillet(1)
    r = (
        cq.Workplane()
        .placeSketch(s1)
        .extrude(9)
        .faces(">Z")
        .placeSketch(s1,s2.moved(Location(Vector(0,0,6))))
        .loft()
        .faces(">Z")
        .placeSketch(s2)
        .extrude(5)
        .faces("<Z")
        .workplane()
        .hole(8.1)
        )
    return r

def wheel_spacer4():
    r = (
        cq.Workplane()
        .circle(14/2)
        .extrude(28)
        .faces("<Z")
        .workplane()
        .hole(8.1)
        )
    return r

def wheel_spacer5():
    s1 = Sketch().circle(14/2)
    s2 = Sketch().circle(18/2)
    s3 = Sketch().circle(10/2)
    r = (
        cq.Workplane()
        .placeSketch(s1)
        .extrude(0.6)
        .faces(">Z")
        .placeSketch(s1,s2.moved(Location(Vector(0,0,2))))
        .loft()
        .faces(">Z")
        .placeSketch(s2)
        .extrude(2)
        .faces(">Z")
        .placeSketch(s2,s3.moved(Location(Vector(0,0,4))))
        .loft()
        .faces(">Z")
        .placeSketch(s3)
        .extrude(3)
        .faces("<Z")
        .workplane()
        .hole(8.1)
        )
    r= r.mirror(mirrorPlane="XY", basePointVector=(0, 0, 23/2)).union(r)
    return r

def mounting_block_8mm_rod():
    length=100;
    r = (
        cq.Workplane()
        .center(0,3).box(30,6,length)
        .center(0,2).cylinder(length,4+3).combine()
        .faces(">Z").workplane()
        .center(0,0).hole(7.9)
        .faces("-Y")
        .workplane()
        .split(keepBottom=True)
        )
    return r
#    return cskHole()
#show_object(bracket())
#show_object(wheels_for_608())
show_object(wheel_spacer5())
#show_object(mounting_block_8mm_rod())
