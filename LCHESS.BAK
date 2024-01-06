program LaserChess;
        (************************************************)
        (*                                              *)
        (*                 * LASER CHESS *              *)
        (*             By Chad Beeder 5/15/90           *)
        (*                                              *)
        (************************************************)

Uses Graph, Crt, Pieces, KeyTTT5;

type BoardType=array[1..9,1..9,1..2] of ShortInt;
     HitTableType=array[1..22,1..4] of ShortInt;
     PDType=array[1..2,1..3] of ShortInt;
     FilenameType=string[8];

var
   GrDriver,GrMode,x,y,MovesLeft,loop:integer;
   DumChar,Choice:char;
   Board:BoardType;
   HitTable:HitTableType;
   f:file of ShortInt;
   dumshort:ShortInt;
   Done,MouseInstalled:boolean;
   PD:PDType;

function Menu(ML:integer):char;
var DumString:string;
    but:button;
    h,v:integer;
begin
   if ML>2 then DumString:='GREEN'
      else DumString:='RED';
   SetFillStyle(SolidFill,black);
   bar(50,325,590,335);
   SetTextStyle(DefaultFont,0,0);
   SetColor(white);
   OutTextXY(50,325,DumString+' Player:');
   OutTextXY(180,325,'[M]ove   [R]otate   [F]ire   [O]ptions');
   if MouseInstalled=false then
      Menu:=ReadKey
   else
      begin
         Confine_Mouse_Horiz(22,61);
         Confine_Mouse_Vert(41,41);
         Move_Mouse(22,41);
         Show_Mouse_Cursor;
         repeat
            Get_Mouse_Action(but,h,v);
         until But<>NoB;
         Hide_Mouse_Cursor;
         case h of
            21..29:menu:='m';
            30..40:menu:='r';
            41..49:menu:='f';
            50..61:menu:='o';
         end;
         repeat
            Get_Mouse_Action(but,h,v);
         until But=NoB;
      end;
end;

procedure TitleScreen;
var ErrorCode:integer;
    but:button;
    h,v:integer;
begin
   MouseInstalled:=Mouse_Installed;
   GrDriver:=EGA;
   GrMode:=EGAHi;
   InitGraph(GrDriver,GrMode,'c:\prog\turbo6\bgi');
   ErrorCode:=GraphResult;
   if ErrorCode<>GrOk then
      begin
         CloseGraph;
         writeln('Graphics Error: ',GraphErrorMsg(ErrorCode));
         Halt(1);
      end;
   SetBkColor(DarkGray);
   SetColor(Yellow);
   SetTextStyle(TriplexFont,0,8);
   OutTextXY(70,50,'LASER CHESS');
   SetTextStyle(TriplexFont,0,2);
   OutTextXY(280,125,'DELUXE');
   SetColor(LightMagenta);
   SetTextStyle(SansSerifFont,0,4);
   OutTextXY(200,150,'By Chad Beeder');
   SetColor(LightGreen);
   SetTextStyle(DefaultFont,0,2);
   OutTextXY(130,200,'Press Any Key to Begin...');
   SetLineStyle(0,0,3);
   SetColor(blue);
   rectangle(50,50,580,230);
   if MouseInstalled=true then
      begin
         repeat
            Get_Mouse_Action(but,h,v);
         until (KeyPressed<>false) or (but<>NoB);
         if KeyPressed=true then DumChar:=readkey;
         while but<>NoB do
            Get_Mouse_Action(But,h,v);
      end
   else
      dumchar:=readkey;
end;

procedure SelectPieceMouse(board:BoardType;var x,y:integer;ResetMouse:boolean);
var but:button;
    h,v:integer;
begin
   if ResetMouse=true then
      begin
         Confine_Mouse_Horiz(7,73);
         Confine_Mouse_Vert(1,39);
         Move_Mouse(39,20);
      end;
   Show_Mouse_Cursor;
   repeat
      Get_Mouse_Action(but,h,v);
   until but<>NoB;
   x:=h*8;
   y:=v*8;
   x:=(x-50) div 60+1;
   y:=(y-5) div 35+1;
   Hide_Mouse_Cursor;
   repeat
      Get_Mouse_Action(but,h,v);
   until but=NoB;
end;

procedure SelectPiece(board:BoardType;var x,y:integer;ResetMouse:boolean);
var done:boolean;
begin
   if MouseInstalled=true then
      begin
         SelectPieceMouse(board,x,y,ResetMouse);
         Exit;
      end;
   SetLineStyle(0,0,3);
   x:=5;
   y:=5;
   done:=false;
   while done=false do
      begin
         repeat
            SetColor(yellow);
            Rectangle((x-1)*60+51,(y-1)*35+6,(x-1)*60+108,(y-1)*35+38);
            if (x+y) mod 2=0 then SetColor(blue)
               else SetColor(black);
            if (x=5) and (y=5) then SetColor(magenta);
            Rectangle((x-1)*60+51,(y-1)*35+6,(x-1)*60+108,(y-1)*35+38);
         until KeyPressed;
         case ReadKey of
            #0:case ReadKey of
               'K':x:=x-1;
               'M':x:=x+1;
               'H':y:=y-1;
               'P':y:=y+1;
            end;
            chr(13):done:=true;
         end;
         if x<1 then x:=1;
         if x>9 then x:=9;
         if y<1 then y:=1;
         if y>9 then y:=9;
      end;
end;

procedure DispMovesLeft(ML:integer);
begin
   SetFillStyle(1,black);
   bar(15,150,31,157);
   if ML>2 then
      begin
         SetFillStyle(1,LightGreen);
         ML:=ML-2;
      end
   else SetFillStyle(1,LightRed);
   for loop:=1 to ML do
      bar(10*loop+5,150,10*loop+11,157);
end;

procedure DrawPiece(board:BoardType;x,y:integer);
begin
   if (x+y) mod 2=0 then SetFillStyle(1,blue)
      else SetFillStyle(1,black);
   if (x=5) and (y=5) then SetFillStyle(1,magenta);
   bar((x-1)*60+50,(y-1)*35+5,(x-1)*60+109,(y-1)*35+39);
   SetViewPort((x-1)*60+50,(y-1)*35+5,(x-1)*60+109,(y-1)*35+39,true);
   case board[x,y,1] of
      1:King(board[x,y,2]);
      2:Laser1(board[x,y,2]);
      3:Laser2(board[x,y,2]);
      4:Laser3(board[x,y,2]);
      5:Laser4(board[x,y,2]);
      6:HyperCube(board[x,y,2]);
      7:BeamSp1(board[x,y,2]);
      8:BeamSp2(board[x,y,2]);
      9:BeamSp3(board[x,y,2]);
      10:BeamSp4(board[x,y,2]);
      11:Block1(board[x,y,2]);
      12:Block2(board[x,y,2]);
      13:Block3(board[x,y,2]);
      14:Block4(board[x,y,2]);
      15:DiagMir1(board[x,y,2]);
      16:DiagMir2(board[x,y,2]);
      17:StrMirH(board[x,y,2]);
      18:StrMirV(board[x,y,2]);
      19:Triangl1(board[x,y,2]);
      20:Triangl2(board[x,y,2]);
      21:Triangl3(board[x,y,2]);
      22:Triangl4(board[x,y,2]);
   end;
   SetViewPort(0,0,GetMaxX,GetMaxY,true);
end;

procedure SetUpPieces(board:BoardType);
begin
  for y:=1 to 9 do
     for x:=1 to 9 do
        drawpiece(board,x,y);
end;


procedure SetupBoard(var board:BoardType);
begin
   SetBkColor(black);
   ClearDevice;
   Randomize;
   SetLineStyle(0,0,3);
   SetColor(LightBlue);
   line(50,3,589,3);
   line(48,2,48,319);
   line(47,321,589,321);
   line(591,2,591,322);
   assign(f,'LCHESS.BRD');
   reset(f);
   for y:=1 to 9 do
      for x:=1 to 9 do
         begin
            read(f,dumshort);
            if dumshort>22 then
               begin
                  board[x,y,1]:=dumshort-22;
                  board[x,y,2]:=2;
               end;
            if (dumshort>0) and (dumshort<=22) then
               begin
                  board[x,y,1]:=dumshort;
                  board[x,y,2]:=1;
               end;
            if dumshort=0 then
               begin
                  board[x,y,1]:=0;
                  board[x,y,2]:=0;
               end;
         end;
   close(f);
   assign(f,'LCHESS.HIT');
   reset(f);
   for y:=1 to 4 do
      for x:=1 to 22 do
         begin
            read(f,dumshort);
            HitTable[x,y]:=dumshort;
         end;
   close(f);
   SetUpPieces(board);
   SetTextStyle(SmallFont,0,4);
   SetColor(LightCyan);
   OutTextXY(10,130,'Moves');
   OutTextXY(14,138,'Left');
   MovesLeft:=4;
   DispMovesLeft(MovesLeft);
end;

procedure ZapPiece(x,y:integer;var board:BoardType);
var RandX,RandY:integer;
begin
   for loop:=100 to 1000 do
      begin
         sound(loop*3+300);
         delay(2);
         sound((loop mod 90)*45);
         delay(2);
      end;
   NoSound;
   repeat
      RandX:=random(9)+1;
      RandY:=random(9)+1;
   until (board[RandX,RandY,1]=0) and ((RandX<>5) and (RandY<>5)) and ((RandX<>x) and (RandY<>y));
   Board[RandX,RandY,1]:=Board[x,y,1];
   Board[RandX,RandY,2]:=Board[x,y,2];
   Board[x,y,1]:=0;
   Board[x,y,2]:=0;
   DrawPiece(board,x,y);
   DrawPiece(Board,RandX,RandY);
end;

procedure WinScreen(winner:integer);
var WinnerString:string;
begin
   delay(1000);
   case winner of
      1:WinnerString:='1';
      2:WinnerString:='2';
   end;
   ClearDevice;
   SetBkColor(Black);
   SetTextStyle(TriplexFont,0,8);
   for loop:=2 to 15 do
      begin
         SetColor(loop);
         OutTextXY(loop+130,loop+30,'PLAYER '+WinnerString);
      end;
   SetTextStyle(GothicFont,0,0);
   SetColor(LightGreen);
   OutTextXY(220,130,'Wins the game!');
   SetColor(LightBlue);
   SetTextStyle(DefaultFont,0,0);
   OutTextXY(190,190,'Thank you for playing Laser Chess!');
   dumchar:=readkey;
   CloseGraph;
   Halt(0);
end;

procedure CheckKings(board:BoardType);
var
   LoopX,LoopY:integer;
   King1,King2:boolean;
begin
   King1:=false;
   King2:=false;
   for LoopY:=1 to 9 do
      for LoopX:=1 to 9 do
         if Board[LoopX,LoopY,1]=1 then
            if Board[LoopX,LoopY,2]=1 then King1:=true
               else King2:=true;
   if King1=false then WinScreen(2)
      else if King2=false then WinScreen(1);
end;

procedure DestroyPieces(PD:PDType;var board:BoardType);
var
   dots:array[1..3,1..100] of PointType;
   NumDestroyed:1..3;
   LoopX,LoopY,TempInt:integer;
begin
   NumDestroyed:=3;
   if PD[1,3]=0 then NumDestroyed:=2;
   if PD[1,2]=0 then NumDestroyed:=1;
   if PD[1,1]=0 then Exit;
   for loopY:=1 to NumDestroyed do
      for loopX:=1 to 100 do
         begin
            dots[loopY,LoopX].X:=(PD[1,loopY]-1)*60+50+Random(59);
            dots[loopY,loopX].Y:=(PD[2,loopY]-1)*35+5+Random(34);
            PutPixel(dots[loopY,LoopX].X,dots[loopY,loopX].Y,White);
         end;
   for loop:=1 to 20 do
      for loopY:=1 to NumDestroyed do
         for loopX:=1 to 50 do
            begin
               TempInt:=round((((PD[1,loopY]-1)*60+80)-dots[loopY,loopX].X)*1.05);
               dots[loopY,loopX].X:=((PD[1,loopY]-1)*60+80)+TempInt;
               TempInt:=round((((PD[2,loopY]-1)*35+22)-dots[loopY,loopX].Y)*1.05);
               dots[loopY,loopX].Y:=((PD[2,LoopY]-1)*35+22)+TempInt;
               if ((dots[loopY,loopX].X)>50) and ((dots[loopY,loopX].X)<590)
                  and ((dots[loopY,loopX].Y)>5) and ((dots[loopY,loopX].Y)<320) then
                  PutPixel(dots[loopY,loopX].X,dots[loopY,loopX].Y,LightCyan);
               sound(random(500)+100);
            end;
   NoSound;
   for loop:=1 to NumDestroyed do
      board[PD[1,loop],PD[2,loop],1]:=0;
end;

procedure Laser(var board:BoardType;HitTable:HitTableType;XPos,YPos,Dir:integer;var PD:PDType);
var TempInt:integer;
begin
   if (XPos<1) or (XPos>9) or (YPos<1) or (YPos>9) or ((XPos=5) and (YPos=5)) then Exit;
   LineTo((XPos-1)*60+80,(YPos-1)*35+22);
   MoveTo((XPos-1)*60+80,(YPos-1)*35+22);
   if board[XPos,YPos,1]<>0 then
      begin
         case HitTable[board[XPos,YPos,1],dir] of
            1:Laser(board,HitTable,XPos,YPos-1,1,PD);
            2:Laser(board,HitTable,XPos+1,YPos,2,PD);
            3:Laser(board,HitTable,XPos,YPos+1,3,PD);
            4:Laser(board,HitTable,XPos-1,YPos,4,PD);
            5:begin
                 if PD[1,1]=0 then TempInt:=1
                    else if PD[1,2]=0 then TempInt:=2
                       else TempInt:=3;
                 PD[1,TempInt]:=XPos;
                 PD[2,TempInt]:=YPos;
              end;
            6:begin
                 Laser(board,HitTable,XPos-1,YPos,4,PD);
                 MoveTo((XPos-1)*60+80,(YPos-1)*35+22);
                 Laser(board,HitTable,XPos+1,YPos,2,PD);
              end;
            7:begin
                 Laser(board,HitTable,XPos,YPos-1,1,PD);
                 MoveTo((XPos-1)*60+80,(YPos-1)*35+22);
                 Laser(board,HitTable,XPos,YPos+1,3,PD);
              end;
         end;
      end
   else
      begin
         case dir of
            1:Laser(board,HitTable,XPos,YPos-1,1,PD);
            2:Laser(board,HitTable,XPos+1,YPos,2,PD);
            3:Laser(board,HitTable,XPos,YPos+1,3,PD);
            4:Laser(board,HitTable,XPos-1,YPos,4,PD);
         end;
      end;
end;

procedure move(var board:BoardType;var MovesLeft:integer);
var NewX,NewY:integer;
begin
   SetFillStyle(SolidFill,black);
   bar(50,325,590,335);
   OutTextXY(50,325,'Select piece to move...');
   SelectPiece(board,x,y,true);
   if (board[x,y,2]=(MovesLeft+1) div 2) or (board[x,y,2]=0) then
      begin
         Sound(500);
         Delay(100);
         NoSound;
         Exit;
      end;
   bar(50,325,590,335);
   SetColor(white);
   if MouseInstalled=true then
      begin
         OutTextXY(50,325,'Select where to move piece to.');
         SelectPiece(board,NewX,NewY,false);
         if (NewX<1) or (NewX>9) or (NewY<1) or (NewY>9) or
            (abs(NewX-X)+abs(NewY-Y)<>1) then
            begin
               Sound(500);
               Delay(100);
               NoSound;
               Exit;
            end;
      end
   else
      begin
         OutTextXY(50,325,'Enter direction to move piece in, or ESC to cancel.');
         NewX:=x;
         NewY:=y;
         case readkey of
            #0:case ReadKey of
               'K':NewX:=X-1;
               'M':NewX:=X+1;
               'H':NewY:=Y-1;
              'P':NewY:=Y+1;
           end;
           chr(27):Exit;
        end;
        if (NewX<1) or (NewX>9) or (NewY<1) or (NewY>9) then
           begin
              Sound(500);
              Delay(100);
              NoSound;
              Exit;
           end;
      end;
   if (board[NewX,NewY,1]<>0) and (board[x,y,1]<>6) and (board[x,y,1]<>11)
      and (board[x,y,1]<>12) and (board[x,y,1]<>13) and (board[x,y,1]<>14)
      and (board[x,y,1]<>1) then
      begin
         bar(50,325,590,335);
         OutTextXY(50,325,'Capture only allowed with block or king.');
         sound(500);
         Delay(100);
         NoSound;
         delay(3500);
         exit;
      end;
   if (board[NewX,NewY,1]<>0) and ((board[x,y,1]=1) or (board[x,y,1]=11)
      or (board[x,y,1]=12) or (board[x,y,1]=13) or (board[x,y,1]=14)) then
      begin
         for loop:=500 downto 100 do
            begin
               Sound(loop);
               delay(1);
            end;
         NoSound;
      end;
   if (NewX=5) and (NewY=5) then
      begin
         ZapPiece(x,y,board);
         MovesLeft:=MovesLeft-1;
         If MovesLeft=0 then MovesLeft:=4;
         DispMovesLeft(MovesLeft);
         exit;
      end;
   if board[x,y,1]=6 then
      if board[NewX,NewY,1]<>0 then
         ZapPiece(NewX,NewY,board);
   Board[NewX,NewY,1]:=Board[x,y,1];
   Board[NewX,NewY,2]:=Board[x,y,2];
   Board[x,y,1]:=0;
   Board[x,y,2]:=0;
   DrawPiece(board,x,y);
   DrawPiece(Board,NewX,NewY);
   CheckKings(board);
   MovesLeft:=MovesLeft-1;
   If MovesLeft=0 then MovesLeft:=4;
   DispMovesLeft(MovesLeft);
end;

procedure rotate(var board:BoardType;var MovesLeft:integer);
var OldPiece:ShortInt;
    Done:boolean;
    but:button;
    h,v:integer;
begin
   SetFillStyle(SolidFill,black);
   bar(50,325,590,335);
   OutTextXY(50,325,'Select piece to rotate...');
   SelectPiece(board,x,y,true);
   if (board[x,y,2]=(MovesLeft+1) div 2) or (board[x,y,2]=0) then
      begin
         Sound(500);
         Delay(100);
         NoSound;
         Exit;
      end;
   OldPiece:=board[x,y,1];
   bar(50,325,590,335);
   SetColor(white);
   if MouseInstalled=true then
      OutTextXY(50,325,'Press left button to rotate, right button when done.')
   else
      OutTextXY(50,325,'Press SPACEBAR to rotate, ENTER when done.');
   done:=false;
   repeat
      if MouseInstalled=false then
         case ReadKey of
            chr(13):done:=true;
            ' ':case Board[x,y,1] of
                   1:board[x,y,1]:=1;
                   2:board[x,y,1]:=3;
                   3:board[x,y,1]:=4;
                   4:board[x,y,1]:=5;
                   5:board[x,y,1]:=2;
                   6:board[x,y,1]:=6;
                   7:board[x,y,1]:=8;
                   8:board[x,y,1]:=9;
                   9:board[x,y,1]:=10;
                   10:board[x,y,1]:=7;
                   11:board[x,y,1]:=12;
                   12:board[x,y,1]:=13;
                   13:board[x,y,1]:=14;
                   14:board[x,y,1]:=11;
                   15:board[x,y,1]:=16;
                   16:board[x,y,1]:=15;
                   17:board[x,y,1]:=18;
                   18:board[x,y,1]:=17;
                   19:board[x,y,1]:=20;
                   20:board[x,y,1]:=21;
                   21:board[x,y,1]:=22;
                   22:board[x,y,1]:=19;
                end;
            end
      else
         begin
            repeat
              Get_Mouse_Action(but,h,v);
            until But<>NoB;
            case but of
               RightB:done:=true;
               LeftB:case board[x,y,1] of
                      1:board[x,y,1]:=1;
                      2:board[x,y,1]:=3;
                      3:board[x,y,1]:=4;
                      4:board[x,y,1]:=5;
                      5:board[x,y,1]:=2;
                      6:board[x,y,1]:=6;
                      7:board[x,y,1]:=8;
                      8:board[x,y,1]:=9;
                      9:board[x,y,1]:=10;
                      10:board[x,y,1]:=7;
                      11:board[x,y,1]:=12;
                      12:board[x,y,1]:=13;
                      13:board[x,y,1]:=14;
                      14:board[x,y,1]:=11;
                      15:board[x,y,1]:=16;
                      16:board[x,y,1]:=15;
                      17:board[x,y,1]:=18;
                      18:board[x,y,1]:=17;
                      19:board[x,y,1]:=20;
                      20:board[x,y,1]:=21;
                      21:board[x,y,1]:=22;
                      22:board[x,y,1]:=19;
                   end;
               end;
            repeat
               Get_Mouse_Action(but,h,v);
            until But=NoB;
         end;
      DrawPiece(board,x,y);
   until Done=true;
   if board[x,y,1]<>OldPiece then
      begin
        MovesLeft:=MovesLeft-1;
        if MovesLeft=0 then MovesLeft:=4;
        DispMovesLeft(MovesLeft);
      end;
end;

procedure fire(var board:BoardType;HitTable:HitTableType;var MovesLeft:integer;var PD:PDType);
var
   LX,LY:integer;
begin
   for y:=1 to 3 do
      for x:=1 to 2 do
         PD[x,y]:=0;
   LX:=0;
   LY:=0;
   for y:=1 to 9 do
      for x:=1 to 9 do
         if (board[x,y,1]>=2) and (board[x,y,1]<=5) and (board[x,y,2]<>(MovesLeft+1) div 2) then
            begin
               LX:=x;
               LY:=y;
            end;
   if LX=0 then
      begin
         SetFillStyle(SolidFill,black);
         bar(50,325,590,335);
         OutTextXY(50,325,'Hey idiot!  How can you fire if you don''t even have a laser?');
         sound(500);
         delay(100);
         NoSound;
         delay(4000);
         Exit;
      end;
   for loop:=100 to 1000 do
      begin
         sound(loop);
         delay(2);
         sound(loop+500);
         delay(2);
      end;
   for loop:=1 to 100 do
      begin
         sound(1000);
         delay(2);
         sound(1500);
         delay(2);
      end;
   for loop:=250 downto 0 do
      begin
         sound(loop*4);
         delay(1);
      end;
   NoSound;
   SetLineStyle(0,0,1);
   SetColor(yellow);
   case board[LX,LY,1] of
      2:MoveTo((LX-1)*60+80,(LY-1)*35+5);
      3:MoveTo((LX-1)*60+105,(LY-1)*35+22);
      4:MoveTo((LX-1)*60+80,(LY-1)*35+40);
      5:MoveTo((LX-1)*60+55,(LY-1)*35+22);
   end;
   case board[LX,LY,1] of
      2:Laser(board,HitTable,LX,LY-1,1,PD);
      3:Laser(board,HitTable,LX+1,LY,2,PD);
      4:Laser(board,HitTable,LX,LY+1,3,PD);
      5:Laser(board,HitTable,LX-1,LY,4,PD);
   end;
   for loop:=500 downto 0 do
      begin
         sound(((loop mod 10)*5)+100);
         delay(1);
      end;
   NoSound;
   DestroyPieces(PD,Board);
   SetUpPieces(board);
   CheckKings(board);
   MovesLeft:=MovesLeft-1;
   if MovesLeft=0 then MovesLeft:=4;
   DispMovesLeft(MovesLeft);
end;

procedure Quit(var done:boolean);
var but:button;
    h,v:integer;
begin
   SetFillStyle(SolidFill,black);
   bar(50,325,590,335);
   SetTextStyle(DefaultFont,0,0);
   SetColor(white);
   if MouseInstalled=true then
      begin
         OutTextXY(50,325,'Are you sure?  Left button to quit, right button to abort.');
         repeat
            Get_Mouse_Action(but,h,v);
         until but=NoB;
         repeat
            Get_Mouse_Action(but,h,v);
         until but<>NoB;
         if but=LeftB then
            begin
               done:=true;
               CloseGraph;
            end;
         repeat
            Get_Mouse_Action(but,h,v);
         until but=NoB;
         Exit;
      end;
   OutTextXY(50,325,'Are you sure you want to quit (Y/N)?');
   sound(500);
   delay(100);
   NoSound;
   case ReadKey of
      'Y','y':
         begin
            Done:=true;
            CloseGraph;
         end;
   end;
end;

procedure GetFilename(var filename:FilenameType);
var
   done:boolean;
   p:integer;
   CharInput:char;
begin
   filename:='        ';
   p:=0;
   done:=false;
   repeat
      CharInput:=Readkey;
      case CharInput of
         'a'..'z','A'..'Z','0'..'9':
            begin
               if p=8 then
                  begin
                     sound(1000);
                     delay(100);
                     NoSound;
                  end
               else
                  begin
                     OutTextXY(200+p*8,325,CharInput);
                     p:=p+1;
                     Filename[p]:=charinput;
                  end;
            end;
         chr(8):
            begin
               if p>0 then
                  begin
                     filename[p]:=' ';
                     p:=p-1;
                     SetFillStyle(solidfill,black);
                     bar(200+p*8,325,208+p*8,335);
                  end;
            end;
         chr(13):done:=true;
      end;
   until done=true;
end;

procedure save(board:BoardType;MovesLeft:shortint);
var
   filename:FilenameType;
   tempshort:shortint;
begin
   SetFillStyle(SolidFill,black);
   bar(50,325,590,335);
   SetTextStyle(DefaultFont,0,0);
   SetColor(white);
   OutTextXY(50,325,'Filename for save? ');
   getfilename(filename);
   if filename='        ' then exit;
   assign(f,filename+'.SAV');
   rewrite(f);
   for y:=1 to 9 do
      for x:=1 to 9 do
         if board[x,y,2]=2 then
            begin
               if board[x,y,1]=0 then
                  write(f,board[x,y,1])
               else
                  begin
                     tempshort:=board[x,y,1]+22;
                     write(f,tempshort);
                  end;
            end
         else write(f,board[x,y,1]);
   write(f,movesleft);
   close(f);
end;

procedure load(var board:BoardType;var MovesLeft:integer);
var
   filename:FilenameType;
   tempshort:shortint;
begin
   SetFillStyle(SolidFill,black);
   bar(50,325,590,335);
   SetTextStyle(DefaultFont,0,0);
   SetColor(white);
   OutTextXY(50,325,'Filename for load? ');
   getfilename(filename);
   assign(f,filename+'.SAV');
   {$I-}
   reset(f);
   {$I+}
   if IOResult<>0 then
      begin
         bar(50,325,590,335);
         OutTextXY(50,325,'ERROR: File not found.');
         sound(100);
         delay(500);
         NoSound;
         Delay(2000);
         Exit;
      end;
   for y:=1 to 9 do
      for x:=1 to 9 do
         begin
            read(f,tempshort);
            if tempshort>22 then
               begin
                  board[x,y,1]:=tempshort-22;
                  board[x,y,2]:=2;
               end
            else
               begin
                  board[x,y,1]:=tempshort;
                  board[x,y,2]:=1;
               end;
         end;
   read(f,tempshort);
   movesleft:=tempshort;
   close(f);
   SetUpPieces(board);
   DispMovesLeft(MovesLeft);
end;


procedure Options(var board:BoardType;var done:boolean);
var but:button;
    h,v:integer;
begin
   SetFillStyle(SolidFill,black);
   bar(50,325,590,335);
   SetTextStyle(DefaultFont,0,0);
   SetColor(white);
   OutTextXY(50,325,'[S]ave    [L]oad    [Q]uit');
   if MouseInstalled=false then
      case ReadKey of
         's','S':save(board,MovesLeft);
         'l','L':load(board,MovesLeft);
         'q','Q':quit(done);
      end
   else
      begin
         Confine_Mouse_Horiz(6,33);
         Confine_Mouse_Vert(41,41);
         Move_Mouse(22,41);
         Show_Mouse_Cursor;
         repeat
            Get_Mouse_Action(but,h,v);
         until But<>NoB;
         Hide_Mouse_Cursor;
         case h of
             6..15:Save(board,MovesLeft);
             16..24:Load(board,MovesLeft);
             25..33:Quit(done);
         end;
         repeat
            Get_Mouse_Action(but,h,v);
         until But=NoB;
      end;
end;

begin
   TitleScreen;
   SetupBoard(board);
   Done:=false;
   while Done=false do
      begin
         Choice:=menu(MovesLeft);
         case choice of
            'm','M':move(board,MovesLeft);
            'r','R':rotate(board,MovesLeft);
            'f','F':fire(board,HitTable,MovesLeft,PD);
            'o','O':options(board,done);
         end;
   end;
end.
