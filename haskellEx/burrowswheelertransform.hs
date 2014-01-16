-- Haskell opgave examen Studie van Declaratieve Talen
-- implementeer Burrows-Wheeler transformatie:
--     - bwt met toevoeging startkarakter '^' en eindkarakter '|'
--     - unbwt
--     - bwt2, unbwt2 nemen start- en eindkarakter als extra argumenten

import Data.List

rotations :: String -> [String]
rotations tekst =
    [(drop i tekst) ++ (take i tekst) | i <- [1..length tekst]]

bwt_ :: String -> String
bwt_ tekst = map last $ sort $ rotations tekst
    
bwt :: String -> String
bwt tekst = bwt_  ('^':(tekst ++ "|"))

unbwt_ :: String -> [String] -> String
unbwt_ tekst matrix
    | length (head matrix) == length tekst =
        head $ filter (\x -> head x == '^') matrix
    | otherwise =
        unbwt_ tekst $ sort [(tekst!!i):(matrix!!i) | i <- [0..length matrix-1]]

unbwt :: String -> String
unbwt tekst = tail $ init $ unbwt_ tekst ["" | i <- [1..length tekst]]

bwt2 :: Char -> Char -> String -> String
bwt2 begin einde tekst = bwt_ $ begin:(tekst ++ [einde])

unbwt2_ :: Char -> Char -> String -> [String] -> String
unbwt2_ begin einde tekst matrix
    | length (head matrix) == length tekst =
        head $ filter (\x -> head x == begin && last x == einde) matrix
    | otherwise =
        unbwt2_ begin einde tekst $ sort [(tekst!!i):(matrix!!i)
                                            | i <- [0..length matrix-1]]

unbwt2 :: Char -> Char -> String -> String
unbwt2 begin einde tekst =
    tail $ init $ unbwt2_ begin einde tekst ["" | i <- [1..length tekst]]
