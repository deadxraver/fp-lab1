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

maxPathSumIMono :: Node -> Integer
maxPathSumIMono (MakeNode x NoPtr) = x
maxPathSumIMono node = getNumber node + max (maxPathSumIMono (getLeft node)) (maxPathSumIMono (getRight node))

main :: IO ()
main = do
  args <- getArgs
  let mode = if null args then "m" else head args
   in if mode == "m"
        then print $ maxPathSumIMono defaultStruct
        else error "Unknown arg"
