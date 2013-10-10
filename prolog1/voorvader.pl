% voorvader.pl

vader(anton, bart).
vader(anton, daan).
vader(anton, elisa).
vader(fabian, anton).

moeder(celine, bart).
moeder(celine, daan).
moeder(celine, gerda).
moeder(gerda, hendrik).

voorvader(X, Y) :-
    vader(Z, Y),
    voorvader(X, Z).
voorvader(X, Y) :-
    vader(X,Y).
