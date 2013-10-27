% Stracciatella meta-vertolker

% ?Gezien? in de les
vertolk((C1,C2)) :-
    !,
    vertolk(C1),
    vertolk(C2).

vertolk(true) :-
    !.

vertolk(Head) :-
    clause(Head,Body),
    vertolk(Body).

% Eigen uitbreiding voor mod

vertolk(`is`(X,Y)) :-
    X is Y.

vertolk(`<`(X,Y)) :-
    X < Y.

vertolk(`>=`(X,Y)) :-
    X >= Y.
