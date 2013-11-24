-- Prolog in Haskell

-- uit opgave
select :: [a] -> [(a,[a])]
select [] = []
select (x:xs) = (x,xs) : map (\(y,ys) -> (y,x:ys)) (select xs)

-- eigen implementatie

permute :: [a] -> [[a]]
permute [] = [[]]
permute l = [first : perm | (first, rest) <- select l, perm <- permute rest ]

no_attack :: Int -> [Int] -> Bool
no_attack = no_attack2 1

no_attack2 :: Int -> Int -> [Int] -> Bool 
no_attack2 column a [] = True
no_attack2 column a (x:xs)
    | a + column == x = False
    | a - column == x = False
    | otherwise = no_attack2 (column + 1) a xs

nqueens :: Int -> [[Int]]
nqueens size =
    [ | (a,rest) <- select [1..size], no_attack a rest 
