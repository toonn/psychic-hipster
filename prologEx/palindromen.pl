% deel 1
count([], _, 0).
count([Glyph|List], Glyph, Count) :-
    !,
    count(List, Glyph, TailCount),
    Count is 1 + TailCount.
count([_|List], Glyph, Count) :-
    count(List, Glyph, Count).

kost_([], Acc, Acc).
kost_([Count-_|Rest], Acc, Kost) :-
    NewAcc is Count + Acc,
    kost_(Rest, NewAcc, Kost).
kost([Count-_|Rest], Kost) :-
    kost_(Rest, Count, Kost).

sequentie(_, 0, []) :- !.
sequentie(Glyph, Len, [Glyph|Palindroom]) :-
    NewLen is Len - 1,
    sequentie(Glyph, NewLen, Palindroom).

algelijk([],0,[]).
algelijk([X],0,[X]).
algelijk(Woord, Kost, Palindroom) :-
    length(Woord, Len),
    setof(Count-Letter,
            (member(Letter, Woord), count(Woord, Letter, Count)),
            Letters),
    sort(Letters, Sorted),
    reverse(Sorted, [_-PalLetter|Reverse]),
    kost(Reverse, Kost),
    sequentie(PalLetter, Len, Palindroom).
    
% deel 2    
groep_pos(Kars, PosGroepen) :-
    length(Kars, Len),
    findall([Pos-Kar|Groep],
            (nth1(Index, Kars, Pos-Kar),
            Index =< ceiling(Len/2),
            findall(P-K,
                    (member(P-K, Kars),
                    Pos + P =:= Len + 1,
                    Pos < P),
                    Groep)),
            PosGroepen).

groep_kar([], []).
groep_kar([Groep|Groepen], PalGroepen) :-
    setof(G,
            P1^P2^Kar^(member(G, Groepen),
            member(P1-Kar, Groep),
            member(P2-Kar, G)),
            PGDeel),
    !,
    flatten([Groep|PGDeel], PalGroepDeel),
    findall(G,
            (member(G, Groepen),
            \+ (member(G, PGDeel))),
            RestGroepen),
    groep_kar([PalGroepDeel|RestGroepen], PalGroepen).
groep_kar([Groep|Groepen], [Groep|PalGroepen]) :-
    groep_kar(Groepen, PalGroepen).

groepen(Kars, PalGroepen) :-
    groep_pos(Kars, PosGroepen),
    groep_kar(PosGroepen, PalGroepen).

splits(Paren, Indices, Kars) :-
    sort(Paren, Sorted),
    pairs_keys_values(Sorted, Indices, Kars).

onsplits(Paren, Indices, Kars) :-
    pairs_keys_values(Paren, Indices, Kars).

combineer(Delen, Geheel) :-
    pairs_keys_values(Delen, Pals, _),
    flatten(Pals, FPals),
    sort(FPals, Sorted),
    pairs_keys_values(Sorted, _,Geheel).

som([], Acc, Acc).
som([X|R], Acc, Kost) :-
    NAcc is Acc + X,
    som(R, NAcc, Kost).
kosten_som(Delen, Kost) :-
    pairs_keys_values(Delen, _, Kosten),
    som(Kosten, 0, Kost).

palindroom(Woord, Kost, Palindroom) :-
    findall(Pos-Kar, nth1(Pos, Woord, Kar), Kars),
    groepen(Kars, PalGroepen),
    findall(PalGroep-Kost,
            (member(X, PalGroepen),
            splits(X, Indices, Woord),
            algelijk(Woord, Kost, Pal),
            onsplits(PalGroep, Indices, Pal)),
            PalDelen),
    kosten_som(PalDelen, Kost),
    combineer(PalDelen, Palindroom).
