// CubuSynth Backplane PCB (16 x IDC Connectors)
// Copyright (C) 2025 Darcy L. Watkins
include <cec-common.scad>

// Measurements of a CubuSynth backplane PCB with two
// sections of 8-ganged 3HP spaced EuroRack IDC power bus
// connectors.  Mounting holes are (left to right from the
// front) between IDC connectors 1&2,  4&5, 7&8, 9&10,
// 12&13 and 15&16.

csHolesRightOf = [1, 4, 7, 9, 12, 15];

csPCBWidth = 279.0; // mm (measured)
csPCBHeight = 40.0; // mm (measured)

csIDCConnectorWidth = 9.0; // mm (measured)
csIDCConnectorHeight = 28.5; // mm (measured)
csIDCSolderClearance = 1.5; // mm (estimated)
csIDCPinClearance = 2.0;

// Vertical alignment of mounting holes is symetrical,
// as is the vertical alignment of the IDC connectors.
csHoleVertSpacing = 33.0; // mm
csPCBVertMargin = halfOf(csPCBHeight - csIDCConnectorHeight);

// Horizontal alignment of IDC connectors are
// spaced at 3HP intervals, for gang of 8,
// then 7HP gap, then spaced at 3HP intervals,
// for the second gang of 8.  This group is
// symetrical accross the width of the PCB.
// Horizontal alignment of mounting holes is
// symetrical between the adjacent IDC connectors.
csIDCSpan = ((((16 * 3) + 7) - 1) * HPUnit) +
    csIDCConnectorWidth;
csPCBHorzMargin = halfOf(csPCBWidth - csIDCSpan);

csPCBThickness = 1.6; // mm

// Pad diameter or bar width to contact the PCB,
// center aligned vertically with the holes.
csPCBHolePadDia = 8.0; // mm (measured)

// Hole for M3 machine screws.
csPCBMountHoleDia = 3.5; // mm
