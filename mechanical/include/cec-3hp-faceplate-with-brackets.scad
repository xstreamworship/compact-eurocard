// CEC 3HP Faceplate With PCB Mount Brackets
// Copyright (C) 2025 Darcy L. Watkins

include <cec-bb2-board.scad>

///////////////////////////////////////////////////////
// Modules used to piece it together.

module cecPanelHole(m=1)
{
    // CEC front panel plate has symetric holes.
    //   X --> At center of panel width
    //   Y --> Through the front plate (with
    //         the extension beyond outside and
    //         inside face of the panel plate.
    //   Z --> Symetrical at H9 spacing.
    // Note: Y and Z args are swapped because this
    //       is invoked in context of a 90deg rotate.
    translate([halfOf(cecWidth) - cecPCBOffset,
         halfOf(cecH9), -cecHoleExt])

    // Hole for M2.5 (or M3) machine screws.
    cylinder(h=cecPanelThickness + doubleOf(cecHoleExt),
        d=cecPanelPlateHoleDia);

    echo("Hole placement X,Y,Z=",
        [halfOf(cecWidth) - cecPCBOffset, -cecHoleExt,
        m * halfOf(cecH9)],
        cecPanelPlateHoleDia=cecPanelPlateHoleDia);
}

module cecPanelMountingHoles()
{
    rotate([90,0,0])
    union()
    {
        // Top mounting hole
        cecPanelHole();
        // Bottom mounting hole
        mirror([0,1,0])
        cecPanelHole(-1);
    }
}

module cecPanelPlate()
{
    // CEC front panel plate.
    // Placement is:
    //   X --> offset to have component side of PCB
    //         on the X=0, Y,Z plane.
    //   Y --> offset to have the inside face of the
    //         panel plate on the Y=0, X,Z plane.
    //   Z --> offset to have the Z=0, X,Y plane
    //         slice the middle of the panel plate.
    panelPlatePlacement = [-cecPCBOffset,
        -cecPanelThickness,
        -halfOf(cecH8)];

    // Sized X,Y,Z based on:
    //  X --> Width: 3HP minus clearance.
    //  Y --> Panel plate thickness as specified.
    //  Z --> H8 per CEC spec.
    // Note: The panel width clearance is trimmed
    //       from the right side of the panel.
    panelPlateSize = [cecWidth - cecWClearance,
        cecPanelThickness,
        cecH8];

    translate(panelPlatePlacement)
    cube(panelPlateSize);

    echo("Panel at X.Y,Z=", panelPlatePlacement, 
        " size X,Y,Z=", panelPlateSize);
}

module cecPanelRidge()
{
    // CEC front panel ridge to add strength to the plate.
    // Placement is:
    //  X --> Offset to be flush with the solder side of
    //        the PCB (with clearance).
    //  Y --> Zero, to extrude from inside face of the
    //        panel plate.
    //  Z --> Offset to span between the two PCB bracket
    //        shoulder pieces, which is essentially the
    //        PCB height minus the depth of the two slots.
    panelRidgePlacement = [-(cecPanelRidgeThickness +
        cecPCBThickness + cecClearance), 0,
        -halfOf(cecH10) + cecBracketPCBSlotDepth];

    // Sized X,Y,Z based on:
    //  X --> Width: Ridge thickness as specified.
    //  Y --> PCB setback from CEC spec + extra 0.5mm.
    //  Z --> span between the two PCB bracket
    //        shoulder pieces, which is essentially the
    //        PCB height minus the depth of the two slots..
    panelRidgeSize = [cecPanelRidgeThickness,
        cecPCBSetback + 0.5, // extra 0.5mm
        cecH10 - doubleOf(cecBracketPCBSlotDepth)];

    // The ridge is rendored in one piece rather than
    // mirrored halves because in some adaptations, it
    // could be necessary to cutout portions, which are
    // not likely to be symetrical.

    translate(panelRidgePlacement)
    cube(panelRidgeSize);

    echo("Ridge at X,Y,Z=", panelRidgePlacement,
        " size X,Y,Z=", panelRidgeSize,
        cecPCBOffset=cecPCBOffset);
}


    // Placement is:
    //  X --> 
    //  Y --> 
    //  Z --> 

    // Sized X,Y,Z based on:
    //  X --> 
    //  Y --> 
    //  Z --> 


module cecPCBBracket()
{
 //   echo(shoulderHeight=shoulderHeight,
 //       elbowSpan=elbowSpan, armLen=armLen,
 //       jointSpan=jointSpan);

    // PBC spacer from front panel
    spacerLen = 4; // PCB spacer length
    // Placement is:
    //  X --> Solder side of PCB plus clearance.
    //  Y --> Zero, to extrude from inside face of the
    //        panel plate.
    //  Z --> Spacer length from the edge of the PCB
    //        plus the clearance.
    boardThicknessWithClearance = cecPCBThickness +
        cecClearance;
    boardSolderSideWithClearanceX =
        -boardThicknessWithClearance;
    boardTopEdgeZ = halfOf(cecH10) + cecClearance;
    spacerPlacement = [boardSolderSideWithClearanceX, 0,
        boardTopEdgeZ - spacerLen];

    // Sized X,Y,Z based on:
    //  X --> PCB thickness plus clearance.
    //  Y --> Setback per spec minus clearance.
    //  Z --> Spacer length minus the PCB bracket
    //        slot depth (which provides its own
    //        spacer portion).
    spacerSize = [boardThicknessWithClearance,
        cecPCBSetback - cecClearance,
        spacerLen - cecBracketPCBSlotDepth];

    // PCB bracket shoulder (aligned with ridge).
    shoulderX = cecPanelRidgeThickness +
        cecPCBThickness + cecClearance;
    shoulderZ = halfOf(cecH10) - cecBracketPCBSlotDepth;
    // Placement is:
    //  X --> Aligned with panel plate ridge.
    //  Y --> Zero, to extrude from inside face of the
    //        panel plate.
    //  Z --> PCB slot depth short of the board edge.
    shoulderPlacement = [-shoulderX, 0, shoulderZ];

    shoulderLen = 13; // Y
    shoulderWidth = 13.22; // X
    shoulderHeight = halfOf(cecH5 - cecH10) +
        cecBracketPCBSlotDepth - (2 * cecClearance);
    // Sized X,Y,Z based on:
    //  X --> Set as specified (as needed).
    //  Y --> Set as specified (to avoid standard
    //        EuroCard card guides).
    //  Z --> Sized for outer edge to fit within
    //        aperture between the rails.
    shoulderSize = [shoulderWidth, shoulderLen,
                shoulderHeight];

    // PCB bracket slots
    slotExt = 0.5;

    // Placement is:
    //  X --> Solder side of PCB plus clearance.
    //  Y --> Setback per spec minus clearance
    //  Z --> Placed for slot to displace to the
    //        clearance from the card edge.
    slotPlacement = [boardSolderSideWithClearanceX,
        cecPCBSetback - cecClearance,
        shoulderZ - slotExt];

    // Sized X,Y,Z based on:
    //  X --> PCB thickness plus clearance.
    //  Y --> Shoulder length (with extension) after
    //        subtracting the setback.
    //  Z --> Sized for slot to displace to the
    //        clearance from the card edge.
    slotSize = [boardThicknessWithClearance,
                shoulderLen - cecPCBSetback +
                cecClearance + slotExt,
                cecBracketPCBSlotDepth + slotExt +
                cecClearance];

    // After cancelling out everything else...
    echo("PCB slot span=",
        doubleOf(halfOf(cecH10) + cecClearance));

    // PCB bracket arm
    elbowDepth = 7.00;
    armLen = cecPCBHoleYCoord - shoulderLen +
        halfOf(elbowDepth);
    armThickness = 2.60;

    // Placement is:
    //  X --> Set to align with edge of shoulder.
    //  Y --> Extends from the shoulder.
    //  Z --> Set to align with shoulder.
    armPlacement = [-shoulderX + 
            shoulderWidth - armThickness,
            shoulderLen, shoulderZ];

    // Sized X,Y,Z based on:
    //  X --> Set as specified (to avoid standard
    //        EuroCard card guides).
    //  Y --> Derived from PCB mount hole placement.
    //  Z --> Set to align with shoulder.
    armSize = [armThickness, armLen,
            shoulderHeight];

    // PCB bracket arm brace
    braceThickness = 1.20;
    braceWidth = 7.10;

    // Placement is:
    //  X --> Set to align with shoulder and arm.
    //  Y --> Extends from the shoulder.
    //  Z --> Set to align with shoulder.
    bracePlacement = [-shoulderX + shoulderWidth -
        braceWidth, shoulderLen, shoulderZ];

    // Sized X,Y,Z based on:
    //  X --> Set as specified (to avoid standard
    //        EuroCard card guides).
    //  Y --> Derived from PCB mount hole placement.
    //  Z --> Set to align with shoulder.
    braceSize = [braceWidth - armThickness, armLen,
            braceThickness];

    // PCB bracket elbow
    elbowThickness = 2.20;
    elbowSpan = shoulderWidth - shoulderX;
    // Elbow span computed to place the PCB mount flush
    // with top side of the PCB.
    // Computed to place the PCB mounting hole
    // at the specified location.
    jointSpan = halfOf(cecH10) -
        cecBracketPCBSlotDepth -
        elbowThickness - cecPCBHoleZCoord;

    // Placement is:
    //  X --> Set to align with arm and brace.
    //  Y --> Derived from PCB mount hole placement.
    //  Z --> Set to align with arm and brace..
    elbowPlacement = [-shoulderX + shoulderWidth - elbowSpan,
            cecPCBHoleYCoord - halfOf(elbowDepth),
            shoulderZ - elbowThickness];

    // Sized X,Y,Z based on:
    //  X --> Set to align wrist and pad with component
    //        side of PCB.
    //  Y --> Set for mechanical size of pad with PCB mount
    //        hole.
    //  Z --> Set for mechanical size of pad with PCB mount
    //        hole.
    elbowSize = [elbowSpan, elbowDepth,
            elbowThickness];

    // PCB bracket elbow wrist joint
    // Placement is:
    //  X --> Set to slign with component side of PCB.
    //  Y --> Derived from PCB mount hole placement.
    //  Z --> Derived from PCB mount hole placement.
    wristPlacement = [-shoulderX + shoulderWidth - elbowSpan,
                    cecPCBHoleYCoord - halfOf(elbowDepth),
                    cecPCBHoleZCoord];

    // Sized X,Y,Z based on:
    //  X --> Derived from PCB mount hole placement.
    //  Y --> Derived from PCB mount hole placement.
    //  Z --> Derived from PCB mount hole placement.
    wristSize = [elbowThickness, elbowDepth,
                    jointSpan];

    // PCB bracket elbow pad
    // Placement is:
    //  X --> Derived from PCB mount hole placement.
    //  Y --> Derived from PCB mount hole placement.
    //  Z --> Derived from PCB mount hole placement.
    padPlacement = [-shoulderX + shoulderWidth - elbowSpan,
                    cecPCBHoleYCoord, cecPCBHoleZCoord];

    // PCB bracket elbow pad hole
    // Placement is:
    //  X --> Derived from PCB mount hole placement.
    //  Y --> Derived from PCB mount hole placement.
    //  Z --> Derived from PCB mount hole placement.
    padHolePlacement = [-shoulderX + shoulderWidth -
                elbowSpan - cecHoleExt,
                cecPCBHoleYCoord, cecPCBHoleZCoord];

    union()
    {
        // PBC spacer from front panel
        translate(spacerPlacement)
        cube(spacerSize);

        echo("PCB spacer at X,Y,Z=", spacerPlacement,
            " size X,Y,Z=", spacerSize);

        // PCB bracket shoulder with PCB slot notched
        difference()
        {
            // PCB bracket shoulder
            translate(shoulderPlacement)
            cube(shoulderSize);

            echo("Shoulder at X,Y,Z=",
                spacerPlacement,
                " size X,Y,Z=",
                shoulderSize);

            // PCB bracket slots
            translate(slotPlacement)
            cube(slotSize);

            echo("PCB slot at X,Y,Z=",
                slotPlacement,
                " size X,Y,Z=", slotSize);
        }

        // PCB bracket arm
        translate(armPlacement)
        cube(armSize);

        // PCB bracket arm brace
        translate(bracePlacement)
        cube(braceSize);

        // PCB bracket elbow
        translate(elbowPlacement)
        cube(elbowSize);

        // PCB mount wristjoint with hole.
        difference()
        {
            union()
            {
                // PCB bracket elbow wrist joint
                translate(wristPlacement)
                cube(wristSize);

                // PCB bracket elbow pad
                translate(padPlacement)
                rotate([0,90,0])
                cylinder(h=elbowThickness,
                    d=elbowDepth);
            }
            // PCB bracket elbow pad hole
            translate(padHolePlacement)
            rotate([0,90,0])
            cylinder(h=elbowThickness +
                doubleOf(cecHoleExt),
                d=cecPCBMountHoleDia);
        }
    }
}
