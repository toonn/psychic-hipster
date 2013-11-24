-- Bomen

data IntTree = Leeg | Node IntTree Integer IntTree

instance Eq IntTree where
    xTree == yTree = xTree `intTreeEq` yTree

intTreeEq :: IntTree -> IntTree -> Bool
intTreeEq (Node xlTree xval xrTree) (Node ylTree yval yrTree) =
    xval == yval && intTreeEq xlTree ylTree && intTreeEq xrTree yrTree

mapIntTree :: (Integer -> Integer) -> IntTree -> IntTree
mapIntTree f Leeg = Leeg
mapIntTree f Node lTree val rTree =
    Node (mapIntTree f lTree) (f val) (mapIntTree f rTree)

intTree2List :: IntTree -> [Integer]
intTree2List Leeg = []
intTree2List (Node lTree val rTree) =
    (intTree2List lTree) ++ $ val : (intTree2List rTree)

data Tree a = Leeg | Node Tree a Tree

instance Eq Tree where
    xTree == yTree = xTree `treeEq` yTree

--treeEq :: Tree a -> Tree a -> Bool
--treeEq (Node xlTree xval xrTree) (Node ylTree yval yrTree) =
--    xval == yval && treeEq xlTree ylTree && treeEq xrTree yrTree

-- Bomen met verschillende vorm kunnen ook gelijk zijn
-- Minder efficient met sorteren
--treeEq :: Ord a => Tree a -> Tree a -> Bool
--treeEq xTree yTree =
--    sort (tree2List xTree) == sort (tree2List yTree)
-- Efficient met list difference, Ord a is niet meer nodig
treeEq :: Tree a -> Tree a -> Bool
treeEq xTree yTree =
    length (tree2List xTree) \\ (tree2List yTree) == 0
    && length (tree2List yTree) \\ (tree2List xTree) == 0

mapTree :: (a -> b) -> Tree a -> Tree b
mapTree f Leeg = Leeg
mapTree f (Node lTree val rTree) =
    Node (mapTree f lTree) (f val) (mapTree f rTree)

tree2List :: Tree a -> [a]
tree2List Leeg = Leeg
tree2List (Node lTree val rTree) =
    (tree2List lTree) ++ $ val : (tree2List)

-- gegeven code
vouw :: (a -> b -> b) -> b -> [a] -> b
vouw f ne [] = ne
vouw f ne (x:xs) = f x (vouw f ne xs)
-- gegeven code
vouwTree :: (a -> b -> b) -> b -> Tree a -> b
vouwTree f val tree = vouw f val (tree2List tree)

tree2ListB :: Tree a -> [a]
tree2ListB Leeg = []
tree2ListB (Node lTree val rTree) =
    val : mergeTreeLists (tree2ListB lTree) (tree2ListB rTree)

mergeTreeLists :: [a] -> [a] -> [a]
mergeTreeLists = mergeTreeLists' 1

mergeTreeLists' :: Integer [a] -> [a] -> [a]
mergeTreeLists' nb [] rTreeList = rTreeList
mergeTreeLists' nb lTreeList rTreeList =
    (take nb lTreeList)
    ++ (take nb rTreeList)
    ++ (mergeTreeLists' (2*nb) (drop nb lTreeList) (drop nb rTreeList)
