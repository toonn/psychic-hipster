-- Vierkantswortel
vierkantswortel :: Double -> Double -> Double
vierkantswortel nb = vieriter nb nb

vieriter :: Double -> Double -> Double -> Double
vieriter orig nb eps
    | abs(nb*nb - orig) < eps = nb
    | otherwise = vieriter orig (nb/2 + orig/(2*nb)) eps
