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
laatste([Head|Rest], Last) :-
    laatste(Rest, Last).
