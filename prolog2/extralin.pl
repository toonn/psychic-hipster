% Lineariseer een boom tot een lijst

lineariseer(leeg, []).
lineariseer(knoop(L,W,R), Lin) :-
    lineariseer(L, LinL),
    lineariseer(R, LinR),
    append(LinL, [W|LinR], Lin).
