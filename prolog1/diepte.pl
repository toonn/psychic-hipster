% diepte.pl

diepte(leeg, 0).
diepte(knoop(L, _W, R), D) :-
    diepte(L, Dl),
    diepte(R, Dr),
    D is max(Dl, Dr) + 1.
