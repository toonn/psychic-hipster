% Toon Nolten
% r0258654
% eerste master computerwetenschappen


land(polen,pot1,23.806).
land(nederland,pot1,40.860).
land(spanje,pot1,43.116).
land(oekraine,pot1,28.029).
land(duitsland,pot2,40.446).
land(italie,pot2,34.357).
land(engeland,pot2,33.563).
land(rusland,pot2,33.212).
land(kroatie,pot3,33.003).
land(griekenland,pot3,32.455).
land(portugal,pot3,31.717).
land(zweden,pot3,31.675).
land(denemarken,pot4,31.205).
land(frankrijk,pot4,30.508).
land(tsjechie,pot4,29.602).
land(ierland,pot4,28.576).


%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% Dit predicaat is geimplementeerd voor efficientie,
% vandaar een Potten_in en een Potten_out.
% Als Pot1_in...Pot4_in geldige potten zijn,
% dan is een groep waarvan elke kandidaat uit een andere
% pot komt een geldige groep.
% De potten, Pot1_out...Pot4_out, zijn de input potten,
% zonder de geselecteerde kandidaten.
groep([Kandidaat1, Kandidaat2, Kandidaat3, Kandidaat4],
        [Pot1_in, Pot2_in, Pot3_in, Pot4_in],
        [Pot1_out, Pot2_out, Pot3_out, Pot4_out]) :-
    select(Kandidaat1, Pot1_in, Pot1_out),
    select(Kandidaat2, Pot2_in, Pot2_out),
    select(Kandidaat3, Pot3_in, Pot3_out),
    select(Kandidaat4, Pot4_in, Pot4_out).
% Dit predicaat is geimplementeerd voor het testen van
% groep/3 te vergemakkelijken.
% Het maakt alle volledige potten aan en roep daarmee
% groep/3 op.
groep(Groep) :-
    findall(L1, land(L1, pot1, _), Pot1),
    findall(L2, land(L2, pot2, _), Pot2),
    findall(L3, land(L3, pot3, _), Pot3),
    findall(L4, land(L4, pot4, _), Pot4),
    groep(Groep, [Pot1, Pot2, Pot3, Pot4], _).

% Een geldige loting is een lijst van geldige groepen
% waarbij 1 land maar in 1 groep kan voorkomen.
% Ik maak gebruik van groep/3 zodat niemand in twee
% groepen kan voorkomen, als iemand geselecteerd wordt
% uit een pot, wordt hij uit die pot gehaald.
% Ook moet polen in groep 1 zitten nederland in 2...
loting([Groep1, Groep2, Groep3, Groep4]) :-
    findall(L1, land(L1, pot1, _), Pot1),
    findall(L2, land(L2, pot2, _), Pot2),
    findall(L3, land(L3, pot3, _), Pot3),
    findall(L4, land(L4, pot4, _), Pot4),
    groep(Groep1, [Pot1, Pot2, Pot3, Pot4], Potten1),
    groep(Groep2, Potten1, Potten2),
    groep(Groep3, Potten2, Potten3),
    groep(Groep4, Potten3, _),
    member(polen, Groep1),
    member(nederland, Groep2),
    member(spanje, Groep3),
    member(oekraine, Groep4).
    
    





%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% De spannendheid van een groep is de som van de
% absolute waarden van de onderlinge verschillen.
spanning_groep([K1, K2, K3, K4], Spannendheid) :-
    land(K1, _, U1),
    land(K2, _, U2),
    land(K3, _, U3),
    land(K4, _, U4),
    Spannendheid is abs(U1 - U2) + abs(U1 - U3) + abs(U1 - U4)
                    + abs(U2 - U3) + abs(U2 - U4) + abs(U3 - U4).

% De spannendheid van een loting is de som van de spannendheden
% van  de groepen.
spanning_loting([G1,G2,G3,G4], Spannendheid) :-
    spanning_groep(G1, Spannendheid1),
    spanning_groep(G2, Spannendheid2),
    spanning_groep(G3, Spannendheid3),
    spanning_groep(G4, Spannendheid4),
    Spannendheid is Spannendheid1 + Spannendheid2 + Spannendheid3
        + Spannendheid4.

%slot(L,S) :-
%    loting(L),
%    spanning_loting(L, S).
% findall([Sp, L], slot(L,Sp), Lotingen),

% De spannendste loting is de loting die eerst staat als we de lijst
% sorteren met als elementen lijsten van een spannendheid en een loting:
% [Spannendheid, Loting].
% In die lijst komt elke mogelijke loting voor.
spannendste_loting(Loting,Spannendheid) :-
    findall([Sp, L], (loting(L), spanning_loting(L, Sp)), Lotingen),
    sort(Lotingen, [[Spannendheid,Loting]|_Rest_Lotingen]).

