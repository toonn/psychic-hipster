-- Vouwen

verwijderVeelvouden::Int->[Int]->[Int]
verwijderVeelvouden el = filter (\x -> mod x el /= 0)

som::[Int]->Int
som [] = 0
som (x:xs) = x + som xs

mijn_product::[Int]->Int
mijn_product [] = 1
mijn_product (x:xs) = x * mijn_product xs

vouw::(a->a->a)->a->[a]->a
vouw f x [] = x
vouw f x (y:ys) = f y (vouw f x ys)
