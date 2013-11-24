-- Hamming-getallen

samenvoegen :: Ord a => [a]->[a]->[a]
samenvoegen l [] = l
samenvoegen [] l = l
samenvoegen (x:xs) (y:ys)
    | x < y = x : samenvoegen xs (y:ys)
    | x > y = y : samenvoegen (x:xs) ys
    | otherwise = x : samenvoegen xs ys

hamming :: [Int]
hamming = 1 :
    samenvoegen
        (samenvoegen (map (2*) hamming)
                    (map (3*) hamming))
        (map (5*) hamming)

-- recurse.hs

machten :: [Int]
machten = 1 : map (2 * ) machten

rij :: [Int]
rij = 1 : 2 : 3 : zipWith3 (\ a3 a2 a1 -> a3*a1 + a2)
                         rij (tail rij) (tail (tail rij))
