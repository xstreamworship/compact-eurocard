// CEC 3HP Plain Faceplate With PCB Mount Brackets
// Copyright (C) 2025 Darcy L. Watkins

include <include/cec-3hp-faceplate-with-brackets.scad>

cecWClearance = cecClearance; // Set to standard

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

