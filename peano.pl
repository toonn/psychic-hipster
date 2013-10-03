% peano.pl

peano_plus(nul, X, X).
peano_plus(s(X), Y, s(Z)) :-
    peano_plus(X, Y, Z).

min(X, nul, X).
min(s(X), s(Y), Z) :-
    min(X, Y, Z).

groter_dan(s(_), nul).
groter_dan(s(X), s(Y)) :-
    groter_dan(X, Y).

maximum(X, Y, X) :-
    groter_dan(X, Y).
maximum(X, Y, Y) :-
    groter_dan(Y, X).

alt_min(X, Y, Z) :-
    peano_plus(Y, Z, X).

