-- Priemgetallen

zeef::Int->[Int]
zeef bound = sieve [2..bound] where
                    sieve [] = []
                    sieve (x:xs) = if x > rt bound then (x:xs)
                        else x:sieve (filter (\y -> mod y x /= 0) xs)

rt::Int->Int
rt = ceiling . sqrt . fromIntegral
