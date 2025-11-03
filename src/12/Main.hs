import System.Environment (getArgs)

defaultArg = 500

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

countDivsRec :: (Integral a) => a -> a
-- rec
countDivsRec n = countDivsRec' n [1 ..]
  where
    countDivsRec' n' arr
      | x * x > n' = 0
      | x * x == n' = 1
      | n' `mod` x == 0 = 2 + countDivsRec' n' xs
      | otherwise = countDivsRec' n' xs
      where
        (x : xs) = arr

-- filter + inf list again
highlyDivisibleTriangleNumbers :: (Integral a) => a -> [a]
highlyDivisibleTriangleNumbers divs =
  filter (\n -> countDivs n >= divs) triangleNumbers

highlyDivisibleTriangleNumberRec :: (Integral a) => a -> a
highlyDivisibleTriangleNumberRec divs = head $ filter (\x -> countDivsRec x >= divs) triangleNumbers

highlyDivisibleTriangleNumberTail :: (Integral a) => a -> a
highlyDivisibleTriangleNumberTail divs = head $ filter (\x -> countDivs x >= divs) triangleNumbers

highlyDivisibleTriangleNumberModule :: (Integral a) => a -> a
highlyDivisibleTriangleNumberModule divs = head $ filter (\x -> countDivs x >= divs) triangleNumbers

highlyDivisibleTriangleNumberMap :: (Integral a) => a -> a
highlyDivisibleTriangleNumberMap = highlyDivisibleTriangleNumberTail

highlyDivisibleTriangleNumberInf :: (Integral a) => a -> a
highlyDivisibleTriangleNumberInf = highlyDivisibleTriangleNumberTail

highlyDivisibleTriangleNumber :: (Integral a) => String -> a -> a
highlyDivisibleTriangleNumber "rec" = highlyDivisibleTriangleNumberRec
highlyDivisibleTriangleNumber "tail" = highlyDivisibleTriangleNumberTail
highlyDivisibleTriangleNumber "module" = highlyDivisibleTriangleNumberModule
highlyDivisibleTriangleNumber "map" = highlyDivisibleTriangleNumberMap
highlyDivisibleTriangleNumber "inf" = highlyDivisibleTriangleNumberInf
highlyDivisibleTriangleNumber arg = error $ "Unknown arg: " ++ arg

main :: IO ()
main = do
  args <- getArgs
  let arg = if null args then "rec" else head args
   in print $ highlyDivisibleTriangleNumber arg defaultArg
