import Data.Char(digitToInt)


plec' :: Char -> Char
plec' x 
    | digitToInt(x) `mod` 2 == 0    = 'k'
    | otherwise                     = 'm'

plec :: [Char] -> Char
plec (x) = plec' (x !! 9)

rok' :: Int -> Int
rok' x
    | x >= 81 && x <= 92    = 1800
    | x >= 01 && x <= 12    = 1900  
    | x >= 21 && x <= 32    = 2000  
    | x >= 41 && x <= 52    = 2100  
    | x >= 61 && x <= 72    = 2200  
    | otherwise = error "bledny rok"

rok :: [Char] -> Int
rok (x) = (rok' ((digitToInt(x !! 2))*10 + digitToInt(x !! 3))) + ((digitToInt(x !! 0))*10 + (digitToInt(x !! 1)))

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

leapYear' :: Int -> Int
leapYear' x =
    if x `mod` 400 == 0 then
        1
    else
        if x `mod` 100 == 0 then
            0
        else
            if x `mod` 4 == 0 then
                1
            else
                0

leapYear :: [Char] -> Int
leapYear (x) = leapYear'(rok(x))

ileDni :: [Char] -> Int
ileDni x
    | miesiac(x) == 2 && leapYear(x) == 1                                           = 29
    | miesiac(x) == 2 && leapYear(x) == 0                                           = 28
    | miesiac(x) == 4 || miesiac(x) == 6 || miesiac(x) == 9 || miesiac(x) == 11     = 30
    | otherwise                                                                     = 31

poprawnaData :: [Char] -> Bool
poprawnaData x
    | (dzien(x) > 0 && dzien(x) <= ileDni(x) ) && (miesiac(x) >= 1 && miesiac(x) <= 12) && (rok(x) >= 1800 && rok(x) <= 2299)   = True
    | otherwise                                                                                                                 = False

poprawnyPesel :: [Char] -> Bool
poprawnyPesel x
    | length(x) == 11 && poprawnaData(x) == True && poprawnaCyfraKontrolna(x) == True      = True
    | otherwise                                                                            = False

poprawnePesele :: [[Char]] -> Bool
poprawnePesele [] = True
poprawnePesele (h:t) = 
    if poprawnyPesel h == True then
        poprawnePesele t
    else
        False

liczbyPlci' :: [[Char]] -> Int -> Int -> (Int, Int)
liczbyPlci' [] lk lm = (lk, lm)
liczbyPlci' (h:t) lk lm =
    if plec h == 'k' then
        liczbyPlci' t (lk+1) lm
    else
        liczbyPlci' t lk (lm+1)

liczbyPlci :: [[Char]] -> (Int,Int)
liczbyPlci [] = (0, 0)
liczbyPlci (x) = liczbyPlci'(x) 0 0

najmlodszy' :: [[Char]] -> (Int, Int, Int) -> (Int, Int, Int)
najmlodszy' [] (dzienZ, miesiacZ, rokZ) = (dzienZ, miesiacZ, rokZ)
najmlodszy' (h:t) (dzienZ, miesiacZ, rokZ) = 
    if rok(h) > rokZ then
        najmlodszy' (t) (dzien (h), miesiac (h), rok (h))
    else
        if rok(h) == rokZ && miesiac(h) > miesiacZ then
            najmlodszy' (t) (dzien (h), miesiac (h), rok (h))
        else
            if rok(h) == rokZ && miesiac(h) == miesiacZ && dzien(h) > dzienZ then
                najmlodszy' (t) (dzien (h), miesiac (h), rok (h))
            else
                najmlodszy' (t) (dzienZ, miesiacZ, rokZ)

najmlodszy :: [[Char]] -> (Int,Int,Int)
najmlodszy (h:t) = najmlodszy' (t) (dzien(h),miesiac(h),rok(h))

najstarszy' :: [[Char]] -> (Int, Int, Int) -> (Int, Int, Int)
najstarszy' [] (dzienZ, miesiacZ, rokZ) = (dzienZ, miesiacZ, rokZ)
najstarszy' (h:t) (dzienZ, miesiacZ, rokZ) = 
    if rok(h) < rokZ then
        najstarszy' (t) (dzien (h), miesiac (h), rok (h))
    else
        if rok(h) == rokZ && miesiac(h) < miesiacZ then
            najstarszy' (t) (dzien (h), miesiac (h), rok (h))
        else
            if rok(h) == rokZ && miesiac(h) == miesiacZ && dzien(h) < dzienZ then
                najstarszy' (t) (dzien (h), miesiac (h), rok (h))
            else
                najstarszy' (t) (dzienZ, miesiacZ, rokZ)

najstarszy :: [[Char]] -> (Int,Int,Int)
najstarszy (h:t) = najstarszy' (t) (dzien(h),miesiac(h),rok(h))
