// CEC 3HP 8-Ganged Card Guides (Bottom).
// Copyright (C) 2025 Darcy L. Watkins

include <cec-common.scad>

cecRailMountThickness = 3.5; // mm
cecRailMountHoleMinOffset = 5.0; // mm
cecCardGuideRailThickness = 2.0; // mm
cecCardGuideRailHeight = 2.5; // mm
cecCardGuideForkSetback = 5.0; // mm
cecCardGuideArmSpan = 40.0; // mm

// Origin is
//  X=0 - Component (left looking from rear) side of PCB
//  Y=0 - Rear side of the back plane rail.
//  Z=0 - Center of back plane rail mounting holes.

// Example from OpenSCAD User Manual
module prism(l, w, h)
{
   polyhedron(
   // pt      0        1        2        3        4        5
   points=[[0,0,0], [0,w,h], [l,w,h], [l,0,0], [0,w,0], [l,w,0]],
   // top sloping face (A)
   faces=[[0,1,2,3],
   // vertical rectangular face (B)
   [2,1,4,5],
   // bottom face (C)
   [0,3,5,4],
   // rear triangular face (D)
   [0,4,1],
   // front triangular face (E)
   [3,2,5]]
   );
}

module cecMounbtHole(xOffset=0)
{
    // CEC front panel plate has symetric holes.
    //   X --> At center of panel width
    //   Y --> Through the front plate (with
    //         the extension beyond outside and
    //         inside face of the panel plate.
    //   Z --> Symetrical at H9 spacing.
    // Note: Y and Z args are swapped because this
    //       is invoked in context of a 90deg rotate.
    translate([halfOf(cecWidth) - cecPCBOffset + xOffset,
        0, -cecHoleExt])

    // Hole for M2.5 (or M3) machine screws.
    cylinder(h=cecRailMountThickness + doubleOf(cecHoleExt),
        d=cecRailMountHoleDia);

    echo("Hole placement X,Y,Z=",
        [halfOf(cecWidth) - cecPCBOffset + xOffset,
        0, -cecHoleExt],
        cecRailMountHoleDia=cecRailMountHoleDia);
}

module cecRailMount(xOffset=0)
{
    // CEC card guide rail mount.
    // Placement is:
    //   X --> offset to have component side of PCB
    //         on the X=0, Y,Z plane.
    //   Y --> offset to have the inside face of the
    //         rail mount on the Y=0, X,Z plane.
    //   Z --> offset to have the Z=0, X,Y plane
    //         slice through the centers of the holes.
    railMountPlacement = [-cecPCBOffset + xOffset,
        -cecRailMountThickness,
        -cecRailMountHoleMinOffset];

    // Sized X,Y,Z based on:
    //  X --> Width: 3HP (exact).
    //  Y --> Rail mount thickness as specified.
    //  Z --> Span from rail mount holes center
    //        to board edge (minus clearance),
    //        plus the extension from the other
    //        side of the holes.
    railMountSize = [cecWidth,
        cecRailMountThickness,
        halfOf(cecH9prm - cecH10) +
        cecRailMountHoleMinOffset -
        halfOf(cecClearance)];

    holeOffsets = [-HPUnit + xOffset, xOffset,
        HPUnit + xOffset];

    difference()
    {
        translate(railMountPlacement)
        cube(railMountSize);
        for(offset = holeOffsets)
        rotate([90,0,0])
        cecMounbtHole(offset);
    }

    echo("Mount at X.Y,Z=", railMountPlacement, 
        " size X,Y,Z=", railMountSize);
}

module cecCardGuideArm(xOffset=0)
{
    // CEC card guide arm.
    // Placement is:
    //   X --> offset to have component side of PCB
    //         on the X=0, Y,Z plane.
    //   Y --> Zero to align inside face of the
    //         rail mount on the Y=0, X,Z plane.
    //   Z --> offset to clear the aperture of rail.
    armPlacement = [xOffset - cecPCBThickness -
        halfOf(cecClearance) - cecCardGuideRailThickness,
        0,
        halfOf(cecH6prm - cecH5prm)];

    // Sized X,Y,Z based on:
    //  X --> Width: 3HP (exact).
    //  Y --> Rail mount thickness as specified.
    //  Z --> Span from rail mount holes center
    //        to board edge (minus clearance),
    //        plus the extension from the other
    //        side of the holes.
    armSize = [cecPCBThickness +
        doubleOf(cecCardGuideRailThickness) +
        cecClearance,
        cecCardGuideArmSpan,
        halfOf(cecH9prm - cecH10) -
        halfOf(cecH6prm - cecH5prm) -
        halfOf(cecClearance)];


    translate(armPlacement)
    cube(armSize);

}

module cecCardGuideRail(xOffset=0)
{
    // CEC card guide arm.
    // Placement is:
    //   X --> offset to have component side of PCB
    //         on the X=0, Y,Z plane.
    //   Y --> Align with rear face of rail mount.
    //   Z --> Align with top face of rail mount.
    cardGuideRailPlacement = [xOffset - cecPCBThickness -
        halfOf(cecClearance) - cecCardGuideRailThickness,
        -cecRailMountThickness,
        halfOf(cecH9prm - cecH10) -
        halfOf(cecClearance)];

    // Sized X,Y,Z based on:
    //  X --> Width: 3HP (exact).
    //  Y --> Rail mount thickness as specified.
    //  Z --> Span from rail mount holes center
    //        to board edge (minus clearance),
    //        plus the extension from the other
    //        side of the holes.
    cardGuideRailSize = [cecCardGuideRailThickness,
        cecCardGuideArmSpan - cecCardGuideForkSetback +
        cecRailMountThickness,
        cecCardGuideRailHeight];

    translate(cardGuideRailPlacement)
    cube(cardGuideRailSize);
}

module cecCardGuideForks(xOffset)
{
    // Fork on solder side of PCB
    cardGuideFork1Placement = [xOffset - cecPCBThickness -
        halfOf(cecClearance) - cecCardGuideRailThickness,
        cecCardGuideArmSpan,
        halfOf(cecH9prm - cecH10) -
        halfOf(cecClearance)];

    translate(cardGuideFork1Placement)
    rotate([0, -90, 0])
    prism(cecCardGuideRailHeight, -cecCardGuideForkSetback,
        -cecCardGuideRailThickness);

    // Fork on component side of PCB
    cardGuideFork2Placement = [xOffset +
        cecCardGuideRailThickness +
        halfOf(cecClearance),
        cecCardGuideArmSpan,
        halfOf(cecH9prm - cecH10) -
        halfOf(cecClearance) + cecCardGuideRailHeight];

    translate(cardGuideFork2Placement)
    rotate([0, 90, 0])
    prism(cecCardGuideRailHeight, -cecCardGuideForkSetback,
        -cecCardGuideRailThickness);
}

module cecCardGuide(xOffset=0)
{
    union()
    {
        cecRailMount(xOffset);
        cecCardGuideArm(xOffset);
        cecCardGuideRail(xOffset);
        cecCardGuideRail(xOffset + cecPCBThickness +
            cecClearance + cecCardGuideRailThickness);
        cecCardGuideForks(xOffset);
    }
}
