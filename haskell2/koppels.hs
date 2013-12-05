-- Oefening 2
koppels :: [a] -> [(a,a)]
--koppels [] = []
koppels list = concat $ map (tuplize even) odd
    where (odd,even) = splitEvenOdd list

tuplize :: [b] -> a -> [(a,b)]
--tuplize [] el = [()]
tuplize list el = [(el, secondel) | secondel <- list]

splitEvenOdd :: [a] -> ([a],[a])
splitEvenOdd [] = ([],[])
splitEvenOdd list = ((head list):first, second)
    where (second,first) = splitEvenOdd $ tail list
