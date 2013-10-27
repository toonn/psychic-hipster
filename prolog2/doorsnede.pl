% Bereken de doorsnede van een lijst van verzamelingen

doorsnede([H|[]], H).
doorsnede([H|[TH|Tail]], Intersect) :-
    intersection(H,TH,I),
    doorsnede([I|Tail], Intersect).
