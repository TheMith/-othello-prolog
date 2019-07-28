
eastLateralLimit(7).
eastLateralLimit(15).
eastLateralLimit(23).
eastLateralLimit(31).
eastLateralLimit(39).
eastLateralLimit(47).
eastLateralLimit(55).
eastLateralLimit(63).

northLimit(0).
northLimit(1).
northLimit(2).
northLimit(3).
northLimit(4).
northLimit(5).
northLimit(6).
northLimit(7).

southLimit(56).
southLimit(57).
southLimit(58).
southLimit(59).
southLimit(60).
southLimit(61).
southLimit(62).
southLimit(63).

westLateralLimit(0).
westLateralLimit(8).
westLateralLimit(16).
westLateralLimit(24).
westLateralLimit(32).
westLateralLimit(40).
westLateralLimit(48).
westLateralLimit(56).
x.




getlast([H|_],H).
getValList([ H|T ],H,L):-getlast(T,L).
getValList([_|T],Pos,L):-getValList(T,Pos,L).

%Limite lateral direito
calcEastLateralLimit(Pos, L):-findall(Aux, eastLateralLimit(Aux), List),((member(Pos,List),L is Pos);(append(List,[Pos],L3),sort(L3, L4),getValList(L4,Pos,L))).

%limite lateral esquerdo
calcWestLateralLimit(Pos, L):-findall(Aux, westLateralLimit(Aux), List),((member(Pos,List),L is Pos);(append(List,[Pos],L3),sort(L3, L4), reverse(L4,L5),  getValList(L5,Pos,L))).

/*
calcEastLateralLimit(Pos, L):- findall(Aux, westLateralLimit(Aux), List), calcWestLateralLimit(Pos, L, List).
calcEastLateralLimit(Pos, L, [H|T]):- ((H - Pos) < 8 , (H - Pos) > -1,L is H, !); calcWestLateralLimit(Pos, L, T).
%calcular limite lateral para a esquerda
calcWestLateralLimit(Pos, L):- findall(Aux, eastLateralLimit(Aux), List), calcEastLateralLimit(Pos, L, List).
calcWestLateralLimit(Pos, L, [H|T]):- ((Pos - H) < 8 , L is H, !); calcEastLateralLimit(Pos, L, T).

%calcular limite lateral para a direita
calcWestLateralLimit(Pos, L):- findall(Aux, westLateralLimit(Aux), List), calcWestLateralLimit(Pos, L, List).
calcWestLateralLimit(Pos, L, [H|T]):- ((H - Pos) < 8 , (H - Pos) > -1,L is H, !); calcWestLateralLimit(Pos, L, T).*/

/*TESTE get value*/
t1(P,P2):- gameField(C),V is 2,getValueInside(C,V,P,P2).

getValueInside([[H,T,P]|_],H,PosValue,Points):-PosValue = T,Points = P.
getValueInside([[_,_,_]|T2],WANTED,PosValue,Points):-getValueInside(T2,WANTED,PosValue,Points).

%contar somatorio para norte
northOption(ValueInit,ValueAtTheMoment,0,_,_,f,_, ValueInit):-ValueAtTheMoment<0 ,!.

northOption(ValueInit,ValueAtTheMoment,CountVal,WantedChar,LIST,Flag, ListPos, FinalPos):-!, ValueAtTheMoment >= 0 ,(ValueAtTheMoment1 is ValueAtTheMoment - 8,getValueInside(LIST,ValueInit,PosValueInit,_),getValueInside(LIST,ValueAtTheMoment,PosValue,Points),
                                                                     (  
                                                                             (PosValueInit==PosValue,ValueAtTheMoment\=ValueInit, Flag=f,FinalPos is ValueInit,CountVal is 0);
                                                                             (LV is ValueAtTheMoment + 8,LV  ==ValueInit,PosValue ==0 ,CountVal is 0,Flag = f,!);
                                                                        (((PosValueInit\=0,ValueInit \=ValueAtTheMoment,PosValue \=  WantedChar,PosValue \=  WantedChar,PosValue\=0 ,CountVal is 0,Flag = f,!);
                                                                        (PosValueInit==0,ValueInit \=ValueAtTheMoment,PosValue \=  WantedChar,PosValue \=  WantedChar,PosValue\=0 ,CountVal is Points,FinalPos = ValueAtTheMoment,Flag = v, append([],[ValueAtTheMoment],ListPos),!)));%caso o valor nao possa ser preenchido
                                                                     ( ValueInit \=ValueAtTheMoment,PosValue \=  WantedChar,PosValue \=  WantedChar,PosValue==0 ,CountVal is Points,FinalPos = ValueAtTheMoment,Flag = v, append([],[ValueAtTheMoment],ListPos), !);%caso seja igual a 0
                                                                     ((PosValue == WantedChar;(ValueInit ==ValueAtTheMoment)),
                                                                                 northOption(ValueInit,ValueAtTheMoment1,CountVal1,WantedChar,LIST,Flag, ListPos1, FinalPos),CountVal is CountVal1+Points, append(ListPos1, [ValueAtTheMoment],ListPos));
                                                                                (ValueInit\=ValueAtTheMoment,PosValueInit==0,PosValue\=WantedChar, Flag=f,FinalPos is ValueInit,CountVal is 0)
                                                                                 )).                                                                         
%north(ValueAtTheMoment,WantedChar,Points,ListPos, FinalPos):-gameField(LIST),  (northOption(ValueAtTheMoment,ValueAtTheMoment,Points1,WantedChar,LIST,Flag, ListPos1,FinalPos)), ((Flag == v, Points = Points1, append([FinalPos],[ListPos1],ListPos));(Flag == f, ListPos = [] , Points = 0)).
north(ValueAtTheMoment,WantedChar,Points,LIST, Lp):-( northOption(ValueAtTheMoment,ValueAtTheMoment,Points1,WantedChar,LIST,Flag, ListPos1 ,FinalPos)), ((Flag == v, Points = Points1, append([FinalPos],[ListPos1],Lp));(Flag == f ,Lp = [] , Points = 0)).


 % conta para sul
southOption(ValueInit,ValueAtTheMoment,0,_,_,f,_,ValueInit):-ValueAtTheMoment>63 , !.

southOption(ValueInit,ValueAtTheMoment,CountVal,WantedChar,LIST,Flag, ListPos, FinalPos):-!, ValueAtTheMoment =< 63,(ValueAtTheMoment1 is ValueAtTheMoment + 8,getValueInside(LIST,ValueInit,PosValueInit,_),getValueInside(LIST,ValueAtTheMoment,PosValue,Points),
                                                                     ((PosValueInit==PosValue,ValueAtTheMoment\=ValueInit, Flag=f,FinalPos is ValueInit,CountVal is 0);
                                                                             (LV is ValueAtTheMoment - 8,LV  ==ValueInit,PosValue ==0 ,CountVal is 0,Flag = f,!);
                                                                                (((PosValueInit\=0,ValueInit \=ValueAtTheMoment,PosValue \=  WantedChar,PosValue \=  WantedChar,PosValue\=0 ,CountVal is 0,Flag = f,!);
                                                                                (PosValueInit==0,ValueInit \=ValueAtTheMoment,PosValue \=  WantedChar,PosValue \=  WantedChar,PosValue\=0 ,CountVal is Points,FinalPos = ValueAtTheMoment,Flag = v, append([],[ValueAtTheMoment],ListPos),!)));
                                                                     ( ValueInit \=ValueAtTheMoment,PosValue \=  WantedChar,PosValue \=  WantedChar,PosValue==0 ,CountVal is Points,FinalPos = ValueAtTheMoment,Flag = v, append([],[ValueAtTheMoment],ListPos),!);%caso seja igual a 0
                                                                     ((PosValue == WantedChar;(ValueInit ==ValueAtTheMoment)),
                                                                                 southOption(ValueInit,ValueAtTheMoment1,CountVal1,WantedChar,LIST,Flag, ListPos1, FinalPos),CountVal is CountVal1+Points,append(ListPos1, [ValueAtTheMoment],ListPos));
                                                                                 (ValueInit\=ValueAtTheMoment,PosValueInit==0,PosValue\=WantedChar, Flag=f,FinalPos is ValueInit,CountVal is 0) )).                                                                         
%south(ValueAtTheMoment,WantedChar,Points,FinalPos):-gameField(LIST),  (southOption(ValueAtTheMoment,ValueAtTheMoment,Points1,WantedChar,LIST,Flag,FinalPos1)), ((Flag == v, Points = Points1,FinalPos =FinalPos1);(Flag == f,FinalPos =ValueAtTheMoment , Points = 0)).
south(ValueAtTheMoment,WantedChar,Points,LIST, ListPos):-  (southOption(ValueAtTheMoment,ValueAtTheMoment,Points1,WantedChar,LIST,Flag, ListPos1, FinalPos)), ((Flag == v, Points = Points1, append([FinalPos],[ListPos1],ListPos));(Flag == f, ListPos = [] , Points = 0)).


%contar somatorio para este


eastOption(ValueInit,ValueAtTheMoment,CountVal,WantedChar,LIST,Flag,FinalPos,LastChar,ListPos):-!, getValueInside(LIST,ValueAtTheMoment,PosValue,Points),getValueInside(LIST,ValueInit,PosValueInit,_),calcEastLateralLimit(ValueAtTheMoment,Limite),(
                                                                                (PosValueInit==PosValue,ValueAtTheMoment\=ValueInit, Flag=f,FinalPos is ValueInit,CountVal is 0);
                                                                                (ValueInit==ValueAtTheMoment,ValueInit==Limite,Flag=f,FinalPos is ValueInit,CountVal is 0 %%Testa
                                                                                );
                                                                                (PosValueInit==0,PosValue\=0,PosValue\=WantedChar,LastChar==WantedChar, Flag=v,FinalPos is ValueAtTheMoment,CountVal is Points, append([],[ValueAtTheMoment],ListPos) );
                                                                                (ValueAtTheMoment == Limite ,(
                                                                                        (PosValue == 0,ValueAtTheMoment\= ValueInit,LastChar==WantedChar,Flag=v,FinalPos is ValueAtTheMoment,CountVal is Points, append([],[ValueAtTheMoment],ListPos));
                                                                                                                ((PosValue \= 0;LastChar\=WantedChar),Flag=f,FinalPos is ValueInit,CountVal is 0)));
                                                                                                                (ValueAtTheMoment == Limite , WantedChar \= PosValue,0 \= PosValue,Flag=f,FinalPos is ValueInit,CountVal is 0  );
                                                                                ((ValueInit == ValueAtTheMoment;PosValue == WantedChar), ValueAtTheMoment1 is ValueAtTheMoment +1 ,
                                                                                eastOption(ValueInit,ValueAtTheMoment1 ,CountVal1,WantedChar,LIST,Flag,FinalPos,PosValue,ListPos1),
                                                                                CountVal is CountVal1+Points, append(ListPos1, [ValueAtTheMoment],ListPos));
                                                                                
                                                                                ((ValueInit \= ValueAtTheMoment,PosValue\=WantedChar,PosValue\=0),Flag=f,FinalPos is ValueInit,CountVal is 0);
                                                                                ((ValueInit \= ValueAtTheMoment,LastChar==WantedChar,PosValue==0),Flag=v,FinalPos is ValueAtTheMoment,CountVal is Points, append([],[ValueAtTheMoment],ListPos);
                                                                                ((LastChar\=WantedChar,PosValue==0),Flag=f,FinalPos is ValueInit,CountVal is 0);
                                                                                (ValueInit\=ValueAtTheMoment,PosValueInit==0,PosValue\=WantedChar, Flag=f,FinalPos is ValueInit,CountVal is 0) )).                                                                         
%east(ValueAtTheMoment,WantedChar,Points,FinalPos):-gameField(LIST),  (eastOption(ValueAtTheMoment,ValueAtTheMoment,Points1,WantedChar,LIST,Flag,FinalPos1,_)),((Flag == v, Points = Points1,FinalPos =FinalPos1);(Flag == f,FinalPos =ValueAtTheMoment , Points = 0)).
east(ValueAtTheMoment,WantedChar,Points,LIST, ListPos):-  (eastOption(ValueAtTheMoment,ValueAtTheMoment,Points1,WantedChar,LIST,Flag,FinalPos,_,ListPos1)),((Flag == v, Points = Points1, append([FinalPos],[ListPos1],ListPos));(Flag == f,ListPos = []  , Points = 0)).



%contar somatorio para west
westOption(ValueInit,ValueAtTheMoment,CountVal,WantedChar,LIST,Flag,FinalPos,LastChar, ListPos):-!, getValueInside(LIST,ValueAtTheMoment,PosValue,Points),getValueInside(LIST,ValueInit,PosValueInit,_),calcWestLateralLimit(ValueAtTheMoment,Limite),(
        (PosValueInit==PosValue,ValueAtTheMoment\=ValueInit, Flag=f,FinalPos is ValueInit,CountVal is 0);
        (ValueInit==ValueAtTheMoment,ValueInit==Limite,Flag=f,FinalPos is ValueInit,CountVal is 0 %%Testa
        );
        %(ValueAtTheMoment == Limite ,ValueAtTheMoment\= ValueInit,0 \= PosValue,Flag=f,FinalPos is ValueInit,CountVal is 0  );
        (PosValue == 0,LastChar \= WantedChar, Flag=f,FinalPos is ValueInit,CountVal is 0 );
                (PosValueInit==0,PosValue\=0,PosValue\=WantedChar,LastChar==WantedChar, Flag=v,FinalPos is ValueAtTheMoment,CountVal is Points, append([],[ValueAtTheMoment],ListPos) );
        (ValueAtTheMoment == Limite ,((PosValue == 0,ValueAtTheMoment\= ValueInit,LastChar==WantedChar,Flag=v,FinalPos is ValueAtTheMoment,CountVal is Points, append([],[ValueAtTheMoment],ListPos));
                                        ((PosValue \= 0;LastChar\=WantedChar),Flag=f,FinalPos is ValueInit,CountVal is 0)));

        ((ValueInit == ValueAtTheMoment;PosValue == WantedChar), ValueAtTheMoment1 is ValueAtTheMoment -1 ,
                                                                                        westOption(ValueInit,ValueAtTheMoment1 ,CountVal1,WantedChar,LIST,Flag,FinalPos,PosValue, ListPos1),
                                                                                        CountVal is CountVal1+Points, append(ListPos1, [ValueAtTheMoment],ListPos));
                                                                                        (ValueAtTheMoment == Limite , WantedChar \= PosValue,0 \= PosValue,Flag=f,FinalPos is ValueInit,CountVal is 0  );
        ((ValueInit \= ValueAtTheMoment,PosValue\=WantedChar,PosValue\=0),Flag=f,FinalPos is ValueInit,CountVal is 0);
        ((ValueInit \= ValueAtTheMoment,LastChar==WantedChar,PosValue==0),Flag=v,FinalPos is ValueAtTheMoment,CountVal is Points, append([],[ValueAtTheMoment],ListPos);
        ((LastChar\=WantedChar,PosValue==0),Flag=f,FinalPos is ValueInit,CountVal is 0));
(ValueInit\=ValueAtTheMoment,PosValueInit==0,PosValue\=WantedChar, Flag=f,FinalPos is ValueInit,CountVal is 0)
        ).                                                                         
%west(ValueAtTheMoment,WantedChar,Points,FinalPos):-gameField(LIST),  (westOption(ValueAtTheMoment,ValueAtTheMoment,Points1,WantedChar,LIST,Flag,FinalPos1,_)),((Flag == v, Points = Points1,FinalPos =FinalPos1);(Flag == f,FinalPos =ValueAtTheMoment , Points = 0)).
west(ValueAtTheMoment,WantedChar,Points,LIST, ListPos):- (westOption(ValueAtTheMoment,ValueAtTheMoment,Points1,WantedChar,LIST,Flag,FinalPos,_, ListPos1)),((Flag == v, Points = Points1,append([FinalPos],[ListPos1],ListPos));(Flag == f,ListPos = [] , Points = 0)).

%contar somatorio para nwest
nwestOption(ValueInit,ValueAtTheMoment,0,_,_,f,ValueInit,_,_):-ValueAtTheMoment<0.

nwestOption(ValueInit,ValueAtTheMoment,CountVal,WantedChar,LIST,Flag,FinalPos,LastChar, ListPos):-!, ValueAtTheMoment >= 0 ,getValueInside(LIST,ValueInit,PosValueInit,_),getValueInside(LIST,ValueAtTheMoment,PosValue,Points),calcWestLateralLimit(ValueAtTheMoment,Limite),(
                (PosValueInit==0,PosValue\=0,PosValue\=WantedChar,LastChar==WantedChar, Flag=v,FinalPos is ValueAtTheMoment,CountVal is Points, append([],[ValueAtTheMoment],ListPos) );
                (ValueInit==ValueAtTheMoment,ValueInit==Limite,Flag=f,FinalPos is ValueInit,CountVal is 0 %%Testa
                );
                (PosValue == 0,LastChar \= WantedChar, Flag=f,FinalPos is ValueInit,CountVal is 0 );
                (Vtemp is ValueAtTheMoment + 9,Vtemp ==ValueInit,WantedChar\=PosValue, Flag=f,FinalPos is ValueInit,CountVal is 0  );
                (PosValueInit==PosValue,ValueAtTheMoment\=ValueInit, Flag=f,FinalPos is ValueInit,CountVal is 0);
        (ValueAtTheMoment == Limite ,((PosValue == 0,ValueAtTheMoment\= ValueInit,LastChar==WantedChar,Flag=v,FinalPos is ValueAtTheMoment,CountVal is Points, append([],[ValueAtTheMoment],ListPos));
                                        ((PosValue \= 0;LastChar\=WantedChar),Flag=f,FinalPos is ValueInit,CountVal is 0)));

        ((ValueInit == ValueAtTheMoment;PosValue == WantedChar), ValueAtTheMoment1 is ValueAtTheMoment -9 ,
                                                                                        nwestOption(ValueInit,ValueAtTheMoment1 ,CountVal1,WantedChar,LIST,Flag,FinalPos,PosValue, ListPos1),
                                                                                        CountVal is CountVal1+Points, append(ListPos1, [ValueAtTheMoment],ListPos));
                                                                                        (ValueAtTheMoment == Limite , WantedChar \= PosValue,0 \= PosValue,Flag=f,FinalPos is ValueInit,CountVal is 0  );        ((ValueInit \= ValueAtTheMoment,PosValue\=WantedChar,LastChar\=WantedChar),Flag=f,FinalPos is ValueInit,CountVal is 0);
        ((ValueInit \= ValueAtTheMoment,LastChar==WantedChar,PosValue==0),Flag=v,FinalPos is ValueAtTheMoment,CountVal is Points, append([],[ValueAtTheMoment],ListPos));
        ((LastChar\=WantedChar,PosValue==0),Flag=f,FinalPos is ValueInit,CountVal is 0);
        (ValueInit\=ValueAtTheMoment,PosValueInit==0,PosValue\=WantedChar, Flag=f,FinalPos is ValueInit,CountVal is 0) ).                                                                         
%nwest(ValueAtTheMoment,WantedChar,Points,FinalPos):-gameField(LIST),  (nwestOption(ValueAtTheMoment,ValueAtTheMoment,Points1,WantedChar,LIST,Flag,FinalPos1,_)),((Flag == v, Points = Points1,FinalPos =FinalPos1);(Flag == f,FinalPos =ValueAtTheMoment , Points = 0)).
nwest(ValueAtTheMoment,WantedChar,Points,LIST, ListPos):-  (nwestOption(ValueAtTheMoment,ValueAtTheMoment,Points1,WantedChar,LIST,Flag,FinalPos,_, ListPos1)),((Flag == v, Points = Points1,append([FinalPos],[ListPos1],ListPos));(Flag == f,ListPos = [], Points = 0)).


%contar somatorio para neast -<
neastOption(ValueInit,ValueAtTheMoment,0,_,_,f,ValueInit,_,_):-ValueAtTheMoment<0.
neastOption(ValueInit,ValueAtTheMoment,CountVal,WantedChar,LIST,Flag,FinalPos,LastChar, ListPos):-!, ValueAtTheMoment >= 0 ,getValueInside(LIST,ValueInit,PosValueInit,_),getValueInside(LIST,ValueAtTheMoment,PosValue,Points),calcEastLateralLimit(ValueAtTheMoment,Limite),(
        (PosValueInit==PosValue,ValueAtTheMoment\=ValueInit, Flag=f,FinalPos is ValueInit,CountVal is 0);
        (ValueInit==ValueAtTheMoment,ValueInit==Limite,Flag=f,FinalPos is ValueInit,CountVal is 0 %%Testa
        );
        (PosValue == 0,LastChar \= WantedChar, Flag=f,FinalPos is ValueInit,CountVal is 0 );
        (Vtemp is ValueAtTheMoment + 7,Vtemp ==ValueInit,WantedChar\=PosValue, Flag=f,FinalPos is ValueInit,CountVal is 0  );
                (PosValueInit==0,PosValue\=0,PosValue\=WantedChar,LastChar==WantedChar, Flag=v,FinalPos is ValueAtTheMoment,CountVal is Points, append([],[ValueAtTheMoment],ListPos) );
    (ValueAtTheMoment == Limite ,((PosValue == 0,ValueAtTheMoment\= ValueInit,LastChar==WantedChar,Flag=v,FinalPos is ValueAtTheMoment,CountVal is Points, append([],[ValueAtTheMoment],ListPos));
                                    ((PosValue \= 0;LastChar\=WantedChar),Flag=f,FinalPos is ValueInit,CountVal is 0)));

    ((ValueInit == ValueAtTheMoment;PosValue == WantedChar), ValueAtTheMoment1 is ValueAtTheMoment -7 ,
                                                                                    neastOption(ValueInit,ValueAtTheMoment1 ,CountVal1,WantedChar,LIST,Flag,FinalPos,PosValue, ListPos1),
                                                                                    CountVal is CountVal1+Points, append(ListPos1, [ValueAtTheMoment],ListPos));
                                                                                    (ValueAtTheMoment == Limite , WantedChar \= PosValue,0 \= PosValue,Flag=f,FinalPos is ValueInit,CountVal is 0  );
    ((ValueInit \= ValueAtTheMoment,PosValue\=WantedChar,LastChar\=WantedChar),Flag=f,FinalPos is ValueInit,CountVal is 0);
    ((ValueInit \= ValueAtTheMoment,LastChar==WantedChar,PosValue==0),Flag=v,FinalPos is ValueAtTheMoment,CountVal is Points, append([],[ValueAtTheMoment],ListPos));
    ((LastChar\=WantedChar,PosValue==0),Flag=f,FinalPos is ValueInit,CountVal is 0);
    (ValueInit\=ValueAtTheMoment,PosValueInit==0,PosValue\=WantedChar, Flag=f,FinalPos is ValueInit,CountVal is 0) ).                                                                         
%neast(ValueAtTheMoment,WantedChar,Points,FinalPos):-gameField(LIST),  (neastOption(ValueAtTheMoment,ValueAtTheMoment,Points1,WantedChar,LIST,Flag,FinalPos1,_)),((Flag == v, Points = Points1,FinalPos =FinalPos1);(Flag == f,FinalPos =ValueAtTheMoment , Points = 0)).
neast(ValueAtTheMoment,WantedChar,Points,LIST, ListPos):-  (neastOption(ValueAtTheMoment,ValueAtTheMoment,Points1,WantedChar,LIST,Flag,FinalPos,_, ListPos1)),((Flag == v, Points = Points1,append([FinalPos],[ListPos1],ListPos));(Flag == f,ListPos = [] , Points = 0)).


%contar somatorio para swest
swestOption(ValueInit,ValueAtTheMoment,0,_,_,f,ValueInit,_,_):-ValueAtTheMoment>63.

swestOption(ValueInit,ValueAtTheMoment,CountVal,WantedChar,LIST,Flag,FinalPos,LastChar, ListPos):-!, ValueAtTheMoment =< 63 ,getValueInside(LIST,ValueInit,PosValueInit,_),getValueInside(LIST,ValueAtTheMoment,PosValue,Points),calcWestLateralLimit(ValueAtTheMoment,Limite),(
        (PosValueInit==PosValue,ValueAtTheMoment\=ValueInit, Flag=f,FinalPos is ValueInit,CountVal is 0);
        (ValueInit==ValueAtTheMoment,ValueInit==Limite,Flag=f,FinalPos is ValueInit,CountVal is 0 %%Testa
        );
        (PosValue == 0,LastChar \= WantedChar, Flag=f,FinalPos is ValueInit,CountVal is 0 );
        (Vtemp is ValueAtTheMoment - 7,Vtemp ==ValueInit,WantedChar\=PosValue, Flag=f,FinalPos is ValueInit,CountVal is 0  );
                (PosValueInit==0,PosValue\=0,PosValue\=WantedChar,LastChar==WantedChar, Flag=v,FinalPos is ValueAtTheMoment,CountVal is Points, append([],[ValueAtTheMoment],ListPos) );
        (ValueAtTheMoment == Limite ,((PosValue == 0,ValueAtTheMoment\= ValueInit,LastChar==WantedChar,Flag=v,FinalPos is ValueAtTheMoment,CountVal is Points, append([],[ValueAtTheMoment],ListPos));
                                        ((PosValue \= 0;LastChar\=WantedChar),Flag=f,FinalPos is ValueInit,CountVal is 0)));

        ((ValueInit == ValueAtTheMoment;PosValue == WantedChar), ValueAtTheMoment1 is ValueAtTheMoment +7 ,
                                                                                        swestOption(ValueInit,ValueAtTheMoment1 ,CountVal1,WantedChar,LIST,Flag,FinalPos,PosValue, ListPos1),
                                                                                        CountVal is CountVal1+Points, append(ListPos1, [ValueAtTheMoment],ListPos));
                                                                                        (ValueAtTheMoment == Limite , WantedChar \= PosValue,0 \= PosValue,Flag=f,FinalPos is ValueInit,CountVal is 0  );
        ((ValueInit \= ValueAtTheMoment,PosValue\=WantedChar,LastChar\=WantedChar),Flag=f,FinalPos is ValueInit,CountVal is 0);
        ((ValueInit \= ValueAtTheMoment,LastChar==WantedChar,PosValue==0),Flag=v,FinalPos is ValueAtTheMoment,CountVal is Points, append([],[ValueAtTheMoment],ListPos));
((LastChar\=WantedChar,PosValue==0),Flag=f,FinalPos is ValueInit,CountVal is 0);
(ValueInit\=ValueAtTheMoment,PosValueInit==0,PosValue\=WantedChar, Flag=f,FinalPos is ValueInit,CountVal is 0)
        ).                                                                         
%swest(ValueAtTheMoment,WantedChar,Points,FinalPos):-gameField(LIST),  (swestOption(ValueAtTheMoment,ValueAtTheMoment,Points1,WantedChar,LIST,Flag,FinalPos1,_)),((Flag == v, Points = Points1,FinalPos =FinalPos1);(Flag == f,FinalPos =ValueAtTheMoment , Points = 0)).
swest(ValueAtTheMoment,WantedChar,Points,LIST, ListPos):-  (swestOption(ValueAtTheMoment,ValueAtTheMoment,Points1,WantedChar,LIST,Flag,FinalPos,_, ListPos1)),((Flag == v, Points = Points1,append([FinalPos],[ListPos1],ListPos));(Flag == f,ListPos = [] , Points = 0)).

seastOption(ValueInit,ValueAtTheMoment,0,_,_,f,ValueInit,_,_):-ValueAtTheMoment>63.
%contar somatorio para seast
seastOption(ValueInit,ValueAtTheMoment,CountVal,WantedChar,LIST,Flag,FinalPos,LastChar, ListPos):-!, ValueAtTheMoment =< 63 ,getValueInside(LIST,ValueInit,PosValueInit,_),getValueInside(LIST,ValueAtTheMoment,PosValue,Points),calcEastLateralLimit(ValueAtTheMoment,Limite),(
                (PosValueInit==PosValue, ValueAtTheMoment\=ValueInit,Flag=f,FinalPos is ValueInit,CountVal is 0);
                 (ValueInit==ValueAtTheMoment,ValueInit==Limite,Flag=f,FinalPos is ValueInit,CountVal is 0 %%Testa
                );
                (PosValue == 0,LastChar \= WantedChar, Flag=f,FinalPos is ValueInit,CountVal is 0 );
                (Vtemp is ValueAtTheMoment - 9,Vtemp ==ValueInit,WantedChar\=PosValue, Flag=f,FinalPos is ValueInit,CountVal is 0  );
                (PosValueInit==0,PosValue\=0,PosValue\=WantedChar,LastChar==WantedChar, Flag=v,FinalPos is ValueAtTheMoment,CountVal is Points, append([],[ValueAtTheMoment],ListPos) );
        (ValueAtTheMoment == Limite ,((PosValue == 0,ValueAtTheMoment\= ValueInit,LastChar==WantedChar,Flag=v,FinalPos is ValueAtTheMoment,CountVal is Points, append([],[ValueAtTheMoment],ListPos));
                                        ((PosValue \= 0;LastChar\=WantedChar),Flag=f,FinalPos is ValueInit,CountVal is 0)));

        ((ValueInit == ValueAtTheMoment;PosValue == WantedChar), ValueAtTheMoment1 is ValueAtTheMoment +9 ,
                                                                                        seastOption(ValueInit,ValueAtTheMoment1 ,CountVal1,WantedChar,LIST,Flag,FinalPos,PosValue, ListPos1),
                                                                                        CountVal is CountVal1+Points, append(ListPos1, [ValueAtTheMoment],ListPos));
                                                                                        (ValueAtTheMoment == Limite , WantedChar \= PosValue,0 \= PosValue,Flag=f,FinalPos is ValueInit,CountVal is 0  );
        ((ValueInit \= ValueAtTheMoment,PosValue\=WantedChar,LastChar\=WantedChar),Flag=f,FinalPos is ValueInit,CountVal is 0);
        ((ValueInit \= ValueAtTheMoment,LastChar==WantedChar,PosValue==0),Flag=v,FinalPos is ValueAtTheMoment,CountVal is Points, append([],[ValueAtTheMoment],ListPos));
        ((LastChar\=WantedChar,PosValue==0),Flag=f,FinalPos is ValueInit,CountVal is 0);
        (ValueInit\=ValueAtTheMoment,PosValueInit==0,PosValue\=WantedChar, Flag=f,FinalPos is ValueInit,CountVal is 0) 
        ).                                                                         
%seast(ValueAtTheMoment,WantedChar,Points,FinalPos):-gameField(LIST),   (seastOption(ValueAtTheMoment,ValueAtTheMoment,Points1,WantedChar,LIST,Flag,FinalPos,_, ListPos1)),((Flag == v, Points = Points1,append([FinalPos],[ListPos1],ListPos));(Flag == f,ListPos = [] , Points = 0)).
seast(ValueAtTheMoment,WantedChar,Points,LIST, ListPos):-  (seastOption(ValueAtTheMoment,ValueAtTheMoment,Points1,WantedChar,LIST,Flag,FinalPos,_, ListPos1)),((Flag == v, Points = Points1,append([FinalPos],[ListPos1],ListPos));(Flag == f,ListPos = [] , Points = 0)).

%north(ValueAtTheMoment,WantedChar,Points,FinalPos,LIST, ListPos):

operationManager(ValueAtTheMoment,Paychar,_,ListPos):-!,gameField(LIST),gamePiece(Paychar,WantedChar),  north(ValueAtTheMoment,WantedChar,_,LIST, ListPosN),
                                                                south(ValueAtTheMoment,WantedChar,_,LIST, ListPosS),east(ValueAtTheMoment,WantedChar,_,LIST, ListPosE),
                                                                west(ValueAtTheMoment,WantedChar,_,LIST, ListPosW),swest(ValueAtTheMoment,WantedChar,_,LIST, ListPosSW),
                                                                nwest(ValueAtTheMoment,WantedChar,_,LIST, ListPosNWE),seast(ValueAtTheMoment,WantedChar,_,LIST, ListPosSE),
                                                                neast(ValueAtTheMoment,WantedChar,_,LIST, ListPosNE),
                                                                append([ListPosN],[ListPosS],L1),append([ListPosE],L1,L2),append([ListPosW],L2,L3),
                                                                append([ListPosSW],L3,L4),append([ListPosNWE],L4,L5),append([ListPosSE],L5,L6),append([ListPosNE],L6,L7),
                                                                sort(L7,L8),( (member([],L8),delete(L8,[],  ListPos));
                                                                (\+member([],L8),ListPos = L8 )) .

operationManager(ValueAtTheMoment,Paychar,Points,ListPos,LIST):-gamePiece(Paychar,WantedChar),  north(ValueAtTheMoment,WantedChar,P0,LIST, ListPosN),
                                                                                                        south(ValueAtTheMoment,WantedChar,P1,LIST, ListPosS),east(ValueAtTheMoment,WantedChar,P2,LIST, ListPosE),
                                                                                                        west(ValueAtTheMoment,WantedChar,P3,LIST, ListPosW),swest(ValueAtTheMoment,WantedChar,P4,LIST, ListPosSW),
                                                                                                        nwest(ValueAtTheMoment,WantedChar,P5,LIST, ListPosNWE),seast(ValueAtTheMoment,WantedChar,P6,LIST, ListPosSE),
                                                                                                        neast(ValueAtTheMoment,WantedChar,P7,LIST, ListPosNE),
                                                                                                        Points is P0+P1+P2+P3+P4+P5+P6+P7,
                                                                                                        append([ListPosN],[ListPosS],L1),append([ListPosE],L1,L2),append([ListPosW],L2,L3),
                                                                                                        append([ListPosSW],L3,L4),append([ListPosNWE],L4,L5),append([ListPosSE],L5,L6),append([ListPosNE],L6,L7),
                                                                                                        sort(L7,L8),( (member([],L8),delete(L8,[],  ListPos));
                                                                                                        (\+member([],L8),ListPos = L8 )) .

getIn([H],V):-V=H.
getListToSimplify([_|H],V):- getIn(H,V).
getValuesToSimplify([H|_],V):- V is H.
simplifyList([],[],[]):-!.
simplifyList([H|T],L,L2):-simplifyList(T,L1,L21),getValuesToSimplify(H,V) ,append([V],L1,L),getListToSimplify(H,V1),append(V1,L21,L2).

getAllValuesOfPlayer([],[],_):-!.
getAllValuesOfPlayer([[H,C,_]|T],L,WC):-getAllValuesOfPlayer(T,L1,WC),((C==WC,append([H],L1,L));(C\=WC,L=L1)).


getAllPossiblePlays([],_,_,[],[],[]):-!.
getAllPossiblePlays([H|T],Paychar,LIST,ListTot,SimpList,SimpList2):-getAllPossiblePlays(T,Paychar,LIST,ListTot1,SimpList1,SimpList21),
                                                                operationManager(H,Paychar,_,ListPos,LIST),append(ListPos,ListTot1,ListTot),
                                                                simplifyList(ListPos,L,L2),append(L,SimpList1,SimpList),
                                                                append(L2,SimpList21,SimpList2) .





getAllPossiblePlays([],_,_,[],[],[],_):-!.
getAllPossiblePlays([H|T],Paychar,LIST,ListTot,SimpList,SimpList2,Points):-getAllPossiblePlays(T,Paychar,LIST,ListTot1,SimpList1,SimpList21),
                                                                operationManager(H,Paychar,Points,ListPos,LIST),append(ListPos,ListTot1,ListTot),
                                                                simplifyList(ListPos,L,L2),append(L,SimpList1,SimpList),
                                                                append(L2,SimpList21,SimpList2) .





makePlay([],Board,Board,_):-!.

makePlay([H|T],Board,NewBoard,Char):-makePlay(T,Board,NewBoard1,Char),subst([H,_,I],NewBoard1,[H,Char,I],NewBoard).


%substitui ocorrencias
subst(_,[],_,[]).           
subst(X,[X|CX],Y,[Y|CY]):-!, subst(X,CX,Y,CY).
subst(X,[N|CX],Y,[N|CY]):-subst(X,CX,Y,CY).



%convert index to 2d matrix

converterPlay([],[]):-!.
converterPlay([H|T],MatrixPlay):- converterPlay(T,MatrixPlay1),tranfer(H,VAL3D),append([VAL3D],MatrixPlay1,MatrixPlay).
