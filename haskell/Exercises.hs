module Exercises
    ( change,
      firstThenApply,
      powers,
      meaningfulLineCount,
      Shape(..),
      BST(Empty),
      volume,
      surfaceArea,
      size,
      contains,
      insert,
      inorder
    ) where

import qualified Data.Map as Map
import Data.Text (pack, unpack, replace)
import Data.List(isPrefixOf, find)
import Data.Char(isSpace)

change :: Integer -> Either String (Map.Map Integer Integer)
change amount
    | amount < 0 = Left "amount cannot be negative"
    | otherwise = Right $ changeHelper [25, 10, 5, 1] amount Map.empty
        where
          changeHelper [] remaining counts = counts
          changeHelper (d:ds) remaining counts =
            changeHelper ds newRemaining newCounts
              where
                (count, newRemaining) = remaining `divMod` d
                newCounts = Map.insert d count counts

firstThenApply :: [element] -> (element -> Bool) -> (element -> result) -> Maybe result
firstThenApply items predicate transform = transform <$> find predicate items

powers :: Integral number => number -> [number]
powers baseNumber = map (baseNumber ^) [0..]

meaningfulLineCount :: FilePath -> IO Int
meaningfulLineCount filePath = do
    fileContents <- readFile filePath
    let isBlankLine = all isSpace
        trimLeadingWhitespace = dropWhile isSpace
        isMeaningfulLine line =
            not (isBlankLine line) &&
            not ("#" `isPrefixOf` (trimLeadingWhitespace line))
    return $ length $ filter isMeaningfulLine $ lines fileContents

data Shape
     = Sphere Double
     | Box Double Double Double 
     deriving (Eq, Show)

volume :: Shape -> Double
volume (Sphere radius) = (4 / 3) * pi * (radius ^ 3)
volume (Box width length depth) = width * length * depth

surfaceArea :: Shape -> Double
surfaceArea (Sphere radius) = 4 * pi * (radius ^ 2)
surfaceArea (Box width length depth) = 2 * ((width * length) + (width * depth) + (length * depth))

data BST a = Empty | Node a (BST a) (BST a)

insert :: Ord a => a -> BST a -> BST a
insert newValue Empty = Node newValue Empty Empty
insert newValue (Node currentValue leftSubtree rightSubtree)
     | newValue < currentValue = Node currentValue (insert newValue leftSubtree) rightSubtree
     | newValue > currentValue = Node currentValue leftSubtree (insert newValue rightSubtree)
     | otherwise = Node currentValue leftSubtree rightSubtree

contains :: Ord a => a -> BST a -> Bool
contains _ Empty = False
contains searchValue (Node currentValue leftSubtree rightSubtree)
     | searchValue < currentValue = contains searchValue leftSubtree
     | searchValue > currentValue = contains searchValue rightSubtree
     | otherwise = True

size :: BST a -> Int
size Empty = 0
size (Node _ leftSubtree rightSubtree) = 1 + size leftSubtree + size rightSubtree

inorder :: BST a -> [a]
inorder Empty = []
inorder (Node currentValue leftSubtree rightSubtree) = inorder leftSubtree ++ [currentValue] ++ inorder rightSubtree

instance (Show a) => Show (BST a) where
     show :: Show a => BST a -> String
     show Empty = "()"
     show (Node currentValue leftSubtree rightSubtree) = 
          let full = "(" ++ show leftSubtree ++ show currentValue ++ show rightSubtree ++ ")" in
               unpack $ replace (pack "()") (pack "") (pack full)
