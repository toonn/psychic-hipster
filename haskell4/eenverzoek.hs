-- Een verzoeknummertje
-- gegeven
inc x = do
    let y = x + 1
    print y
    return y

dec x = do
    let y = x - 1
    print y
    return y

-- gevraagd
menu :: [(String, a -> IO a)] -> a -> IO a
menu list arg = do
    choice <- menu' (-1) list
    let f = snd (list!!(choice - 1))
    f arg

menu' :: Int -> [(String, a -> IO a)] -> IO Int
menu' (-1) list = do
    putStrLn "Menu"
    putStrLn "----"
    menu' 0 list
menu' i ((item, f):items) = do
    j <- increment i
    putStr ". "
    putStrLn item
    menu' j items
menu' i [] = do
    putStr "==> "
    readLn

increment x = do
    let y = x + 1
    putStr (show y)
    return y
