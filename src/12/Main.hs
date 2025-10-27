import System.Environment (getArgs)

defaultArg = 500
parseArgs :: [String] -> Int
parseArgs clArgs = if length clArgs > 0 then read (clArgs !! 0) :: Int else defaultArg

triangleNumber :: (Integral a) => a -> a
triangleNumber n = n * (n + 1) `div` 2

-- map + inf list
triangleNumbers = map triangleNumber [0..]

countDivs :: (Integral a) => a -> [a] -> a
-- tailrec
countDivs n arr
              | arr == [] = 0
              | x * x > n = 0
              | x * x == n = 1
              | n `mod` x == 0 = 2 + countDivs n xs
              | otherwise = countDivs n xs
              where (x:xs) = arr

main :: IO ()
-- test output
main = do
      args <- getArgs
      print (parseArgs args)
