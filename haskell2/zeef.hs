-- Oefening 1
zeef :: [(a,b)] -> (a -> b -> Bool) -> ([a],[b])
zeef [] f = ([],[])
zeef list f = (map fst tups, map snd tups)
    where tups = filter (revpre f) list

revpre :: (a -> b -> Bool) -> (a,b) -> Bool
revpre f (a, b) = not $ f a b
