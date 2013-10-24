% Feestelijke verlichting

% Knowledge Base

% Eerste voorbeeld voor check -> false
%weg(1,2,geel).
%weg(2,3,geel).
%weg(1,3,blauw).

% Tweede voorbeeld voor check -> true
%weg(1,2,geel).
%weg(2,3,blauw).
%weg(1,3,geel).

% Eigen voorbeeld voor even -> false
%weg(1,2,geel).
%weg(2,3,blauw).
%weg(2,1,blauw).

% Tweede voorbeeld voor tour(T)
weg(1,2,c).
weg(2,3,a).
weg(1,3,b).
weg(3,5,a).
weg(3,4,c).
weg(5,4,d).


% Predicaten

oneven :-
    findall(P, weg(P,_,_), Ps),
    list_to_set(Ps, Plaatsen),
    member(X, Plaatsen),
    findall(X, (weg(X,_,_) ; weg(_,X,_)), Wegen),
    length(Wegen, Aantal),
    Aantal rem 2 =\= 0.

% Geimplementeerd als "niet oneven" omdat de check voor oneven pas slaagt
% als alle mogelijkheden gefaald hebben, terwijl mijn test voor even al
% sloeg als er 1 plaats is met een even aantal wegen.
even :-
    \+ oneven.

% Zelfde idee als bij "even." Het omgekeerde is pas waar als alles faalt.
xkleurminderandere :-
    (weg(X,_,K) ; weg(_,X,K)),
    X =\= 1,
    findall(X, (weg(X,_,K) ; weg(_,X,K)), Xwegenmetkleur),
    findall(X, ((weg(X,_,L) ; weg(_,X,L)), L \== K), Xwegenzonderkleur),
    length(Xwegenmetkleur, AantalKleur),
    length(Xwegenzonderkleur, AantalZonderKleur),
    AantalKleur > AantalZonderKleur.
    
xkleurminstensxandere :-
    \+ xkleurminderandere.

check :-
    even,
    xkleurminstensxandere.

reverse([H|T],A,R) :-
    reverse(T,[H|A],R).
reverse([],A,A).
reverse(L,R) :-
    reverse(L,[],R).

atour(Tour, [LastP-LastColor|RestTour], UnVisited) :-
    LastP =:= 1,
    length(UnVisited, NbToVisit),
    NbToVisit == 0, 
    reverse([LastP-LastColor|RestTour], Tour).
atour(Tour, [LastP-LastColor|RestTour], UnVisited) :-
    member(weg(LastP,NextP,NextColor),
            UnVisited),
    NextColor \== LastColor,
    select(weg(LastP,NextP,NextColor), UnVisited, ToVisit),
    atour(Tour, [NextP-NextColor|[LastP-LastColor|RestTour]], ToVisit).
atour(Tour, [LastP-LastColor|RestTour], UnVisited) :-
    member(weg(NextP,LastP,NextColor),
            UnVisited),
    NextColor \== LastColor,
    select(weg(NextP,LastP,NextColor), UnVisited, ToVisit),
    atour(Tour, [NextP-NextColor|[LastP-LastColor|RestTour]], ToVisit).
atour(Tour) :-
    findall(weg(A,B,C), weg(A,B,C), UnUnVisited),
    list_to_set(UnUnVisited, UnVisited),
    (member(weg(NextP,1,NextColor), UnVisited),
        select(weg(NextP,1,NextColor), UnVisited, ToVisit)
     ;
     member(weg(1,NextP,NextColor), UnVisited),
        select(weg(1,NextP,NextColor), UnVisited, ToVisit)),
    atour(Tour, [NextP-NextColor|[]], ToVisit).

tours(AllTours) :-
    findall(Tour, atour(Tour), All),
    list_to_set(All, AllTours).

tour(T) :-
    check,
    tours(AllTours),
    sort(AllTours, [T|_]).
