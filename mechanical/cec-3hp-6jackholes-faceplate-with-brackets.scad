// CEC 3HP Plain Faceplate With PCB Mount Brackets
// Copyright (C) 2025 Darcy L. Watkins

include <include/cec-3hp-faceplate-with-brackets.scad>

// Six jacks aligned with the following rows of the protoboard.
jackRows = [8, 13, 18, 23, 28, 33];
// Centerline of jack holes offset from the PCB component side.
jackOffset = 7.00;
// Jack diameter through the holes.
jackDia = 6.80;

cecWClearance = 0.2; // Need the extra bit of width.

module jackHole(row, offset)
{
    echo("Jack hole at ", row=row, offset=offset);
    // Down from top of PCB.
    jackZ = halfOf(cecH10) - bb2Row2ZCoord(row);
    // No special transform needed.
    jackX = offset;
    // Same offset as used for panel plate holes.
    jackY = -cecPanelThickness - cecHoleExt;

    translate([jackX, jackY, jackZ])
    rotate([-90,0,0])
    cylinder(h=cecPanelThickness + doubleOf(cecHoleExt),
        d=jackDia + cecClearance);
}

module cecPanel()
{
    // Panel plate, minus the holes, plus the ridge,
    // plus the two PCB spacers.
    union()
    {
        difference()
        {
            // Panel plate
            cecPanelPlate();
            // Mounting holes on each end
            cecPanelMountingHoles();
            // Jack holes
            for(row = jackRows)
                jackHole(row, jackOffset);
        }
        // Panel ridge
        cecPanelRidge();
        // Top PBC spacer
        cecPCBBracket();
        // Bottom PCB spacer
        mirror([0,0,1])
        cecPCBBracket();
    }
}

///////////////////////////////////////////////////////
// Main program to rendor the project.

// Make curves smoother
$fs = 0.25; // 3D printer layer thickness
$fa = 1;    // 1 degree increments minimum
$fn = 60;   // 60 items

cecPanel();

