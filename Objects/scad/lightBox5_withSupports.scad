looseTol = 0.1;

// measured
LEDSize = 4.9;
LEDTol = .1;
LEDPitch = 8.8;
LEDBoardSize = 71.3/4 + 0.5;
LEDPenetration = 1.0;
WireOffset = 9.0;
pilotHoleOffset = 2.73;
pilotHoleDiameter = .9;


EppendorfDiameter = 4.5 + looseTol;
EppendorfHeight = 23.25;
EppendorfLidHeight = 5;

NumX = 2;
NumY = 2;

// variables
IntWallThicknessXY = 1.5;
IntWallThicknessZ = 2.0;
ExtWallThickness = 1.0;
BaseChamberHeight = 5.0;
LEDBoardSpace = 1.0;
LEDEppendorfGap = 3.0;
HeadChamberHeight = 3.0;
ConeHeight = 12.0;
PilotHoleTaperHeight = 0.5;

// Derived Values
XLength = 2 * ExtWallThickness + 2 * LEDBoardSpace + LEDBoardSize;
YLength = XLength;
ZLength = BaseChamberHeight + LEDPenetration + LEDEppendorfGap + EppendorfHeight + HeadChamberHeight - EppendorfLidHeight;
InternalChamberHeight = ZLength - HeadChamberHeight - IntWallThicknessZ - IntWallThicknessZ - BaseChamberHeight;
InternalChamberWidth = LEDPitch - IntWallThicknessXY;
WireHoleX = 5;
WireHoleZ = BaseChamberHeight;
XArrayEdge = XLength/2.0 - LEDPitch * NumX/2.0 + IntWallThicknessXY/2.0;
YArrayEdge = YLength/2.0 - LEDPitch * NumY/2.0 + IntWallThicknessXY/2.0;


Smoothness = 30;

NumLidX = 1;
NumLidY = 1;
LidThicknessZ = 1.0;
LidOffsetZ = ZLength - LidThicknessZ;
LidHandleLength = 5.0;
LidHandleDiameter = 2.0;


//Lids();
LightBox();

module Lids() {
union(){
 // Array
   for ( XIndex = [0:NumLidX - 1] ){
      for ( YIndex = [0:NumLidX - 1] ){
         // Lid Plates
//         translate([XArrayEdge + XIndex*LEDPitch, YArrayEdge + YIndex*LEDPitch, LidOffsetZ + LidThicknessZ])
//         cube([LEDPitch - 2 * LEDTol, LEDPitch - 2 * LEDTol, LidThicknessZ], false);
         
         // Lid Inserts
//         translate([XArrayEdge + XIndex*LEDPitch + IntWallThicknessXY/2.0, YArrayEdge + YIndex*LEDPitch + IntWallThicknessXY/2.0, LidOffsetZ])
//         cube([InternalChamberWidth - 2 * looseTol, InternalChamberWidth - 2 * looseTol, LidThicknessZ], false);

         // Lid Pyramids
         translate([XArrayEdge + InternalChamberWidth/2.0 + XIndex*LEDPitch, YArrayEdge + InternalChamberWidth/2.0 + YIndex*LEDPitch, LidOffsetZ])
         rotate(45, [0, 0, 1])
         cylinder(2 * LidThicknessZ, sqrt(2) * 0.8 * InternalChamberWidth/2.0, sqrt(2) * (LEDPitch - 2 * LEDTol)/2.0, $fn=4);


         // Lid Handles
         translate([XArrayEdge + InternalChamberWidth/2.0 + XIndex*LEDPitch, YArrayEdge + InternalChamberWidth/2.0 + YIndex*LEDPitch, LidOffsetZ + 2 * LidThicknessZ])
         cylinder(LidHandleLength, LidHandleDiameter/2.0, LidHandleDiameter/2.0, $fn=Smoothness);
      }
   }//for loop
}
}

module LightBox() {
difference() {
   // Basic Cube
   cube([XLength, YLength, ZLength], false);

   // LED Insert
   translate([ExtWallThickness, ExtWallThickness, 0])
   cube([LEDBoardSize + 2 * LEDBoardSpace, LEDBoardSize + 2 * LEDBoardSpace, BaseChamberHeight], false);

   // Wire Duct
   translate([ExtWallThickness + LEDBoardSpace + WireOffset, 0, 0])
   cube([WireHoleX, ExtWallThickness, WireHoleZ], false);

   // pilot holes for screws
   translate([ExtWallThickness + LEDBoardSpace + pilotHoleOffset, YLength/2.0, BaseChamberHeight])
   cylinder(IntWallThicknessZ, pilotHoleDiameter/2.0, pilotHoleDiameter/2.0, false, $fn=Smoothness);
    //added taper so that these holes can be accessed
    translate([ExtWallThickness + LEDBoardSpace + pilotHoleOffset, YLength/2.0, BaseChamberHeight])
      cylinder(PilotHoleTaperHeight,pilotHoleDiameter, pilotHoleDiameter/2.0, false, $fn=Smoothness);
    
   translate([XLength - ExtWallThickness - LEDBoardSpace - pilotHoleOffset, YLength/2.0, BaseChamberHeight])
   cylinder(IntWallThicknessZ, pilotHoleDiameter/2.0, pilotHoleDiameter/2.0, false, $fn=Smoothness);
    
   translate([XLength - ExtWallThickness - LEDBoardSpace - pilotHoleOffset, YLength/2.0, BaseChamberHeight])
   cylinder(PilotHoleTaperHeight, pilotHoleDiameter, pilotHoleDiameter/2.0, false, $fn=Smoothness);
   
   // Array
   for ( XIndex = [0:NumX - 1] ){
      for ( YIndex = [0:NumX - 1] ){
         // Internal Chambers
         translate([XArrayEdge + XIndex*LEDPitch, YArrayEdge + YIndex*LEDPitch, BaseChamberHeight + IntWallThicknessZ])
         cube([InternalChamberWidth, InternalChamberWidth, InternalChamberHeight-ConeHeight], false);
          //made shorter to allow support cone to be added

         // Head Chambers
         translate([XArrayEdge + XIndex*LEDPitch, YArrayEdge + YIndex*LEDPitch, ZLength - HeadChamberHeight])
         cube([InternalChamberWidth, InternalChamberWidth, HeadChamberHeight], false);

         // Eppendorf Holes
         translate([XArrayEdge + InternalChamberWidth/2.0 + XIndex*LEDPitch, YArrayEdge + InternalChamberWidth/2.0 + YIndex*LEDPitch, ZLength - HeadChamberHeight - IntWallThicknessZ])
         cylinder(IntWallThicknessZ, EppendorfDiameter/2.0, EppendorfDiameter/2.0, $fn=Smoothness);
          
        //Support Cone 
        intersection() {
        
        translate([XArrayEdge + InternalChamberWidth/2.0 + XIndex*LEDPitch, YArrayEdge + InternalChamberWidth/2.0 + YIndex*LEDPitch, ZLength - HeadChamberHeight-IntWallThicknessZ-ConeHeight])
      cylinder(ConeHeight,sqrt(2)*InternalChamberWidth, EppendorfDiameter/2.0, $fn=Smoothness);
             
        translate([XArrayEdge + XIndex*LEDPitch, YArrayEdge + YIndex*LEDPitch, ZLength - HeadChamberHeight-IntWallThicknessZ-ConeHeight])
        cube([InternalChamberWidth, InternalChamberWidth, ConeHeight], false);
          
        } //intersection

         // LED Holes
         translate([XArrayEdge + InternalChamberWidth/2.0 + XIndex*LEDPitch, YArrayEdge + InternalChamberWidth/2.0 + YIndex*LEDPitch, BaseChamberHeight + IntWallThicknessZ/2.0])
         cube([LEDSize + 2* LEDTol, LEDSize + 2* LEDTol, IntWallThicknessZ], true);
      }
   }//for loop
   
   //Can be used to remove two of the walls to allow the LED board to be placed in 
   //translate([ExtWallThickness, ExtWallThickness, 0])
   //cube([100,100, BaseChamberHeight], false);
   
} // difference
          
}
