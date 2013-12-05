-- Pertwee
pertwee :: (Int -> Int -> Int) -> [Int] -> [Int]
pertwee f [] = []
pertwee f (x:(y:ys)) = (f x y):(pertwee f ys)

somprodukten :: [Int] -> Int
somprodukten = sum . pertwee (*)
