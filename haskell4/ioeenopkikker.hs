import Data.List
-- IO: Een opkikkertje
-- gegeven
data Tree a = Node a (Tree a) (Tree a) | Nil
-- vraag 1
instance Show a => Show (Tree a) where
    show tree = intercalate "\n" (treeShow tree)
        where
            treeShow :: (Show a) => Tree a -> [String]
            treeShow Nil = []
            treeShow (Node val left Nil) =
                concat [[show val], treeShowH "`" left]
            treeShow (Node val left right) =
                concat [[show val], treeShowH "|" left, treeShowH "`" right]

            treeShowH :: (Show a) => String -> Tree a -> [String]
            treeShowH prefix Nil = []
            treeShowH prefix (Node val left Nil) =
                concat [[prefix ++ "-- " ++ show val],
                        treeShowH (map repl prefix ++ "   `") left]
                    where
                        repl '`' = ' '
                        repl c = c
            treeShowH prefix (Node val left right) =
                concat [[prefix ++ "-- " ++ show val],
                        treeShowH (map repl prefix ++ "   |") left,
                        treeShowH (map repl prefix ++ "   `") right]
                    where
                        repl '`' = ' '
                        repl c = c

-- gevraagd
addToTree :: Tree a -> a -> Tree a
addToTree Nil addition = Node addition Nil Nil
addToTree (Node val left right) addition =
    Node val (addToTree right addition) left
