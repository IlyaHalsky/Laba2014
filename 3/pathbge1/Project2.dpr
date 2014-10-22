{$M 16384,16777216}
type
  dinmass=array of Integer;
var
  f,g:Text;
  a:array of array of Integer;
  used:array of Boolean;
  i,n,m,l1,l2:Integer;

function min(a,b:Integer):Integer;
  begin
    if a>b then
      min:=b
    else
      min:=a;
  end;

procedure add(x:Integer;var list:dinmass);
  begin
    SetLength(list,list[0]+1);
    Inc(list[0]);
    list[list[0]-1]:=x;
  end;

function pop(var list:dinmass):Integer;
  var
    answer:Integer;
  begin
    answer:=list[list[0]-1];
    SetLength(list,list[0]-1);
    Dec(list[0]);
    pop:=answer;
  end;

procedure pathbge1(x:Integer);
  var
    j:Integer;
    list:dinmass;
    where:Integer;
  begin
    used[x]:=True;
    SetLength(list,1);
    list[0]:=1;
    for j:=1 to Length(a[x])-1 do
      begin
        if (a[x][0]+1<a[a[x][j]][0]) and (not used[a[x][j]]) then
          begin
            a[a[x][j]][0]:=a[x][0]+1;
            add(a[x][j],list);
          end;
      end;
    while list[0]>1 do
      begin
        where:=pop(list);
        pathbge1(where);
      end;
  end;


begin
  Assign(f,'pathbge1.in');
  Assign(g,'pathbge1.out');
  Reset(f);
  Rewrite(g);

  Readln(f,n,m);
  SetLength(a,n+1);
  SetLength(used,n+1);

  for i:=1 to n do
    begin
      SetLength(a[i],1);
      a[i][0]:=1337420;
    end;

  for i:=1 to m do
    begin
      Readln(f,l1,l2);
      SetLength(a[l1],Length(a[l1])+1);
      a[l1][Length(a[l1])-1]:=l2;
      SetLength(a[l2],Length(a[l2])+1);
      a[l2][Length(a[l2])-1]:=l1;
    end;
  a[1][0]:=0;
  pathbge1(1);

  for i:=1 to n do
    write(g,a[i][0],' ');
  Close(f);
  Close(g);
end.