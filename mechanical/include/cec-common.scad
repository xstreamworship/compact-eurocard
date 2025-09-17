///////////////////////////////////////////////////////
// Constants and values derived from the specs.

// 19 Inch Rack (IEC-60297-3-100)
rackUnit = 44.45; // Distances in millimeters (mm)
cecCageHeight = rackUnit * 3; // 3U
cecH2 = 57.15; // Spacing between rack ear mount holes
cecH3 = 37.70; // Spacing between bottom hole and bottom of front panel

// EuroCard Sub Cage (IEC-60297-3-101)
cecH1 = 132.55; // Sub rack height (considering clearances)
cecH5 = 112.00; // Vertical aperture opening dimension
cecH5prm = 106.50; // Vertical aperture opening dimension
cecH6 = 122.50; // Vertical mounting hole dimension (front rails)
cecH6prm = 117.00; // Vertical mounting hole dimension (backplane rails)
cecH8 = 128.55; // Height of front panel pieces
cecH9 = cecH6; // Vertical mounting hole dimension (front panels)
cecH9prm = cecH6prm; // Vertical mounting hole dimension (backplane mounting brackets)
HPUnit = 5.08; // Horizontal Pitch (HP) unit
cecRackWidth = HPUnit * 84; // 84 HP
cecClearance = 0.50; // mm
cecWidth = HPUnit * 3; // 3 HP panel width

echo(cecWidth=cecWidth);

// EuroCard Module (IEC-60297-3-101)
cecH10 = 100.00; // Height of EuroCard PCB

cecPCBOffset = 4.07; // Left side of front panel to right (compoenet) side of PCB
cecPCBSetback = 2.54;
cecPCBThickness = 1.60; // PCB Thickness

// Half depth (Compact) EuroCard (100mm by 80mm).
cecD1est = 88.60; // Depth from rear of front plate to backplane PCB
cecD3 = 80.00; // PCB depth

// Compact EuroCard (CEC) specific.
cec_a = cecPCBSetback; // Space between front plate and PCB (from spec)
cec_b = cecD3; // PCB depth
cec_c = 6.98; // Ref hole set back from board edge (backplane edge)
cec_d = 10.10; // Ref hole to edge of connector (and mating platform)
cec_e = 2.60; // Height of mating connector platform from backplane
cec_f = 0; // TBD - Bracket mount hole from front of PCB
cec_g = 0; // TBD - Bracket mount hole from top/bottom of PCB
cec_h = 0; // TBD - Ref hole from top of PCB

// D1 - Depth from rear of front plate to backplane PCB
cecD1tol = cecClearance;
cecD1 = cec_a + cec_b - cec_c + cec_d + cec_e + cecD1tol;

echo(cecD1est=cecD1est, cecD1=cecD1);

cecPanelThickness = 2.00;
cecPanelRidgeThickness = cecPanelThickness;

cecBracketPCBSlotDepth = 1.70; // Bracket PCB slot depth / PCB edge keep-out.

// We want hole piece to extend past each side
// to avoid infintisimal film covering.
cecHoleExt = 0.5; // mm

// Hole diameter for M2.5 (or M3 tight fit) machine screw.
cecPanelPlateHoleDia = 3.6; // mm

// Hole for M2.5 machine screws.
cecPCBMountHoleDia = 3.2; // mm

// Hole for M2.5 machine screws.
cecRailMountHoleDia = 3.2; // mm


///////////////////////////////////////////////////////
// Handy functions useful in context of symmetry.
function halfOf(val) = val / 2.0;
function doubleOf(val) = val * 2.0;

