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

-- tailrec
sumPath :: [Integer] -> Integer
sumPath arr = sumPath' arr 0
  where
    sumPath' [] acc = acc
    sumPath' arr' acc = sumPath' xs $ acc + x
      where
        (x : xs) = arr'

-- infinite list
worstMax :: Integer -> Integer -> Integer
worstMax x y = worstMax' x y [0 ..]
  where
    worstMax' x' y' arr
      | x' == elem = y'
      | y' == elem = x'
      | otherwise = worstMax' x' y' xs
      where
        (elem : xs) = arr

-- map + fold
maxPathSumITailrec :: Node -> Integer
maxPathSumITailrec node = foldr1 worstMax (map sumPath (generatePaths node))

maxPathSumIMono :: Node -> Integer
maxPathSumIMono (MakeNode x NoPtr) = x
maxPathSumIMono node = getNumber node + max (maxPathSumIMono (getLeft node)) (maxPathSumIMono (getRight node))

main :: IO ()
main = do
  args <- getArgs
  let mode = if null args then "mono" else head args
   in if mode == "mono"
        then print $ maxPathSumIMono defaultStruct
        else
          if mode == "tail"
            then print $ maxPathSumITailrec defaultStruct
            else error $ "Unknown arg: " ++ mode
