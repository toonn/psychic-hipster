-- Hors d'Oeuvres

laatste::[Int]->Int
  --laatste (x:[]) = x
  --laatste (x:xs) = laatste xs
laatste = last

herhaal::Int->Int->[Int]
  --herhaal n x = if n == 1 then [x]
  --                else x:herhaal (n-1) x
herhaal = replicate

lineariseer::[[Int]]->[Int]
  --lineariseer list = [elem | l <- list, elem <- l]
lineariseer = concat

bereik::Int->Int->[Int]
  --bereik b e = if b > e then []
  --                else b:bereik (b+1) e
bereik b e = [b..e]

verwijderVeelvouden::Int->[Int]->[Int]
  --verwijderVeelvouden el [] = []
  --verwijderVeelvouden el (x:xs) = if mod x el == 0
  --                                    then verwijderVeelvouden el xs
  --                                    else x:verwijderVeelvouden el xs
verwijderVeelvouden el = filter (\x -> mod x el /= 0)
