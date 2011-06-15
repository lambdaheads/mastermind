> module Mastermind (reds, whites, parseInts, initializeGame ) where

{- my (=ε/2) haskellous version of the game called mastermind -}

> import Data.List.Split ( splitOneOf )
> import Data.List ( delete )

-- | has to be fetched with
-- >>> foo@bar~> cabal update
-- >>> foo@bar~> cabal install split

> import Random ( newStdGen,
>                 randomRs )
> import Data.Maybe ( listToMaybe,
>                     catMaybes)
> import Control.Applicative (( <$> ))
> import System.IO ( hSetBuffering,
>                    stdin,
>                    BufferMode( NoBuffering,
>                                LineBuffering ))

> -- | The /initializeGame/ Function sets up the initial state

> initializeGame :: IO ()
> initializeGame = do
>     hSetBuffering stdin LineBuffering
>     seed <- newStdGen
>     putStrLn "\nplease do give me a length or accept that it will be 4"
>     laength <- fmap (head . (dvalue 4) . parseInts) getLine
>     putStrLn "\nuuhm and the number of colours would be cool too or accept a 5"
>     colours <- fmap (head . (dvalue 5) . parseInts) getLine

{-debug  putStrLn ("laength="++show(laength)++" and colours="++show(colours)) -}

>     list_of_randoms <- return (take laength (randomRs (1,colours) seed::[Int]))

{-debug    putStrLn(show(list_of_randoms)) -}

>     game_loop laength colours list_of_randoms
>     putStrLn "\nWant to play again??"
>     hSetBuffering stdin NoBuffering
>     c <- getChar
>     regame c
>         where regame c
>                 | elem c "yY" = do
>                      putStrLn "\ngame on mate"
>                      initializeGame
>                 | elem c "nN" = putStrLn "\nGame Over"
>                 | otherwise = do
>                      putStrLn "\nyou must type one of Yy to confirm\
>                                \or nN to abort"
>                      c'<- getChar
>                      regame c'

> -- | The /game_loop/ function is the main ingredient

> game_loop :: Int -> Int -> [Int] -> IO ()
> game_loop laength colours list_of_randoms = do
>     list_of_guesses <- fetch_guesslist laength colours
>     if (list_of_guesses == list_of_randoms)
>         then putStrLn "\ncorrect guess"
>         else do
>             putStrLn (show ((reds list_of_randoms list_of_guesses)
>                          ++ (whites list_of_randoms list_of_guesses)))
>             game_loop laength colours list_of_randoms

> -- | /reds/ denotes the pins with the right colours on the right positions
> --
> -- for example
> --
> -- >>> reds [1,2,3,4,5] [5,4,3,2,1]
> --
> -- is the same as
> --
> -- >>> filter (==0) [-4,-2,0,2,5]
> -- [0]

> reds :: (Num a) => [a]->[a]->[a]
> reds randoms guesses = filter (==0) (zipWith (-) randoms guesses)

> -- | /whites/ denotes the pins with right colours but on wrong positions
> --
> -- an extended example
> --
> -- >>> whites [1,2,3,4,5] [5,4,3,2,1]
> -- >>> filter (\x -> elem x [5,4,3,2,1]) (zipWith (*) [1,2,3,4,5] [1,1,0,1,1]
> --
> -- essentially deletes the "red" guesses
> --
> -- >>> filter (\x -> elem x [5,4,3,2,1]) [1,2,0,4,5]
> -- [1,2,4,5]
> --
> -- >>> map (const 1) [1,2,4,5]
> -- [1,1,1,1]
> --
> -- with the helper function doing
> --
> -- >>> helper [1,2,3,4,5] [5,4,3,2,1]
> -- >>> (map (signum.abs) [-4,-2,0,2,5])
> -- [1,1,0,1,1]
> --
> -- for those who forgot their math:
> --
> -- @
> -- (signum . abs) x =
> --         | x == 0 = 0
> --         | otherwise = 1
> -- @

> whites :: (Num a) => [a] -> [a] -> [a]
> whites randoms guesses = map (const 1) (w [] guesses cleaned)
>         where helper = (map (signum.abs) (zipWith (-) randoms guesses))
>               cleaned = zipWith (*) randoms helper
>               w xs [] _ = xs
>               w xs (g:gs) rs
>                   | (elem g rs) = w (g:xs) gs (delete g rs)
>                   | otherwise   = w xs gs rs

> -- | /maybeReads/ safely parses input from getLine

> maybeReads :: Read a => String -> Maybe a
> maybeReads = fmap fst . listToMaybe . reads


> dvalue :: (Show a) => a -> [a] -> [a]
> dvalue dfault x
>     | null x = [dfault]
>     | otherwise = x


> -- | /parseInts/ is another ingredient to get the guesses
> parseInts :: String -> [Int]
> parseInts = catMaybes . map maybeReads . splitOneOf ",.;: "

> fetch_guesslist ::Int -> Int -> IO [Int]
> fetch_guesslist l c = do
>     putStrLn ("\nplease do give me a sequence of "++show(l)
>             ++" numbers between 1 and "++show(c)++" separated by \",\"")
>     parseInts <$> getLine

-- | Annotations to /($)/
-- /($)/  is evaluate
-- it returns the result of the input Function
-- has to be used since line is an action "<-" and the action has to be evaluated
-- still a little mystery to me (= ε/2)
