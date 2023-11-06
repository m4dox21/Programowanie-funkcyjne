import Data.Char(digitToInt)


plec' :: Char -> Char
plec' x 
    |   x == '0' = 'k'
    |   x == '2' = 'k'
    |   x == '4' = 'k'
    |   x == '6' = 'k'
    |   x == '8' = 'k'
    |   otherwise = 'm'

doInt :: Char -> Int
doInt x
    |   x == '0' = 0
    |   x == '1' = 1
    |   x == '2' = 2
    |   x == '3' = 3
    |   x == '4' = 4
    |   x == '5' = 5
    |   x == '6' = 6
    |   x == '7' = 7
    |   x == '8' = 8
    |   x == '9' = 9



plec :: [Char] -> Char
plec (x1:x2:x3:x4:x5:x6:x7:x8:x9:x10:x11) = plec' x10



rok :: [Char] -> Int
rok (x1:x2:_) = (doInt x1)*10 + doInt x2  

miesiac :: [Char] -> Int
miesiac (_:_:x3:x4:_) = (doInt x3)*10 + doInt x4

dzien :: [Char] -> Int
dzien (_:_:_:_:x5:x6:_) = (doInt x5)*10 + doInt x6


cyfraKontrolna :: [Char] -> Int
cyfraKontrolna (x) = doInt (x !! 10)
