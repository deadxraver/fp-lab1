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

countDivs :: (Integral a) => a -> a
-- tailrec
countDivs n = countDivs' n [1 ..] 0
  where
    countDivs' n' arr' acc
      | x' * x' > n' = acc
      | x' * x' == n' = acc + 1
      | n' `mod` x' == 0 = countDivs' n' xs' $ acc + 2
      | otherwise = countDivs' n' xs' acc
      where
        (x' : xs') = arr'

-- filter + inf list again
highlyDivisibleTriangleNumbers :: (Integral a) => a -> [a]
highlyDivisibleTriangleNumbers divs =
  filter (\n -> countDivs n >= divs) triangleNumbers

main :: IO ()
main = do
  args <- getArgs
  print $ head $ highlyDivisibleTriangleNumbers $ parseArgs args
