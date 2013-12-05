-- Toon Nolten
-- r0258654
-- master computerwetenschappen

import Data.List
-- Opdracht 1: schrijf een functie "stuurbaar"

-- Geeft een lijst van alle pakketten die op dit ogenblik verstuurd kunnen
-- worden
stuurbaar :: Eq a => [(a,[a])] -> [a]
stuurbaar pakketten = filter (stuurbaarPakket pakketten)
                             (allePakketten pakketten)

-- Geeft een lijst van alle pakketten
-- (dus zonder de pakketten waarop ze wachten)
allePakketten :: [(a,[a])] -> [a]
allePakketten = map (fst)

-- Een pakket is stuurbaar als alle pakketten waar het op wacht ook wachten
-- op het pakket (triviaal voldaan voor pakketten die nergens op wachten)
-- De eerste map maakt een lijst van lijsten van pakketten waar de pakketten
-- waarop p wacht wachten
-- De tweede (buitenste) map controleert of elk van de pakketten waarop p
-- wacht ook wachten op p
-- De foldr controleert of alle pakketten waarop p wacht wachten op p
-- (foldr (&&) True ipv foldr1 (&&)) omdat de lijst na de maps leeg kan zijn,
-- bvb. wanneer p op geen enkel pakket wacht
stuurbaarPakket :: Eq a => [(a,[a])] -> a-> Bool
stuurbaarPakket pakketten p =
    foldr (&&) True (map (elem p)
                     (map (flip wachtOp pakketten)
                          (wachtOp p pakketten)))
    
-- Geeft de lijst van pakketten waar pakket p (rechtstreeks) op wacht
waarHetOpWacht :: Eq a => a -> [(a,[a])] -> [a]
waarHetOpWacht p pakketten =
    snd (head (filter (\tup -> fst tup == p) pakketten))
    -- filter geeft hier een lijst met 1 element in dus ipv head kan ook
    -- (filter ...)!!0 maar dit bied geen voordeel


-- Geeft de lijst van pakketten waar pakket p (rechtstreeks of onrechtstreeks)
-- op wacht
wachtOp :: Eq a => a -> [(a,[a])] -> [a]
wachtOp p pakketten = wachtOpHelp pakketten [] p

-- Geeft de lijst van pakketten waar pakket p op wacht
-- maar bezoekt geen pakketten die in "gezien" zitten
-- Zo onstaat er geen oneindige lus
-- Dit is een hulpfunctie voor wachtOp zodat het extra argument "gezien" niet
-- nodig is
wachtOpHelp pakketten gezien p
    | waarHetOpWacht p pakketten == [] = []
    | otherwise =
        ps ++ concat (map (wachtOpHelp pakketten (p:gezien)) ps)
            where ps = filter (not . (flip elem gezien))
                                (waarHetOpWacht p pakketten)
                  -- Houdt enkel rekening met elementen die niet gezien
                  -- (not ...) zijn

-- Opdracht 2: schrijf een functie "stuur"

-- Geeft een lijst van lijsten die een volledige volgorde oplegt voor het
-- versturen van pakketten
stuur :: Eq a => [(a,[a])] -> [[a]]
stuur [] = []
stuur pakketten = eersten:(stuur (verwijderPakketten eersten pakketten))
    where eersten = stuurbaar pakketten

-- Verwijdert alle pakketten ps uit de lijst van pakketten
verwijderPakketten :: Eq a => [a] -> [(a,[a])] -> [(a,[a])]
verwijderPakketten [] pakketten = pakketten
verwijderPakketten (x:xs) pakketten =
    verwijderPakketten xs (verwijderPakket x pakketten)

-- Verwijdert pakket p uit de lijst van pakketten
-- (dus ook uit de lijstjes van pakketten waarop gewacht wordt)
verwijderPakket :: Eq a => a -> [(a,[a])] -> [(a,[a])]
verwijderPakket p pakketten = map (verwijderWacht p)
                                  (filter (\tup -> fst tup /= p) pakketten)

-- Verwijdert pakket p uit de lijst van pakketten waarop dit pakket wacht
verwijderWacht :: Eq a => a -> (a,[a]) -> (a,[a])
verwijderWacht p (pakket,wacht) = (pakket, delete p wacht)
