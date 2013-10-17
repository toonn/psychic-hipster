% Expressief

eval(int(I), _, I).

eval(var(A), [paar(A,X)|_], X).
eval(var(A), [_|[paar(A,X)|_]], X).
eval(var(A), [[_|_]|[paar(A,X)|_]], X).

eval(plus(E1,E2), VarList, Waarde) :-
    eval(E1, VarList, W1),
    eval(E2, VarList, W2),
    Waarde is W1 + W2.

eval(maal(E1,E2), VarList, Waarde) :-
    eval(E1, VarList, W1),
    eval(E2, VarList, W2),
    Waarde is W1 * W2.

eval(macht(E1,E2), VarList, Waarde) :-
    eval(E1, VarList, W1),
    eval(E2, VarList, W2),
    Waarde is W1**W2.

eval(min(E), VarList, Waarde) :-
    eval(E, VarList, W),
    Waarde is -W.
