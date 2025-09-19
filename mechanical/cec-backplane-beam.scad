// CEC 3HP Backplane Beam / PCB Mount
// Copyright (C) 2025 Darcy L. Watkins

// Backplane beam spans the two backplane rails over
// top of the card guide mounts.  It provides mount
// points with holes to securely mount a CubuSynth
// backplane PCB with two sections of 8-ganged 3HP
// spaced EuroRack IDC power bus connectors.

include <include/cec-bb2-board.scad>
include <include/cec-3hp-cardguide-with-mount.scad>
include <include/cubu-synth-backplane.scad>

// Origin
//   X=0 - Component side of CEC PCB of the 3HP slot just
//         left of the backplane beam position (and the
//         backplane PCB mounting holes).  X increases
//         to the left (viewed from the front).
//   Y=0 - Component side of backplane PCB (which should
//         normally also be the same as the rear side of
//         the backplane rails.  Y increases towards the
//         front.
//   Z=0 - Mid verticle of the cage (and CEC card PCBs).

// Variances from spec due to hand punch and hand drill
// inaccuracies.
cecMeasuredH6prm = 118.0; // mm
cecMeasuredD1 = 87.8; // mm

// The rear rails are spaced a bit wider than per spec.
zVariance = cecMeasuredH6prm - cecH6prm;

// The rear rails are a bit further back than per spec.
// Note: The cecD1 includes tolerance.
yVariance = cecMeasuredD1 - cecD1;

echo(cecMeasuredH6prm=cecMeasuredH6prm, cecH6prm=cecH6prm);
echo(cecMeasuredD1=cecMeasuredD1, cecD1=cecD1);
echo(yVariance=yVariance, zVariance=zVariance);

PCBHolePadThickness = cecRailMountThickness + yVariance -
        csPCBThickness;

cecBeamThickness = 5.0; 
cecRidgeHeight = 5.0;

// The beam is mounted one HP over from the card guide
// alignment to keep the hole from breaching the edge.
module cecMainSpanMounts(thicknessExt=0)
{
    union()
    {
        mirror([1, 0, 0])
        cecRailMount(xOffset=HPUnit,
            yOffset=-cecRailMountThickness,
            zOffset=halfOf(-cecMeasuredH6prm),
            zExt=halfOf(cecH10)+cecClearance+
            halfOf(cecClearance),
            thickExt=thicknessExt);
        mirror([1, 0, 0])
        mirror([0, 0, 1])
        cecRailMount(xOffset=HPUnit,
            yOffset=-cecRailMountThickness,
            zOffset=halfOf(-cecMeasuredH6prm),
            zExt=halfOf(cecH10)+cecClearance+
            halfOf(cecClearance),
            thickExt=thicknessExt);
        translate([-cecRailMountThickness +
            cecPCBOffset - HPUnit,
            -doubleOf(cecRailMountThickness) -
            thicknessExt - cecRidgeHeight,
            -halfOf(cecH5prm)])
        cube([cecRailMountThickness,
            cecRidgeHeight,
            cecH5prm]);
    }
}

module cecBeamPCBMountPad(xOffset=0, yOffset=0, zOffset=0)
{

    padPlacement = [-cecIDCOffset - halfOf(cecIDCSpacing +
        cecWidth) + xOffset,
        zOffset + halfOf(cecH10) - bb2Row2ZCoord(8.5),
        cecRailMountThickness + yOffset - 
        PCBHolePadThickness];

    rotate([90,0,0])
    translate(padPlacement)
    cylinder(h=PCBHolePadThickness,
        d=csPCBHolePadDia);
}

module cecBeamPCBMountHole(xOffset=0, yOffset=0, zOffset=0,
    thicknessExt=0)
{
    // CEC front panel plate has symetric holes.
    //   X --> Calculated based on the geometry of the
    //         PCBs and IDC connectors.
    //   Y --> To go through the beam.
    //   Z --> Calculated based on geometry of the PCBs,
    //         the IDC connectors and cage.
    // Note: Y and Z args are swapped because this
    //       is invoked in context of a 90deg rotate.
    holePlacement = [-cecIDCOffset - halfOf(cecIDCSpacing +
        cecWidth) + xOffset,
        zOffset + halfOf(cecH10) - bb2Row2ZCoord(8.5),
        cecRailMountThickness - cecHoleExt + yOffset -
        PCBHolePadThickness];

    rotate([90,0,0])
    translate(holePlacement)
    cylinder(h=cecRailMountThickness + doubleOf(cecHoleExt) +
        PCBHolePadThickness + thicknessExt,
        d=csPCBMountHoleDia);
}

module cecBackplaneBeam()
{
    // Adjust to extend from default thickness.
    thicknessExt = cecBeamThickness - cecRailMountThickness;
    notchHeight = (8 * cecIDCSpacing) +
        doubleOf(csIDCSolderClearance);
    notchWidth = cecIDCSpacing +
        doubleOf(csIDCSolderClearance);
    notchThickness = csIDCPinClearance -
        PCBHolePadThickness;
    difference()
    {
        union()
        {
            cecMainSpanMounts(thicknessExt=thicknessExt);
            cecBeamPCBMountPad(zOffset=
                halfOf(csHoleVertSpacing));
            cecBeamPCBMountPad(zOffset=
                -halfOf(csHoleVertSpacing));
//            translate([-notchWidth - cecIDCOffset +
//                halfOf(HPUnit),
//                -notchThickness - cecRailMountThickness,
//                halfOf(cecH10) - bb2Row2ZCoord(8.5) -
//                halfOf(notchHeight)])
//            cube([notchWidth, notchThickness,
//                notchHeight]);
        }
        cecBeamPCBMountHole(zOffset=
            halfOf(csHoleVertSpacing),
            thicknessExt=thicknessExt);
        cecBeamPCBMountHole(zOffset=
            -halfOf(csHoleVertSpacing),
            thicknessExt=thicknessExt);
        translate([-notchWidth - cecIDCOffset +
            halfOf(HPUnit),
            -notchThickness - cecRailMountThickness,
            halfOf(cecH10) - bb2Row2ZCoord(8.5) -
            halfOf(notchHeight)])
        cube([notchWidth, notchThickness + cecHoleExt,
            notchHeight]);
    }
}

///////////////////////////////////////////////////////
// Main program to rendor the project.

// Make curves smoother
$fs = 0.25; // 3D printer layer thickness
$fa = 1;    // 1 degree increments minimum
$fn = 60;   // 60 items

//mirror([1, 0, 0])
cecBackplaneBeam();

