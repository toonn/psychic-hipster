import Data.List
-- Kotnet (ex-examenvraag)
-- Deel 1
oorsprong :: Ord a => [[a]] -> [a]
oorsprong = reconstruct []

reconstruct :: Ord a => [a] -> [[a]] -> [a]
reconstruct part [] = part
reconstruct part list =
    reconstruct (part ++ [nextel]) (verwijder nextel list)
        where nextel = head $ sort $ zekervoor list

verwijder :: Eq a => a -> [[a]] -> [[a]]
verwijder el [] = []
verwijder el list = filter (/= []) (map (filter (/= el)) list)

zekervoor :: Eq a => [[a]] -> [a]
zekervoor [] = []
zekervoor list =
    foldl1 (\list1 list2 -> if list2 == [] || elem (head list2) list1
                                then list1
                                else list1 ++ list2)
            (map (zekervoor' list) list)

zekervoor' :: Eq a => [[a]] -> [a] -> [a]
zekervoor' list [] = []
zekervoor' list (x:xs)
    | nietintails list x = [x]
    | otherwise = []

nietintails :: Eq a => [[a]] -> a -> Bool
nietintails [] x = True
nietintails listoflists x =
   not (foldr1 (||) (map (elem x) (map tail listoflists)))

-- gegeven
data GJ = Za | Zo | Ma | Di deriving (Eq,Ord,Show)

-- Deel 2
isOnoplosbaar :: Ord a => [[a]] -> Bool
isOnoplosbaar [] = False
isOnoplosbaar listoflists
    | zekervoor listoflists == [] = True
    | otherwise = isOnoplosbaar (verwijder nextel listoflists)
        where nextel = head $ sort $ zekervoor listoflists

