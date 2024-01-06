Unit Pieces;

interface
   Procedure King(color:shortint);
   Procedure Laser1(color:shortint);
   Procedure Laser2(color:shortint);
   Procedure Laser3(color:shortint);
   Procedure Laser4(color:shortint);
   Procedure HyperCube(color:shortint);
   Procedure BeamSp1(color:shortint);
   Procedure BeamSp2(color:shortint);
   Procedure BeamSp3(color:shortint);
   Procedure BeamSp4(color:shortint);
   Procedure Block1(color:shortint);
   Procedure Block2(color:shortint);
   Procedure Block3(color:shortint);
   Procedure Block4(color:shortint);
   Procedure DiagMir1(color:shortint);
   Procedure DiagMir2(color:shortint);
   Procedure StrMirH(color:shortint);
   Procedure StrMirV(color:shortint);
   Procedure Triangl1(color:shortint);
   Procedure Triangl2(color:shortint);
   Procedure Triangl3(color:shortint);
   Procedure Triangl4(color:shortint);

Implementation
Uses Graph;

procedure PieceColor(color:shortint);
begin
   if color=1 then
      begin
         SetColor(lightgreen);
         SetFillStyle(SolidFill,LightGreen);
      end
   else
      begin
         SetColor(lightred);
         SetFillStyle(SolidFill,LightRed);
      end;
end;

procedure King(color:shortint);
begin
   SetLineStyle(0,0,1);
   PieceColor(color);
   line(30,5,30,30);
   line(10,17,50,17);
   line(10,17,30,5);
   line(30,5,50,17);
   line(50,17,30,30);
   line(30,30,10,17);
end;

procedure Laser1(color:shortint);
const
   Poly:array[1..7] of PointType =
     ((x:10;y:26),(x:25;y:30),(x:35;y:30),(x:50;y:26),(x:33;y:26),
     (x:30;y:5),(x:27;y:26));
begin
   SetLineStyle(0,0,1);
   PieceColor(color);
   FillPoly(SizeOf(Poly) div SizeOf(PointType),Poly);
end;

procedure Laser2(color:shortint);
const
   Poly:array[1..7] of PointType =
     ((x:16;y:5),(x:12;y:14),(x:12;y:20),(x:16;y:29),(x:16;y:20),
     (x:47;y:17),(x:16;y:14));
begin
   SetLineStyle(0,0,1);
   PieceColor(color);
   FillPoly(SizeOf(Poly) div SizeOf(PointType),Poly);
end;

procedure Laser3(color:shortint);
const
   Poly:array[1..7] of PointType =
     ((x:10;y:9),(x:25;y:5),(x:35;y:5),(x:50;y:9),(x:33;y:9),
     (x:30;y:30),(x:27;y:9));
begin
   SetLineStyle(0,0,1);
   PieceColor(color);
   FillPoly(SizeOf(Poly) div SizeOf(PointType),Poly);
end;

procedure Laser4(color:shortint);
const
   Poly:array[1..7] of PointType =
     ((x:43;y:5),(x:47;y:14),(x:47;y:20),(x:43;y:29),(x:43;y:20),
     (x:12;y:17),(x:43;y:14));
begin
   SetLineStyle(0,0,1);
   PieceColor(color);
   FillPoly(SizeOf(Poly) div SizeOf(PointType),Poly);

end;

procedure HyperCube(color:shortint);
begin
   SetLineStyle(0,0,1);
   PieceColor(color);
   Rectangle(10,5,50,30);
   Rectangle(11,6,49,29);
end;

procedure BeamSp1(color:shortint);
const
   Poly:array[1..3] of PointType =
     ((x:15;y:30),(x:45;y:30),(x:30;y:17));
begin
   SetLineStyle(0,0,1);
   PieceColor(color);
   FillPoly(SizeOf(Poly) div SizeOf(PointType),Poly);
   SetLineStyle(0,0,3);
   SetColor(white);
   line(15,30,30,17);
   line(30,17,45,30);
end;

procedure BeamSp2(color:shortint);
const
   Poly:array[1..3] of PointType =
     ((x:13;y:7),(x:13;y:28),(x:30;y:17));
begin
   SetLineStyle(0,0,1);
   PieceColor(color);
   FillPoly(SizeOf(Poly) div SizeOf(PointType),Poly);
   SetLineStyle(0,0,3);
   SetColor(white);
   line(13,7,30,17);
   line(30,17,13,28);
end;

procedure BeamSp3(color:shortint);
const
   Poly:array[1..3] of PointType =
     ((x:15;y:5),(x:45;y:5),(x:30;y:17));
begin
   SetLineStyle(0,0,1);
   PieceColor(color);
   FillPoly(SizeOf(Poly) div SizeOf(PointType),Poly);
   SetLineStyle(0,0,3);
   SetColor(white);
   line(15,5,30,17);
   line(30,17,45,5);
end;

procedure BeamSp4(color:shortint);
const
   Poly:array[1..3] of PointType =
     ((x:46;y:7),(x:46;y:28),(x:30;y:17));
begin
   SetLineStyle(0,0,1);
   PieceColor(color);
   FillPoly(SizeOf(Poly) div SizeOf(PointType),Poly);
   SetLineStyle(0,0,3);
   SetColor(white);
   line(46,7,30,17);
   line(30,17,46,28);
end;

procedure Block1(color:shortint);
begin
   SetLineStyle(0,0,1);
   PieceColor(color);
   bar(10,5,50,30);
   SetLineStyle(0,0,3);
   SetColor(white);
   line(10,6,50,6);
end;

procedure Block2(color:shortint);
begin
   SetLineStyle(0,0,1);
   PieceColor(color);
   bar(10,5,50,30);
   SetLineStyle(0,0,3);
   SetColor(white);
   Line(49,5,49,30);
end;

procedure Block3(color:shortint);
begin
   SetLineStyle(0,0,1);
   PieceColor(color);
   bar(10,5,50,30);
   SetLineStyle(0,0,3);
   SetColor(white);
   line(10,29,50,29);
end;

procedure Block4(color:shortint);
begin
   SetLineStyle(0,0,1);
   PieceColor(color);
   bar(10,5,50,30);
   SetLineStyle(0,0,3);
   SetColor(white);
   Line(11,5,11,30);
end;

procedure DiagMir1(color:shortint);
begin
   PieceColor(color);
   SetLineStyle(0,0,1);
   line(10,5,50,28);
   line(10,6,50,29);
   SetColor(white);
   line(10,4,50,27);
   line(10,7,50,30);
end;

procedure DiagMir2(color:shortint);
begin
   PieceColor(color);
   SetLineStyle(0,0,1);
   line(50,5,10,28);
   line(50,6,10,29);
   SetColor(white);
   line(50,4,10,27);
   line(50,7,10,30);
end;

procedure StrMirH(color:shortint);
begin
  SetLineStyle(0,0,1);
  PieceColor(color);
  Line(10,17,50,17);
  Line(10,18,50,18);
  SetColor(white);
  Line(10,16,50,16);
  Line(10,19,50,19);
end;

procedure StrMirV(color:shortint);
begin
   SetLineStyle(0,0,1);
   PieceColor(color);
   Line(29,5,29,30);
   Line(30,5,30,30);
   SetColor(white);
   Line(28,5,28,30);
   Line(31,5,31,30);
end;

procedure Triangl1(color:shortint);
const
   Poly:array[1..3] of PointType =
     ((x:10;y:5),(x:10;y:30),(x:50;y:30));
begin
   SetLineStyle(0,0,1);
   PieceColor(color);
   FillPoly(SizeOf(Poly) div SizeOf(PointType),Poly);
   SetLineStyle(0,0,3);
   SetColor(white);
   line(10,5,50,30);
end;

procedure Triangl2(color:shortint);
const
   Poly:array[1..3] of PointType =
     ((x:10;y:30),(x:10;y:5),(x:50;y:5));
begin
   SetLineStyle(0,0,1);
   PieceColor(color);
   FillPoly(SizeOf(Poly) div SizeOf(PointType),Poly);
   SetLineStyle(0,0,3);
   SetColor(white);
   line(10,30,50,5);
end;

procedure Triangl3(color:shortint);
const
   Poly:array[1..3] of PointType =
     ((x:10;y:5),(x:50;y:5),(x:50;y:30));
begin
   SetLineStyle(0,0,1);
   PieceColor(color);
   FillPoly(SizeOf(Poly) div SizeOf(PointType),Poly);
   SetLineStyle(0,0,3);
   SetColor(white);
   line(10,5,50,30);
end;

procedure Triangl4(color:shortint);
const
   Poly:array[1..3] of PointType =
     ((x:10;y:30),(x:50;y:30),(x:50;y:5));
begin
   SetLineStyle(0,0,1);
   PieceColor(color);
   FillPoly(SizeOf(Poly) div SizeOf(PointType),Poly);
   SetLineStyle(0,0,3);
   SetColor(white);
   line(10,30,50,5);
end;

end.