% Graaf

knoop(a).
knoop(b).
knoop(c).
knoop(d).
knoop(e).

boog(a,b).
boog(b,c).
boog(c,d).
boog(b,d).

buur(A, B) :-
    boog(A, B)
    ;
    boog(B, A).

pad(A, B) :-
    padI(A, B, [A]).

padI(A, B, Bezocht) :-
    buur(A, B),
    \+ member(B, Bezocht)
    ;
    buur(A, C),
    \+ member(C, Bezocht),
    padI(C, B, [C|Bezocht]).
