% bool.pl

eval(waar, waar).
eval(onwaar, onwaar).
eval(not(X), waar) :-
    eval(X, onwaar).
eval(not(X), onwaar) :-
    eval(X, waar).
eval(and(X, Y), waar) :-
    eval(X, waar),
    eval(Y, waar).
eval(and(X, Y), onwaar) :-
    eval(X, onwaar);
    eval(Y, onwaar).
eval(or(X, Y), waar) :-
    eval(X, waar);
    eval(Y, waar).
eval(or(X, Y), onwaar) :-
    eval(X, onwaar),
    eval(Y, onwaar).

