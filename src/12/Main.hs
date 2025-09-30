triangleNumber :: (Integral a) => a -> a
triangleNumber n = tn n 0
                    where
                      tn nm i
                        | nm == i = nm
                        | nm < i = (-1)
                        | otherwise = i + tn nm (i + 1)

countDivs :: (Integral a) => a -> [a] -> a
countDivs n arr
              | arr == [] = 0
              | x * x > n = 0
              | x * x == n = 1
              | n `mod` x == 0 = 2 + countDivs n xs
              | otherwise = countDivs n xs
              where (x:xs) = arr

