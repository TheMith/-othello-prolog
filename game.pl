:-['options.pl'].
:-['tree.pl'].
:- set_prolog_stack(global, limit(100 000 000 000)).
:- set_prolog_stack(trail,  limit(20 000 000 000)).
:- set_prolog_stack(local,  limit(2 000 000 000)).

gameField([[0,0,120],[1,0,-20],[2,0,20],[3,0,5],[4,0,5],[5,0,20],[6,0,-20],[7,0,120],
    [8,0,-20],[9,0,-40],[10,0,-5],[11,0,-5],[12,0,-5],[13,0,-5],[14,0,-40],[15,0,-20],
    [16,0,20],[17,0,-5],[18,0,15],[19,0,3],[20,0,3],[21,0,15],[22,0,-5],[23,0,20],
    [24,0,5],[25,0,-5],[26,0,3],[27,o,3],[28,x,3],[29,0,3],[30,0,-5],[31,0,5],
    [32,0,5],[33,0,-5],[34,0,3],[35,x,3],[36,o,3],[37,0,3],[38,0,-5],[39,0,5],
    [40,0,20],[41,0,-5],[42,0,15],[43,0,3],[44,0,3],[45,0,15],[46,0,-5],[47,0,20],
    [48,0,-20],[49,0,-40],[50,0,-5],[51,0,-5],[52,0,-5],[53,0,-5],[54,0,-40],[55,0,-20],
    [56,0,120],[57,0,-20],[58,0,20],[59,0,5],[60,0,5],[61,0,20],[62,0,-20],[63,0,120]]).

tranfer(0,a1).
tranfer(1,a2).
tranfer(2,a3).
tranfer(3,a4).
tranfer(4,a5).
tranfer(5,a6).
tranfer(6,a7).
tranfer(7,a8).

tranfer(8,b1).
tranfer(9,b2).
tranfer(10,b3).
tranfer(11,b4).
tranfer(12,b5).
tranfer(13,b6).
tranfer(14,b7).
tranfer(15,b8).

tranfer(16,c1).
tranfer(17,c2).
tranfer(18,c3).
tranfer(19,c4).
tranfer(20,c5).
tranfer(21,c6).
tranfer(22,c7).
tranfer(23,c8).

tranfer(24,d1).
tranfer(25,d2).
tranfer(26,d3).
tranfer(27,d4).
tranfer(28,d5).
tranfer(29,d6).
tranfer(30,d7).
tranfer(31,d8).

tranfer(32,e1).
tranfer(33,e2).
tranfer(34,e3).
tranfer(35,e4).
tranfer(36,e5).
tranfer(37,e6).
tranfer(38,e7).
tranfer(39,e8).

tranfer(40,f1).
tranfer(41,f2).
tranfer(42,f3).
tranfer(43,f4).
tranfer(44,f5).
tranfer(45,f6).
tranfer(46,f7).
tranfer(47,f8).

tranfer(48,g1).
tranfer(49,g2).
tranfer(50,g3).
tranfer(51,g4).
tranfer(52,g5).
tranfer(53,g6).
tranfer(54,g7).
tranfer(55,g8).

tranfer(56,h1).
tranfer(57,h2).
tranfer(58,h3).
tranfer(59,h4).
tranfer(60,h5).
tranfer(61,h6).
tranfer(62,h7).
tranfer(63,h8).

/*
gameField([[0,0,120],[1,0,-20],[2,0,20],[3,0,5],[4,0,5],[5,0,20],[6,0,-20],[7,0,120],
    [8,0,-20],[9,0,-40],[10,0,-5],[11,0,-5],[12,0,-5],[13,0,-5],[14,0,-40],[15,0,-20],
    [16,0,20],[17,0,-5],[18,0,15],[19,0,3],[20,0,3],[21,0,15],[22,0,-5],[23,0,20],
    [24,o,5],[25,x,-5],[26,0,3],[27,0,3],[28,0,3],[29,0,3],[30,0,-5],[31,0,5],
    [32,o,5],[33,x,-5],[34,0,3],[35,0,3],[36,0,3],[37,0,3],[38,0,-5],[39,0,5],
    [40,0,20],[41,0,-5],[42,0,15],[43,0,3],[44,0,3],[45,0,15],[46,0,-5],[47,0,20],
    [48,0,-20],[49,0,-40],[50,0,-5],[51,0,-5],[52,0,-5],[53,0,-5],[54,0,-40],[55,0,-20],
    [56,0,120],[57,0,-20],[58,0,20],[59,0,5],[60,0,5],[61,0,20],[62,0,-20],[63,0,120]]).

*/

gamePiece(x,o). %preta
gamePiece(o,x). %branca




play:- nl,
    write('===================='), nl,
    write('=     Othello-Reversi    ='), nl,
    write('===================='), nl, nl,
    write('Rem : x starts the game'), nl,
    playerMark.



% playAskColor
% Ask the color for the human player and start the game with it.
playerMark:-
    repeat,
    nl, write('Color for human player ? (x or o)'), nl,
    read(Player), nl,
    (Player == o; Player == x;Player \= o, Player \= x,playerMark),

    gameField(EmptyBoard),
show(EmptyBoard),getAllValuesOfPlayer(EmptyBoard,LAP,Player),
          play(Player, EmptyBoard, LAP, 10,10,10).


%player plays
%Lp - lista de plays do player
%lbp - lista de plays do bot
% numero de plays disponiveis para o bot
play(Player,  Board,Lp,NLpp,NLbp,Abp) :- 

    getAllPossiblePlays(Lp,Player,Board,_,SimpList,_),
    length(SimpList,Np), 
    sort(SimpList,Slsorted),converterPlay(Slsorted,PositionsPlay),

    ((Np > 0,
    write('Escolha uma das opcoes '),write(PositionsPlay) ,nl,
    read(Pos1), nl,    
    (( \+member(Pos1, PositionsPlay),play(Player,  Board,Lp,NLpp,NLbp,Abp), Player);
        member(Pos1, PositionsPlay),tranfer(Pos,Pos1),gamePlay(Board,Player,Pos))
    );(Np == 0 , Abp == 0, ((NLpp>NLbp,nl,write('Player win !!!!! :)'),nl,!); (NLpp<NLbp,nl,write('Bot win !!!!! :('),nl,!);(NLpp==NLbp,nl,write('Draw !!!!! :$'),nl,!))
    );(Np == 0 , Abp \= 0,nl,write('=====Player widogth mooves===== :('),nl,gamePiece(Player,NextPlayChar),botPlay(Board,NextPlayChar)  )).

 

gamePlay(Board,PlayChar,Pos):-append([Pos],[],Pl),    getAllPossiblePlays(Pl,PlayChar,Board,_,_,L),makePlay(L,Board,NewBoard,PlayChar),nl,write('=====Your play ======='),nl,
show(NewBoard),gamePiece(PlayChar,NextPlayChar),nl,botPlay(NewBoard,NextPlayChar).

botplay:-gameField(Board),botPlay(Board,o).

botPlay(Board,PlayChar):- bootDecide(Board,PlayChar,LastPlay),gamePiece(PlayChar,NextPlayChar),   append([LastPlay],[],Pl), getAllPossiblePlays(Pl,PlayChar,Board,_,_,L),
                                    
                                    ((PlayChar \= -1, makePlay(L,Board,NewBoard,PlayChar));(PlayChar == -1,NewBoard = Board)),getAllPossiblePlays(Pl,PlayChar,NewBoard,_,_,L1),length(L1,Abp),
                                    getAllValuesOfPlayer(NewBoard,LAP,PlayChar),length(LAP,PlayNumber),
                                    botUserPlay(NextPlayChar,NewBoard,PlayNumber,Abp).     

%Win controller
botUserPlay(Player,Board,NbotPlay,Abp):- nl,write('========Bot-Play========'),nl,show(Board),nl,   
getAllValuesOfPlayer(Board,LAP,Player),length(LAP,Nplayer),
nl,write('Player :'),write(Nplayer),
nl,write('Bot :'),write(NbotPlay),nl,nl,write('========================'),nl,
play(Player,  Board,LAP,Nplayer,NbotPlay,Abp) .




show([X1A, X1B, X1C, X1D, X1E, X1F, X1G, X1H,
      X2A, X2B, X2C, X2D, X2E, X2F, X2G, X2H,
      X3A, X3B, X3C, X3D, X3E, X3F, X3G, X3H,
      X4A, X4B, X4C, X4D, X4E, X4F, X4G, X4H,
      X5A, X5B, X5C, X5D, X5E, X5F, X5G, X5H,
      X6A, X6B, X6C, X6D, X6E, X6F, X6G, X6H,
      X7A, X7B, X7C, X7D, X7E, X7F, X7G, X7H,
      X8A, X8B, X8C, X8D, X8E, X8F, X8G, X8H] ):- 
        write('   '), write(1),
write(' | '), write(2),
write(' | '), write(3),
write(' | '), write(4),
write(' | '), write(5),
write(' | '), write(6),
write(' | '), write(7),
write(' | '), write(8), nl,
write('  -------------------------------'), nl,

write('   '), show2(X1A),
write(' | '), show2(X1B),
write(' | '), show2(X1C),
write(' | '), show2(X1D),
write(' | '), show2(X1E),
write(' | '), show2(X1F),
write(' | '), show2(X1G),
write(' | '), show2(X1H),write('   <- a'), nl,
write('  -------------------------------'), nl,
write('   '), show2(X2A),
write(' | '), show2(X2B),
write(' | '), show2(X2C),
write(' | '), show2(X2D),
write(' | '), show2(X2E),
write(' | '), show2(X2F),
write(' | '), show2(X2G),
write(' | '), show2(X2H),write('   <- b'), nl,
write('  -------------------------------'), nl,
write('   '), show2(X3A),
write(' | '), show2(X3B),
write(' | '), show2(X3C),
write(' | '), show2(X3D),
write(' | '), show2(X3E),
write(' | '), show2(X3F),
write(' | '), show2(X3G),
write(' | '), show2(X3H), write('   <- c'),nl,
write('  -------------------------------'), nl,
write('   '), show2(X4A),
write(' | '), show2(X4B),
write(' | '), show2(X4C),
write(' | '), show2(X4D),
write(' | '), show2(X4E),
write(' | '), show2(X4F),
write(' | '), show2(X4G),
write(' | '), show2(X4H),write('   <- d'), nl,
write('  -------------------------------'), nl,
write('   '), show2(X5A),
write(' | '), show2(X5B),
write(' | '), show2(X5C),
write(' | '), show2(X5D),
write(' | '), show2(X5E),
write(' | '), show2(X5F),
write(' | '), show2(X5G),
write(' | '), show2(X5H),write('   <- e'), nl,
write('  -------------------------------'), nl,
write('   '), show2(X6A),
write(' | '), show2(X6B),
write(' | '), show2(X6C),
write(' | '), show2(X6D),
write(' | '), show2(X6E),
write(' | '), show2(X6F),
write(' | '), show2(X6G),
write(' | '), show2(X6H),write('   <- f'), nl,
write('  -------------------------------'), nl,
write('   '), show2(X7A),
write(' | '), show2(X7B),
write(' | '), show2(X7C),
write(' | '), show2(X7D),
write(' | '), show2(X7E),
write(' | '), show2(X7F),
write(' | '), show2(X7G),
write(' | '), show2(X7H),write('   <- g'), nl,
write('  -------------------------------'), nl,
write('   '), show2(X8A),
write(' | '), show2(X8B),
write(' | '), show2(X8C),
write(' | '), show2(X8D),
write(' | '), show2(X8E),
write(' | '), show2(X8F),
write(' | '), show2(X8G),
write(' | '), show2(X8H),write('   <- h'), nl.



% show2(+Term)
% Write the term to current outupt
% Replace 0 by ' '.
show2([_,X,_]) :-
    X = 0, !,
    write(' ').

show2([_,X,_]) :-
    write(X).








