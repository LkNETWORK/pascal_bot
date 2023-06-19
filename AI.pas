program El;
uses crt,dos;
var wkd:array[0..6]of string;
    nm,ai,cmd,re,tmp:string;
    dt,tm:array[0..4]of word;
   // tm:array[0..4]of integer;
    sp,sp2,d,m,ran:byte;
    mem,ev:array[0..31,0..12]of string;
    mem2:array[0..31,0..12]of ansistring;
    mem3,ev2,birthday:array[0..31,0..12]of boolean;
    bir2:array[0..2]of integer;
    mn,ev3,i,j,k:longint; ex:char;
label
  ret,inp;
begin

   CLRSCR;
   assign(input,'info.txt');
   reset(input);
   if not EOF then
   begin
     readln(ai); readln(nm);
     readln(d,m);
     birthday[d,m]:=true;
     bir2[1]:=d;bir2[2]:=m;
   end;
   close(input);
   assign(input,'memo.txt');
   reset(input);
   sp:=length(ai)+2; sp2:=length(nm)+2;
   wkd[0]:='Sunday'; wkd[1]:='Monday';
   wkd[2]:='Tuesday'; wkd[3]:='Wednesday';
   wkd[4]:='Thrusday'; wkd[5]:='Friday';
   wkd[6]:='Saturday';
   Getdate(dt[1],dt[2],dt[3],dt[4]);
   while not eof do
   begin
     readln(d,m);
     readln(mem[d,m]);
     readln(mem2[d,m]);
     mem3[d,m]:=true;
     inc(mn);
   end;
   close(input);
   assign(input,'event.txt');
   reset(input);
   while not EOF do
   begin
     readln(d,m);
     readln(ev[d,m]);
     ev2[d,m]:=true;
     inc(ev3);
   end;
   close(input);
   assign(input,''); reset(input);
   assign(output,''); rewrite(output);
   write(ai,'> ');
   Write('Hello!, I am ',ai);
   writeln(',Your personal AI assistant');
   write(' ':sp);
   writeln('Welcome back, ',nm);
   write(' ':sp);
   write('Today is ',dt[3],'/',dt[2],'/');
   writeln(dt[1],' ',wkd[dt[4]]);
   if birthday[dt[3],dt[2]] then
     writeln(' ':sp,'Happy Birthday!',nm);
   if ev2[dt[3],dt[2]] then
     writeln(' ':sp,'YOu have an event, "',ev[dt[3],dt[2]],'" today');
   while true do
   begin
     inp:
     writeln;
     write(nm,'> ');
     readln(cmd);
     ret:
     cmd:=lowercase(cmd);
     for i:=1 to length(cmd) do
     begin
       if cmd[i]=' ' then
        begin
         delete(cmd,i,1);
         goto ret
       end
     end;
     writeln;
     //writeln(cmd);
     if cmd='time' then
       begin
         gettime(tm[1],tm[2],tm[3],tm[4]);
         write(ai,'> ');
         if tm[1]=0 then tm[1]:=12;
         write('The time is ',tm[1],':');
         if tm[2]<10 then write(0);
         writeln(tm[2]);
       end
    else if cmd='getmemo' then
    begin
      if mn=0 then
        writeln(ai,'> No Memo to view')
      else
      begin
        writeln(ai,'> Entered Memo Data Base');
        write(' ':sp,'Enter the date of the Memo ');
        writeln('you want too see');
        write('Date:');
        readln(d,m);
        writeln(mem[d,m]);
        writeln(mem2[d,m]);
      end;
    end
    else if cmd='addmemo' then
    begin
      writeln(ai,'> Entered Memo Data Base');
      writeln(' ':sp,'Enter the date of the New Memo');
      write('Date:');
      readln(d,m);
      write('Title:');
      readln(mem[d,m]);
      write('Contents:');
      readln(mem2[d,m]);
      writeln('Saving...');
      write('Your memo "',mem[d,m]);
      writeln('" has been recorded');
      inc(mn);
      assign(output,'memo.txt');
      rewrite(output);
      for i:=1 to 30 do
        for j:=1 to 12 do
        if mem3[i,j]=true then
        begin
          writeln(i,' ',j);
          writeln(mem[i,j]);
          writeln(mem2[i,j]);
        end;
      close(output);
    end
    else if cmd='delmemo' then
    begin
      if mn=0 then
        writeln(ai,'> No Memo to Delete')
      else
      begin
        write('Date:');
        readln(d,m);
        dec(mn);
        writeln;
        write(ai,'> ');
        writeln('Memo ''',mem[d,m],''' deleted');
        mem[d,m]:=''; mem2[d,m]:=''; mem3[d,m]:=false;
        assign(output,'memo.txt');
        rewrite(output);
        for i:=1 to 30 do
          for j:=1 to 12 do
          if mem3[i,j]=true then
          begin
            writeln(i,' ',j);
            writeln(mem[i,j]);
            writeln(mem2[i,j]);
          end;
        close(output);
      end;
    end
    else if (cmd='exit')or (cmd='bye')then
    begin
      write(ai,'> ');
      write('Press enter to confirm exit');
      ex:=readkey;
      if ord(ex)=13 then
        break
      else
      begin
        writeln;
        writeln(ai,'> Exit Cancelled');
        writeln;
        goto inp;
      end;
    end
    else if cmd='kit' then
    begin
      write(ai,'> ');
      writeln('Leung');
    end
    else if (cmd='hi') or (cmd='hi!')then
    begin
      write(ai,'> ');
      writeln('Hi!');
    end
    else if(cmd='hello!')or(cmd='hello') then
      writeln(ai,'> Hello!')
    else if cmd='magic8' then
    begin
      writeln(ai,'> Entered Magic 8 Ball');
      writeln;
      while true do
      begin
        write(nm,'> ');
        readln(tmp);
        writeln;
        for i:=1 to length(cmd) do
        begin
          if (ord(cmd[i]) < ord('Z')+1) then
            if (ord(cmd[i])>64)then
             cmd[i]:=chr(ord(cmd[i])+32);
        end;
        if (tmp='#')or(tmp='exit') then
        begin
          writeln('Exit Magic 8 ball');
          break;
        end;
        randomize;
        ran:=random(8)+1;
        case ran of
          1:tmp:='Wow, seems great!';
          2:tmp:='Things are not really that bad';
          3:tmp:='Don''t give up!';
          4:tmp:='Interesting!';
          5:tmp:='I feel sorry about this';
          6:tmp:='Thanks a lot!';
          7:tmp:='Celebrate it!';
          8:tmp:='Keep calm and carry on!';
        end;
        write('Magic 8 ball> ');
        writeln(tmp);
        writeln;
      end;
    end
    else if (cmd='clrscr') then ClrScr
    else if (cmd='date') then
    begin
      write(ai,'> ');
      write('Today is ',dt[3],'/',dt[2],'/');
      writeln(dt[1],' ',wkd[dt[4]]);
    end
    else
    if (cmd='fucku')or(cmd='fuckyou') then
      writeln(ai,'> Fuck you too')
    else if cmd='listevent' then
    begin
    if ev3=0 then
      writeln('No events!')
    else
      for i:=1 to 31 do
        for j:=1 to 12 do
          if ev2[i,j]=true then
            writeln(i,'/',j,ev[i,j]);
    end
    else if cmd='addevent'then
    begin
      write('Date:');
      readln(d,m);
      write('Events:');
      readln(ev[d,m]);
      ev2[d,m]:=true;
      close(output);
      assign(output,'event.txt');
      rewrite(output);
      for i:=1 to 31 do
        for j:=1 to 12 do
          if(ev2[i,j]=true)then
          begin
            writeln(i,' ',j);
            writeln(ev[i,j]);
          end;
      close(output);
    end
    else if cmd='delevent'then
    begin
      if ev3=0 then
        writeln('No event to delete')
      else
      begin
        write('Date:');
        readln(d,m);
        writeln('Event "',ev[d,m],'" is deleted');
        ev[d,m]:='';
        ev2[d,m]:=false;
        close(output);
        dec(ev3);
        assign(output,'event.txt');
        rewrite(output);
        for i:=1 to 31 do
          for j:=1 to 12 do
            if(ev2[i,j]=true)then
            begin
              writeln(i,' ',j);
              writeln(ev[i,j]);
            end;
        close(output);
      end;
    end
    else if cmd='editname' then
    begin
      write('New name:');
      readln(nm);
      close(output);
      assign(output,'info.txt');
      rewrite(output);
      writeln(ai);writeln(nm);
      writeln(bir2[1],' ',bir2[2]);
      close(output);
    end
    else if cmd='editai' then
     begin
      readln(ai);
      assign(output,'info.txt');
      rewrite(output);
      writeln(ai);writeln(nm);
      writeln(bir2[1],' ',bir2[2]);
      close(output);
    end
    else
      writeln(ai,'> Error:Command "',cmd,'"  not found');
   assign(input,''); assign(output,'');
   reset(input); rewrite(output);
   end;
   writeln;
   write(' ':sp);
   writeln('See you next time, ',nm,'!');
   delay(500);
   assign(output,'info.txt');
   rewrite(output);
   writeln(ai);writeln(nm);
   writeln(bir2[1],' ',bir2[2]);
   close(output);
   assign(output,'event.txt');
   rewrite(output);
   for i:=1 to 31 do
     for j:=1 to 12 do
     if(ev2[i,j]=true)then
     begin
       writeln(i,' ',j);
       writeln(ev[i,j]);
     end;
   close(output);
   assign(output,'memo.txt');
   rewrite(output);
   for i:=1 to 30 do
     for j:=1 to 12 do
     if mem3[i,j]=true then
     begin
       writeln(i,' ',j);
       writeln(mem[i,j]);
       writeln(mem2[i,j]);
     end;
   close(output);
end.
