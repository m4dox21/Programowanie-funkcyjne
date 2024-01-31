-- Implementacja ogólnego generatora
type Seed = (Integer, Integer)
type State = (Integer, Integer, Integer)

rInit :: Seed -> State
rInit (begin, end) = (begin, end, begin)

rStep :: State -> (State, Integer)
rStep (begin, end, current)
    | current == end     = ((begin, end, begin), mod current 10)
    | otherwise          = ((begin, end, current + 1), mod current 10)

type PRNG = Seed -> [Integer]

prng :: (seed -> state) -> (state -> (state, Integer)) -> (seed -> [Integer])
prng initFn stepFn seed = generate (initFn seed)
    where
        generate state = let (nextState, value) = stepFn state
                         in value : generate nextState

rGen :: Seed -> [Integer]
rGen = prng rInit rStep


-- Implementacja generatorów LCG i LFSR
lcgInit :: Integer -> Integer
lcgInit seed = seed

lcgStep :: Integer -> Integer -> Integer -> (Integer -> Integer) -> Integer -> (Integer, Integer)
lcgStep m a c f state = (output, nextState)
    where
        nextState = f state
        output = (a * state + c) `mod` m

lfsrInit :: Int -> Integer -> [Integer]
lfsrInit numBits seed = reverse $ toBinaryList numBits seed
    where
        toBinaryList :: Int -> Integer -> [Integer]
        toBinaryList 0 _ = []
        toBinaryList width n = toBinaryList' n width
            where
                toBinaryList' 0 0 = []
                toBinaryList' 0 remWidth = 0 : toBinaryList' 0 (remWidth - 1)
                toBinaryList' n remWidth
                    | n `mod` 2 == 1 = 1 : toBinaryList' (n `div` 2) (remWidth - 1)
                    | otherwise = 0 : toBinaryList' (n `div` 2) (remWidth - 1)

lfsrStep :: ([Integer] -> Integer) -> [Integer] -> ([Integer], Integer)
lfsrStep f state = (nextState, output)
    where
        nextBit = f state
        nextState = nextBit : init state
        output = last state

-- Konwersje pomiędzy liczbami a bitami
xor :: Integer -> Integer -> Integer
xor 0 0 = 0
xor 0 1 = 1
xor 1 0 = 1
xor 1 1 = 0
xor _ _ = error "Nieprawidlowe dane"

xorList :: [Integer] -> Integer
xorList [] = error "Pusta lista"
xorList [x] = x
xorList (x:xs) = xor x (xorList xs)

xor_11_13_14_16 :: [Integer] -> Integer
xor_11_13_14_16 bits = xorList [bits !! 10, bits !! 12, bits !! 13, bits !! 15]


bitsToIntegers :: Int -> [Integer] -> [Integer]
bitsToIntegers width bits
  | length bits `mod` width /= 0 = error "Nieprawidlowa dlugosc listy bitow"
  | otherwise = map binaryToInteger $ chunksOf width bits
  where
    binaryToInteger :: [Integer] -> Integer
    binaryToInteger = foldl (\acc x -> acc * 2 + x) 0

chunksOf :: Int -> [a] -> [[a]]
chunksOf _ [] = []
chunksOf n xs = take n xs : chunksOf n (drop n xs)

integersToBits :: Int -> [Integer] -> [Integer]
integersToBits width integers = concatMap (toBinaryList width) integers
  where
    toBinaryList :: Int -> Integer -> [Integer]
    toBinaryList w n = padWithZeros (toBinaryList' n) w
      where
        toBinaryList' 0 = [0 | _ <- [1..w]]
        toBinaryList' m = reverse (toBinaryList'' m)

        toBinaryList'' 0 = []
        toBinaryList'' m = m `mod` 2 : toBinaryList'' (m `div` 2)

        padWithZeros :: [Integer] -> Int -> [Integer]
        padWithZeros bits len
          | length bits < len = replicate (len - length bits) 0 ++ bits
          | otherwise = take len bits