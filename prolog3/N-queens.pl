% N-koninginnenprobleem

%cover(Qklein, Qklein).
%cover(Qklein, Qgroot):-
%    Qb is Qa - 1,
%    Qb is Qa + 1.
%
%queens(N, L) :-
%    between(1, Q1, N),
%    between(1, Q2, N), Q2 \== Q1, Q2 \== Q1 + 1, Q2 \== Q1 - 1,
%
%
%queens(N, L) :-
%    between(1, Q1, N),
%    between(1, Q2, N), \+ cover(Q1, Q2),
%    between(1, Q3, N), \+ cover(Q1, Q2, Q3),

check_diag(_, [], _).
check_diag(H, [Th|Tail], D) :-
    Hrising is H + D,
    Hfalling is H - D,
    Hrising \== Th,
    Hfalling \== Th,
    Dn is D + 1,
    check_diag(H, Tail, Dn).

check([]).
check([H|RestSol]) :-
    check_diag(H, RestSol, 1),
    check(RestSol).

queens(N, L) :-
    findall(Q, between(1, N, Q), Bag),
    permutation(Bag, L),
    check(L).
            
