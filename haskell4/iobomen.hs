import Data.List
-- IO: Bomen die gezien mogen worden
-- gegeven
data Tree a = Node a (Tree a) (Tree a) | Nil
-- gevraagd
instance Show a => Show (Tree a) where
    show tree = intercalate "\n" (treeShow tree) where
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
