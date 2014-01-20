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
