-- IO Recursie
-- gegeven

inc x = do
    let y = x+1
    print y
    return y

-- gevraagd
loop :: a -> (a -> IO a) -> IO ()
loop a f = f a >>= (\b -> loop b f) -- van assistent
-- eigen oplossing
-- loop a f = do
--     b <- f a
--     loop b f
