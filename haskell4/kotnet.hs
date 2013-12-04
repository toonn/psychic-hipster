-- Kotnet (ex-examenvraag)
-- Deel 1
-- oorsprong :: Ord a => [[a]] -> [a]


zekervoor :: Eq a => [[a]] -> [a]
zekervoor [] = []
zekervoor list =
    foldl1 (++) (map (zekervoor' list) list)
zekervoor' :: Eq a => [[a]] -> [a] -> [a]
zekervoor' list [] = []
zekervoor' list (x:xs)
    | nietintails list x = [x]
    | otherwise = []

nietintails :: Eq a => [[a]] -> a -> Bool
nietintails [] x = True
nietintails listoflists x =
   not (foldr1 (||) (map (elem x) (map tail listoflists)))
