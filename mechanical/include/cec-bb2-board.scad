include <cec-common.scad>

///////////////////////////////////////////////////////
// Reference design based on BPS BB2 100mm by 80mm
// prototyping BusBoard.  Orientation is:
//   Height (long side of board) - Z axis - rows
//   Depth (short side of board) - Y axis - columns
//   Thickness (thickness of board) - X- axis
bb2Height = cecH10; // 100mm
bb2Depth = cecD3; // 80mm
bb2HoleSpacing = 2.54; // 2.54mm (breadboard spacing)
bb2NumRows = 38; // Rows of holes
bb2NumCols = 31; // Columns of holes
// Note: The margins on each side of the hole matrix
//       appear symmetrical top and bottom, and
//       front and rear.
bb2MarginTB = halfOf(bb2Height - ((bb2NumRows - 1) *
    bb2HoleSpacing)); // Margin at top and bottom.
bb2MarginFR = halfOf(bb2Depth - ((bb2NumCols - 1) *
    bb2HoleSpacing)); // Margin at front and rear.

echo(bb2MarginTB=bb2MarginTB, bb2MarginFR=bb2MarginFR);

// PCB mount hole locations are symmetrical top
// and bottom so we specify the top one as hole
// coordinates.  (Starting count from 1 not 0).
cecPCBHoleFrontOffset = 10; // Columns from front of PCB.
cecPCBHoleEdgeOffset = 3; // Rows from each side of PCB.


function bb2Col2YCoord(col) = bb2MarginFR + (col -
    1) * bb2HoleSpacing; // Offset from front of PCB.
function bb2Row2ZCoord(row) = bb2MarginTB + (row -
    1) * bb2HoleSpacing; // Offset from (top) side of PCB.

// These are computed, but can be overriden for a custom
// PCB based on a different format.
// Note: These are relative to the PCB top/bottom front
//       corners.
cecPCBHoleYBrd = bb2MarginFR + (cecPCBHoleFrontOffset -
    1) * bb2HoleSpacing; // Offset from front of PCB.
cecPCBHoleZBrd = bb2MarginTB + (cecPCBHoleEdgeOffset -
    1) * bb2HoleSpacing; // Offset from each side of PCB.

echo(cecPCBHoleYBrd=cecPCBHoleYBrd, cecPCBHoleZBrd=cecPCBHoleZBrd);

// Absolute coordinates.
cecPCBHoleYCoord = cecPCBSetback + cecPCBHoleYBrd;
cecPCBHoleZCoord = halfOf(bb2Height) - cecPCBHoleZBrd;

echo(cecPCBHoleYCoord=cecPCBHoleYCoord, cecPCBHoleZCoord=cecPCBHoleZCoord);
