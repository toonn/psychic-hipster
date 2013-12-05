-- Pascal
pascal :: [[Int]]
pascal = pascalH [1]

pascalH :: [Int] -> [[Int]]
pascalH row = row:(pascalH (volgende row))

volgende :: [Int] -> [Int]
volgende [] = []
volgende row = 1:((zipWith (+) (tail row) row) ++ [1])
