% Meer lessen

doceert(berbers,bs).
doceert(berbers,iw).
doceert(demoen,ab).
doceert(demoen,cc).
doceert(holvoet,bvp).
doceert(moens,bvp).
doceert(de_schreye,ai).
doceert(bruynooghe,ai).
doceert(dedecker,socs).

volgt(tom,bs).
volgt(tom,bvp).
volgt(tom,socs).
volgt(maarten,socs).
volgt(maarten,bs).
volgt(pieter,bvp).

% zonder dubbele antwoorden

volgt_zelfde_vak(X,Y):-
    findall((A,B), (volgt(A,Vak), volgt(B,Vak), A \== B), Bag),
    list_to_set(Bag, Set),
    member((X,Y), Set).

doceert_zelfde_vak(X,Y):-
    findall((A,B), (doceert(A,Vak), doceert(B,Vak), A \== B), Bag),
    list_to_set(Bag, Set),
    member((X,Y), Set).

doceert_meerdere_vakken(X):-
    findall(A, (doceert(A,Vak1), doceert(A,Vak2), Vak1 \== Vak2), Bag),
    list_to_set(Bag, Set),
    member(X, Set).
