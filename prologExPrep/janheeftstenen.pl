% Jan heeft stenen (16 januari 2013)
% ==================================
% 
% Jan speelt graag met stenen.
% Hij heeft er een hele hoop die allemaal rechthoekig zijn.
% Elke steen heeft een andere kleur.
% Jan heeft ook een speelveld waarop hij de stenen kan leggen.
% Hij kan stenen op elkaar leggen.
% Niet alle stenen zijn evengroot.
% Zo kunnen we een speelveld voorstellen als volgt: 
%   [[.,c,c,.],
%    [a,c,c,a],
%    [a,c,c,a]]
% 
%   waarbij a en c kleuren zijn, en "." de afwezigheid van kleur aangeeft.
% 
% Vraag 1:
%   Bepaal de posities van alle stenen als volgt (voor het voorbeeld):
%     [a-rhk(1,4,2,3),c-rhk(2,3,1,4)]
%   waarbij een de waarden corresponderen met respectievelijk
%   Index van Leftmost occurence,Rightmost occurence, lowesttopoccurence,
%   highestbottomoccurence.
%   (het assenstelsen van het veld is dus een standaard 2 dimensionaal
%       x,y-vlak waarbij de y-as ondersteboven staat).
% 
% Vraag 2:
%   Bepaal de volgorde waarin de rechthoeken gelegd zijn.
%   Indien er meerdere mogelijkheden zijn, geef dan gesorteerd met @</2.

% Oplossing Vraag 1
colors(Field, Colors) :-
    setof(Col,
        Row^(member(Row, Field), member(Col, Row), Col \== '.'),
        Colors).


leftbound(Color, [Row|_RestField], Left) :-
    nth1(Left, Row, Color), !.
    % Niet nodig vanwege red cut.
    % setof(Index, nth1(Index, Row, Color), Indices),
    % nth1(1, Indices, Left).
leftbound(Color, [_Row|RestField], Left) :-
    % \+ member(Color, Row), % Niet nodig vanwege red cut hierboven.
    leftbound(Color, RestField, Left).

rightbound(Color, [Row|_RestField], Right) :-
    % Length - Right, lineair dus geen winst?
    % reverse(Row, Wor), nth1(Right, Wor, Color), !.
    setof(Index, nth1(Index, Row, Color), Indices),
    last(Indices, Right), !.
rightbound(Color, [_Row|RestField], Right) :-
    rightbound(Color, RestField, Right).

upperbound_(Color, [Row|_RestField], Upper, UB) :-
    member(Color, Row),
    Upper is UB, !.
upperbound_(Color, [_Row|RestField], Upper, UB) :-
    NUB is UB + 1,
    upperbound_(Color, RestField, Upper, NUB).
upperbound(Color, Field, Upper) :-
    upperbound_(Color, Field, Upper, 1). 

lowerbound_(Color, [Row|_RestField], Lower, LB) :-
    member(Color, Row),
    Lower is LB, !.
lowerbound_(Color, [_Row|RestField], Lower, LB) :-
    NLB is LB - 1,
    lowerbound_(Color, RestField, Lower, NLB).
lowerbound(Color, Field, Lower) :-
    length(Field, LB),
    reverse(Field, ReverseField),
    lowerbound_(Color, ReverseField, Lower, LB).

bounds(Color, Field, rhk(Left, Right, Upper, Lower)) :-
    leftbound(Color, Field, Left),
    rightbound(Color, Field, Right),
    upperbound(Color, Field, Upper),
    lowerbound(Color, Field, Lower).

allpositions(Field, AllPositions) :-
    colors(Field, Colors),
    findall(Color-Bounds,
            (member(Color, Colors),
            bounds(Color, Field, Bounds)),
            AllPositions).

% Oplossing Vraag 2
cover(rhk(Left, Right, Upper, Lower), Cover) :-
    numlist(Upper, Lower, Rows),
    numlist(Left, Right, Columns),
    findall((Row,Column),
            (member(Row,Rows), member(Column,Columns)),
            Cover).
overlap(Acolor, Bcolor, Field, Overlap) :-
    bounds(Acolor, Field, Abounds),
    bounds(Bcolor, Field, Bbounds),
    cover(Abounds, Acover),
    cover(Bbounds, Bcover),
    findall(Position,
            (member(Position, Acover), member(Position, Bcover)),
            Overlap).

higher(Acolor, Bcolor, Field, HigherColor) :-
    overlap(Acolor, Bcolor, Field, Overlap),
    member((RowIndex,ColumnIndex), Overlap), !,
    nth1(RowIndex, Field, Row),
    nth1(ColumnIndex, Row, HigherColor).
higher(Acolor, Bcolor, _, Acolor) :-
    Acolor @< Bcolor.
higher(Acolor, Bcolor, _, Bcolor) :-
    Bcolor @< Acolor.
