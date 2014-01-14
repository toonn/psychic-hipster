-- Winkelen (01.09.2010)
-- =====================
-- 
-- Jan en zijn vrouw Ann gaan winkelen, maar Jan doet dat niet graag.
-- Jan mag daarom het pad kiezen.
-- Hij zoekt het snelste pad.
-- vb.
-- 
--   _____10__________20__________30__________10_____
--               |           |           |
--               3           2           3
--   ______5_____|____30_____|____15_____|_____8_____
-- 
-- Maak een functie helpJan dat als argument de informatie krijgt van
-- de straat.
-- In het geval van het voorbeeld is die informatie:
--   [Section 10 5 3, Section 20 30 2, Section 30 15 3, Section 10 8 0]
-- Het antwoord hiervan moet zijn:
--   [(Z,5),(B,3),(N,20),(B,2),(Z,15),(Z,8),(B,0)]
--   waar N, Z en B respectievelijk staan voor Noordkant, Zuidkant en Brug.
--   Merk op dat het niet uitmaakt of je aan de zuidkant of de noordkant
--   begint of eindigt.
--   De laatste term (B,0) mag eventueel.
--   worden weggelaten.
-- Schrijf de nodige types.
-- 
-- Deze opgave is letterlijk overgenomen van learnyouahaskell.

-- Oplossing
data Section = Section Integer Integer Integer

toN :: Section -> ((Integer, [(Char, Integer)]), (Integer, [(Char, Integer)]))
toN (Section nInt zInt bInt) =
    ((nInt, [('N', nInt)]), (zInt + bInt, [('Z', zInt), ('B', bInt)]))
toZ :: Section -> ((Integer, [(Char, Integer)]), (Integer, [(Char, Integer)]))
toZ (Section nInt zInt bInt) =
    ((nInt + bInt, [('N', nInt), ('B', bInt)]), (zInt, [('Z', zInt)]))

minPath :: (Integer, [(Char, Integer)]) ->
                (Integer, [(Char, Integer)]) ->
                (Integer, [(Char, Integer)]) ->
                (Integer, [(Char, Integer)]) ->
                (Integer, [(Char, Integer)])
minPath (nD, nP) (zD, zP) (ntoD, ntop) (ztoD, ztop)
    | nD + ntoD <= zD + ztoD = (nD + ntoD, nP ++ ntop)
    | otherwise = (zD + ztoD, zP ++ ztop)

shortestTrip :: (Integer, [(Char, Integer)]) ->  (Integer, [(Char, Integer)]) -> [Section] -> [(Char, Integer)]
shortestTrip (nD, nP) (zD, zP) []
    | nD < zD = nP
    | zD < nD = zP
    | length nP <= length zP = nP
    | otherwise = zP
shortestTrip ntuple ztuple (section:sections) =
    shortestTrip
        (minPath ntuple ztuple nntuple zntuple)
        (minPath ntuple ztuple nztuple zztuple)
        sections
    where
        (nntuple, zntuple) = toN section
        (nztuple, zztuple) = toZ section


helpJan :: [Section] -> [(Char, Integer)]
helpJan = shortestTrip (0, []) (0,[])
