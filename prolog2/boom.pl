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

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

depth(leeg, -1). 
depth(dk(_,_,_,Depth), Depth).

geb(leeg).
geb(dk(L,_,R,_)) :-
    depth(L,Dl),
    depth(R,Dr),
    Verschil is Dl - Dr,
    abs(Verschil) =< 1.

voeg_in_d(leeg, W, dk(leeg, W, leeg, 0)).
voeg_in_d(dk(L,Wo,R,Depth), W, dk(Ln,Wo,R,Depth)) :-
    depth(L,Dl),
    depth(R,Dr),
    Dl < Dr,
    voeg_in_d(L,W,Ln).
voeg_in_d(dk(L,Wo,R,_), W, dk(Ln,Wo,R,DepthN)) :-
    depth(L,Dl),
    depth(R,Dr),
    Dr == Dl,
    voeg_in_d(L,W,Ln),
    depth(Ln,Dn),
    DepthN is Dn + 1.
voeg_in_d(dk(L,Wo,R,Depth), W, dk(L,Wo,Rn,Depth)) :-
    depth(L,Dl),
    depth(R,Dr),
    Dl > Dr,
    voeg_in_d(R,W,Rn).
