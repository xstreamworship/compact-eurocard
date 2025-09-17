// CEC 3HP 8-Ganged Card Guides (Bottom).
// Copyright (C) 2025 Darcy L. Watkins

include <include/cec-3hp-cardguide-with-mount.scad>

// Ganged card guides, with clearance trimmed off
// only at the end.
module cecCardGuides()
{
    gangs = 8;

    // Only trim it at the end of the gang.
    endTrimPlacement = [-cecPCBOffset + (gangs * cecWidth) -
        cecClearance,
        -cecRailMountThickness - halfOf(cecHoleExt),
        -cecRailMountHoleMinOffset - halfOf(cecHoleExt)];

    trimSize = [halfOf(cecClearance) + cecHoleExt,
        cecRailMountThickness + cecHoleExt,
        halfOf(cecH9prm - cecH10) +
        cecRailMountHoleMinOffset -
        halfOf(cecClearance) + cecHoleExt];

    difference()
    {
        union()
        {
            for(i=[0:gangs - 1])
            cecCardGuide(i * cecWidth);
        }

        // Trim at end.
        translate(endTrimPlacement)
        cube(trimSize);
        
    }
}

///////////////////////////////////////////////////////
// Main program to rendor the project.

// Make curves smoother
$fs = 0.25; // 3D printer layer thickness
$fa = 1;    // 1 degree increments minimum
$fn = 60;   // 60 items

mirror([1, 0, 0])
cecCardGuides();

