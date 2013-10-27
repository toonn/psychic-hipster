% Modulo

mod(X,Y,X) :-
    X < Y.
mod(X,Y,Z) :-
    X >= Y,
    Xn is X - Y,
    mod(Xn, Y, Z).
