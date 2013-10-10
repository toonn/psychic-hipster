% Drillen op lijsten

%listlength([],0).
%listlength([_|Rest],Length) :-
%    listlength(Rest,LengthRest),
%    Length is LengthRest+1.

listlength([], Acc, Acc).
listlength([_|Rest], Acc, Length) :-
    AccNew is Acc + 1,
    listlength(Rest, AccNew, Length).

laatste([Last], Last).
laatste([_Head|Rest], Last) :-
    laatste(Rest, Last).

naast([A|[B|_Rest]], A, B).
naast([A|[B|_Rest]], B, A).
naast([_X|Y], A, B) :-
    naast(Y, A, B).
