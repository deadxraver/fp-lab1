import System.Environment (getArgs)

defaultArg = 500

parseArgs :: [String] -> Int
parseArgs [] = defaultArg
parseArgs clArgs = read (head clArgs) :: Int

triangleNumber :: (Integral a) => a -> a
triangleNumber n = n * (n + 1) `div` 2

-- map + inf list
triangleNumbers :: (Integral a) => [a]
triangleNumbers = map triangleNumber [0 ..]

countDivs :: (Integral a) => a -> [a] -> a
-- rec
countDivs n arr
  | null arr = 0
  | x * x > n = 0
  | x * x == n = 1
  | n `mod` x == 0 = 2 + countDivs n xs
  | otherwise = countDivs n xs
  where
    (x : xs) = arr

-- filter + inf list again
highlyDivisibleTriangleNumbers :: (Integral a) => a -> [a]
highlyDivisibleTriangleNumbers divs =
  filter (\n -> countDivs n [1 ..] >= divs) triangleNumbers

main :: IO ()
-- test output
main = do
  args <- getArgs
  print (head (highlyDivisibleTriangleNumbers (parseArgs args)))
