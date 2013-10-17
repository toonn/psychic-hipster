% sibling.pl

vader(anton, bart).
vader(anton, daan).
vader(anton, elisa).
vader(fabian, anton).

moeder(celine, bart).
moeder(celine, daan).
moeder(celine, gerda).
moeder(gerda, hendrik).

sibling(X, Y) :-
    vader(Z, X), vader(Z, Y), moeder(M, X), moeder(M, Y), X \== Y.
