-- |My Demo Module
module Lib
    ( someFunc
    , isPrime
    , isPrimes
    , permutations
    , remove
    ) where

import Control.Parallel
import Control.Parallel.Strategies

-- |Very basic print function (alias)
someFunc :: IO ()
someFunc = putStrLn "someFunc"

-- |Checks if the argument is prime
isPrime :: Integer -> Bool
isPrime 0 = False
isPrime 1 = False
isPrime 2 = True
isPrime x = 2 ^ x `mod` x == 2

-- |Checks (in parallel) if the elements in the array are prime
isPrimesPar :: [Integer] -> [Bool]
isPrimesPar =
  parMap rseq isPrime

-- |Checks if the elements in the array are prime
isPrimes :: [Integer] -> [Bool]
isPrimes =
  map isPrime

-- |Calculates the factorial of the argument
fact :: (Num b, Enum b) => b -> b
fact n = foldr (*) 1 [1..n]

-- |Calculates the factorial of the argument
fact' :: Integer -> Integer
fact' n = product [1..n]

-- |Deletes a value from the list
remove :: (Eq a) => [a] -> a -> [a]
remove [] _ = []
remove (x:xs) i
  | x == i = remove xs i 
  | otherwise = x : remove xs i

permutations :: Eq a => [a] -> [[a]]
permutations [] = [[]]
permutations as = do a <- as
                     let l = remove as a
                     ls <- permutations l
                     return $ a : ls
