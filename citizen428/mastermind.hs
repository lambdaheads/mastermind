import Data.List 
import System.Random


-- main :: IO ()
-- main = do
--   params <- setup
--   putStrLn (show params)
--   putStrLn "Bye"

-- setup :: IO [Int]
-- setup = do
--   putStrLn "\nNumber of colors: "
--   colors <- getLine
--   putStrLn "\nLength of code: "
--   length <- getLine
--   putStrLn "\nNumber of tries: "
--   tries <- getLine
--   return (map read [colors, length, tries])
  

checkResult :: [Int] -> [Int] -> String
checkResult xs ys = intersperse ' ' $ replicate reds 'R' ++ replicate whites 'W'
  where reds = length $ filter (==True) $ zipWith (==) xs ys
        whites = (length $ intersect (fst cleaned) (snd cleaned)) - reds
        cleaned = unzip $ filter (\(x,y) -> x /= y) $ zip xs ys
