-- Recursiebetrekkingen

enen :: [Int]
enen = 1 : enen

machten :: [Int]
machten = 1 : map (2 * ) machten

rij :: [Int]
rij = 1 : 2 : 3 : zipWith3 (\ a3 a2 a1 -> a3*a1 + a2)
                         rij (tail rij) (tail (tail rij))

fibs :: [Int]
fibs = 1 : 1 : [fibs!!(i-1) + fibs!!(i) | i <- [1..] ] 
