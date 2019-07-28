buildTree(PlayChar,Tree,Lvl,Board,Multiplier,Beta,LastPlay,PT):- getAllValuesOfPlayer(Board,LAP,PlayChar),  getAllPossiblePlays(LAP,PlayChar,Board,_,SimpList,_),sort(SimpList,Slsorted),
                                                                    length(SimpList, V),((V>0,treeNodes(Slsorted,PlayChar,Tree,Lvl,Board,Multiplier,Beta,LastPlay,PT));V==0,
                                                                    ( Multiplier > 0, Beta  is  -120,LastPlay is -1 );
                                                                    ( Multiplier < 0, Beta is 100,LastPlay is -1 )
                                                                                ),!.


treeNodes([],_,[],_,_,_,10000,_,_):-!.
treeNodes([H|T],PlayChar,Tree,Lvl,Board,Multiplier,Beta,LastPlay,PT):-      treeNodes(T,PlayChar,Tree1,Lvl,Board,Multiplier,BetaLargura,LastPlayLargura,PT), append([H],[],Pl), 
                                                getAllPossiblePlays(Pl,PlayChar,Board,_,_,L,P),
                                                length(L, V),
                                                ((V==0,Beta is BetaLargura, PlayChar is H);
                                                (V>0,
                                                makePlay(L,Board,NewBoard,PlayChar), NextLvl is Lvl -1, 
                                                gamePiece(PlayChar,OtherPlayer),
                                                NextMultiplier is Multiplier * -1,
                                                PointsNode is  P*Multiplier,
                                                Points is PointsNode +PT,
                                                (((NextLvl > -1 ,
                                                
                                                /*
                                                    nl,write(' board player '),write(PlayChar),nl, show(Board),nl,
                                                    nl,write('Novo board player '),write(PlayChar),nl, show(NewBoard),nl,
                                                */
                                                !,buildTree(OtherPlayer,Tree2,NextLvl,NewBoard,NextMultiplier,BetaProfundidade,_,Points),
                                               
                                                append([[H,Lvl,PlayChar,Points]],[Tree2],Tmp),append([Tmp],Tree1,Tree)
                                                
                                                ),

                                               
                                                ((BetaLargura ==10000, Beta is BetaProfundidade, LastPlay is H);
                                                (BetaLargura \= 10000,(
                                                            (Multiplier <  0,  ((BetaLargura > BetaProfundidade, Beta is  BetaProfundidade,LastPlay is H);
                                                                               (BetaLargura < BetaProfundidade, Beta is  BetaLargura,LastPlay is LastPlayLargura);
                                                                                (BetaLargura == BetaProfundidade, Beta is  BetaProfundidade,LastPlay is H))
                                                                               );
                                                            
                                                            (Multiplier > 0 ,  ((BetaLargura < BetaProfundidade, Beta is  BetaProfundidade,LastPlay is H);
                                                                                (BetaLargura > BetaProfundidade, Beta is  BetaLargura,LastPlay is LastPlayLargura);
                                                                                (BetaLargura == BetaProfundidade, Beta is  BetaProfundidade,LastPlay is H))
                                                                                )
                                                
                                            ))






                                                
                                                );(
                                                    NextLvl == -1, append([[H,Lvl,PlayChar,Points]],Tree1,Tree),
                                                    ((BetaLargura ==10000, Beta is Points, LastPlay is H);
                                                    (BetaLargura \= 10000,(
                                                                (Multiplier <  0,  ((BetaLargura > Points, Beta is  Points,LastPlay is H);
                                                                                   (BetaLargura < Points, Beta is  BetaLargura,LastPlay is LastPlayLargura);
                                                                                    (BetaLargura == Points, Beta is  Points,LastPlay is H))
                                                                                   );
                                                                
                                                                (Multiplier > 0 ,  ((BetaLargura < Points, Beta is  Points,LastPlay is H);
                                                                                    (BetaLargura > Points, Beta is  BetaLargura,LastPlay is LastPlayLargura);
                                                                                    (BetaLargura == Points, Beta is  Points,LastPlay is H))
                                                                                    ))
                                                    
                                                    
                                                ))
                                                ))))),!.
                                                
                                                

playTree:-gameField(Board),buildTree(o,Tree,1,Board,1,Beta,LastPlay,0),printTree(Tree),nl,write(Beta),nl,write(LastPlay).


printTree([]):-!.
printTree([H|T]):-write(H),nl,nl,printTree(T).

bootDecide(Board,Char,LastPlay):-!,buildTree(Char,_,2,Board,1,_,LastPlay,0).


