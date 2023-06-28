from cadquery import cq
from math import sqrt

def wrench():
    r = (
        cq.Workplane()
        .polygon(6,40*2/sqrt(3))
        .extrude(5)
        .faces(">Z")
        .polygon(6,36,forConstruction=True)
        .vertices()
        .circle(7/2)
        .extrude(4)
        .faces("<Z")
        .circle(10)
        .cutThruAll()
    )
    return r

def m8_filament_spool_barrel(front=False):
    outline = (
        cq.Workplane()
        .circle(56/2)
        .extrude(3)
        .faces(">Z")
        .workplane()
        .circle(52.2/2)
        .workplane(offset=1)
        .circle(52/2)
        .loft()
        .faces(">Z")
        .workplane()
        .circle(52/2)
        .extrude(20)
        )
    outline_with_center_hole = (
        outline
        .faces("<Z")
        .workplane()
        .polygon(6,13*2/sqrt(3))
        .cutBlind(-8)
        .faces("<Z")
        .workplane(offset=-8.2)
        .hole(8)
    )
    
    if front:
        with_mounting_holes = (
            outline_with_center_hole
            .faces("<Z")
            .workplane()
            .polygon(6,36)
            .vertices()
            .hole(8,5)
            .faces("<Z")
            .workplane(offset=-5)
            .polygon(6,36)
            .vertices()
            .cskHole(4,8,82)
            )
    else:
        with_mounting_holes = (
            outline_with_center_hole
            .faces("<Z")
            .polygon(6,36,forConstruction=True)
            .vertices()
            .polygon(6,7*2/sqrt(3))
            .cutBlind(-8)
            .faces("<Z")
            .workplane(offset=-8.2)
            .polygon(6,36)
            .vertices()
            .hole(4)
            )
    return with_mounting_holes
#    return cskHole()
#show_object(bracket())
show_object(m8_filament_spool_barrel(True))
show_object(wrench().translate((0,0,-10)))

