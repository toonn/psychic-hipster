% Priemgetallen

gen_list(UpperBound, [H|T], [H|T]) :-
    H == UpperBound.
gen_list(UpperBound, [H|T], List) :-
    H < UpperBound,
    NewH is H + 1,
    gen_list(UpperBound, [NewH|[H|T]], List).

gen_list(UpperBound, SortedList) :-
    gen_list(UpperBound, [2], List),
    sort(List, SortedList).

remove_multiples(UpperBound, List, Number, _Count, List) :-
    Number > UpperBound.
remove_multiples(UpperBound, List, Number, Count, OutList) :-
    Number =< UpperBound,
    (\+ member(Number, List), List2 = List ;
    select(Number, List, List2)),
    NextNumber is Number + Count,
    remove_multiples(UpperBound, List2, NextNumber, Count, OutList).

sieve(_UpperBound, [], PrimeList, PrimeList).
sieve(UpperBound, [H|ToSieve], PrimeList, PrimeAgg) :-
    remove_multiples(UpperBound, [H|ToSieve], H, H, SieveList),
    sieve(UpperBound, SieveList, PrimeList, [H|PrimeAgg]).
sieve(UpperBound, SieveList, PrimeList) :-
    sieve(UpperBound, SieveList, ReversePrimeList, []),
    sort(ReversePrimeList, PrimeList).

alle_priem(UpperBound, PrimeList) :-
    gen_list(UpperBound, List),
    sieve(UpperBound, List, PrimeList).
