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

deel(_, nul, _, _) :-
    write('Wie deelt door nul is een snul :p'),
    !.
deel(X, Y, nul, X) :-
    groter_dan(Y, X).
deel(X, Y, s(D), R) :-
    min(X, Y, Z),
    deel(Z, Y, D, R).
    
