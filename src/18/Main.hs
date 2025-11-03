import System.Environment (getArgs)

data Node = MakeNode Integer Ptrs deriving (Show)

data Ptrs = PointsTo Node Node | NoPtr deriving (Show)

lastNode :: Integer -> Node
lastNode x = MakeNode x NoPtr

getNumber :: Node -> Integer
getNumber (MakeNode x _) = x

getLeft :: Node -> Node
getLeft (MakeNode _ (PointsTo nl _)) = nl

getRight :: Node -> Node
getRight (MakeNode _ (PointsTo _ nr)) = nr

isLast :: Node -> Bool
isLast (MakeNode _ NoPtr) = True
isLast node = False

defaultStruct = MakeNode 3 $ PointsTo node21 node22
  where
    sharedNode42 = lastNode 5
    sharedNode43 = lastNode 9
    sharedNode32 = MakeNode 4 $ PointsTo sharedNode42 sharedNode43
    node41 = lastNode 8
    node44 = lastNode 3
    node31 = MakeNode 2 $ PointsTo node41 sharedNode42
    node33 = MakeNode 6 $ PointsTo sharedNode43 node44
    node21 = MakeNode 7 $ PointsTo node31 sharedNode32
    node22 = MakeNode 4 $ PointsTo sharedNode32 node33

generatePaths :: Node -> [[Integer]]
generatePaths node = generatePaths' node []
  where
    generatePaths' node' arr
      | isLast node' = [getNumber node' : arr]
      | otherwise = generatePaths' (getLeft node') (getNumber node' : arr) ++ generatePaths' (getRight node') (getNumber node' : arr)

sumPath :: [Integer] -> Integer
sumPath arr = sumPath' arr 0
  where
    sumPath' [] acc = acc
    sumPath' arr' acc = sumPath' xs $ acc + x
      where
        (x : xs) = arr'

worstMax :: Integer -> Integer -> Integer
worstMax x y = worstMax' x y [0 ..]
  where
    worstMax' x' y' arr
      | x' == elem = y'
      | y' == elem = x'
      | otherwise = worstMax' x' y' xs
      where
        (elem : xs) = arr

-- infinite list
maxPathSumIInf :: Node -> Integer
maxPathSumIInf = maxPathSumIFold

-- tailrec
maxPathSumITailrec :: Node -> Integer
maxPathSumITailrec node = maximum (map sumPath (generatePaths node))

-- rec
maxPathSumIRec :: Node -> Integer
maxPathSumIRec (MakeNode x NoPtr) = x
maxPathSumIRec node = getNumber node + max (maxPathSumIRec (getLeft node)) (maxPathSumIRec (getRight node))

-- fold
maxPathSumIFold :: Node -> Integer
maxPathSumIFold node = foldr1 worstMax (map sumPath (generatePaths node))

-- map
maxPathSumIMap :: Node -> Integer
maxPathSumIMap node = maximum (map sum (generatePaths node))

maxPathSumI :: String -> (Node -> Integer)
maxPathSumI "rec" = maxPathSumIRec
maxPathSumI "tail" = maxPathSumITailrec
maxPathSumI "fold" = maxPathSumIFold
maxPathSumI "map" = maxPathSumIMap
maxPathSumI "inf" = maxPathSumIInf
maxPathSumI arg = error $ "Unknown arg: " ++ arg

main :: IO ()
main = do
  args <- getArgs
  let mode = if null args then "rec" else head args
   in print $ maxPathSumI mode defaultStruct
