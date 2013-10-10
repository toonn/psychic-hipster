% Gebalanceerde bomen

gebalanceerd(leeg).
gebalanceerd(knoop(L,_,R)) :-
    balanced(knoop(L,_,R), _Depth).

balanced(leeg, 0).
balanced(knoop(L,_,R), Depth) :-
    balanced(L, Dl),
    balanced(R, Dr),
    Verschil is Dl - Dr,
    abs(Verschil) =< 1,
    Depth is max(Dl, Dr) + 1.

voeg_in(leeg, W, knoop(leeg,W,leeg)).
voeg_in(knoop(L,Wo,R), W, knoop(Ln, Wo, R)) :-
    voeg_in(L, W, Ln),
    gebalanceerd(knoop(Ln, Wo, R)).
voeg_in(knoop(L,Wo,R), W, knoop(L, Wo, Rn)) :-
    voeg_in(R, W, Rn),
    gebalanceerd(knoop(L, Wo, Rn)).
    
