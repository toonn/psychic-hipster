% Rij van Fibonacci

fib(0, 0).
fib(1, 1).
fib(N, F) :-
    N > 1,
    Nn is N - 1, Nnn is N - 2,
    fib(Nn, A),
    fib(Nnn, B),
    F is A + B.

onfib(0,0).
onfib(1,1).
onfib(N, F) :-
    Nn is N - 1,
    onfib(Nn, F1, F2),
    F is F1 + F2.

onfib(0,0,0).
onfib(1,0,1).
onfib(N, F1, F2) :-
    N > 1,
    Nn is N - 1,
    onfib(Nn, F1prev, F1),
    F2 is F1 + F1prev.
