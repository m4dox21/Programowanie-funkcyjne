import Data.Char(digitToInt)


plec' :: Char -> Char
plec' x 
    |   x == '0' = 'k'
    |   x == '2' = 'k'
    |   x == '4' = 'k'
    |   x == '6' = 'k'
    |   x == '8' = 'k'
    |   otherwise = 'm'

plec :: [Char] -> Char
plec (x) = plec' (x !! 9)

rok :: [Char] -> Int
rok (x) = (digitToInt(x !! 0))*10 + (digitToInt (x !! 1))

miesiac' :: Int -> Int
miesiac' x
    | x >= 81 && x <= 92   =   x - 80
    | x >= 21 && x <= 32   =   x - 20
    | x >= 41 && x <= 52   =   x - 40
    | x >= 61 && x <= 72   =   x - 60
    | otherwise = x

miesiac :: [Char] -> Int
miesiac (x) = miesiac' ((digitToInt(x !! 2))*10 + (digitToInt (x !! 3)))

dzien :: [Char] -> Int
dzien (x) = (digitToInt(x !! 4) * 10) + digitToInt(x !! 5)

cyfraKontrolna :: [Char] -> Int
cyfraKontrolna (x) = digitToInt (x !! 10)

obliczonaCyfraKontrolna' :: Int -> Int
obliczonaCyfraKontrolna' x
    | x == 0    = 0
    | otherwise = 10 - x

obliczonaCyfraKontrolna :: [Char] -> Int
obliczonaCyfraKontrolna (x) = obliczonaCyfraKontrolna' ((digitToInt(x !! 0) * 1 + digitToInt(x !! 1) * 3 + digitToInt(x !! 2) * 7 + digitToInt(x !! 3) * 9 + digitToInt(x !! 4) * 1 + digitToInt(x !! 5) * 3 + digitToInt(x !! 6) * 7 + digitToInt(x !! 7) * 9 + digitToInt(x !! 8) * 1 + digitToInt(x !! 9) * 3) `mod` 10)

poprawnaCyfraKontrolna :: [Char] -> Bool
poprawnaCyfraKontrolna x
    | obliczonaCyfraKontrolna(x) == cyfraKontrolna(x)   = True
    | otherwise                                         = False

-- poprawnaData :: [Char] -> Bool

ileDni :: [Char] -> Int 
ileDni x
    | miesiac(x) == 2                                                               = 28
    | miesiac(x) == 4 || miesiac(x) == 6 || miesiac(x) == 9 || miesiac(x) == 11     = 30
    | otherwise                                                                     = 31



-- poprawnyPesel :: [Char] -> Bool
-- poprawnePesele :: [[Char]] -> Bool
-- liczbyPlci :: [[Char]] -> (Int,Int)
-- najmlodszy :: [[Char]] -> (Int,Int,Int)
-- najstarszy :: [[Char]] -> (Int,Int,Int)
