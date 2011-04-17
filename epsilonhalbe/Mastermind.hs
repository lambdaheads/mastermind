module Mastermind (reds, whites) where

{- my (=ε/2) haskellous version of the game called mastermind -}

import Data.List.Split (splitOneOf)
{- has to be fetched with 
    foo@bar~> cabal update
    foo@bar~> cabal install split
-}
import Random

main = do
	putStrLn "\nplease do give me a length"
	let laength = 4 {- still hard coded fixeme -}
	let colours = 5 {-         --"--           -}
	list_of_randoms <- return (take laength (randomRs (1,colours) (mkStdGen 42)::[Int])){-todo mkStdGen with system time-}
	game_loop list_of_randoms
	putStrLn "\nWant to play again??"
	c <- getChar
	regame c
		where regame c
			| elem c "yY" = do 
				putStrLn "\ngame on mate"
				main
			| elem c "nN" = putStrLn "\nGame Over"
			| otherwise = do 
				putStrLn "\nyou must type one of Yy to confirm or nN to abort"
				regame c

{-the tricky thing about haskell is the return values - so i left it in this case - otherwise the type checker won't let me pass -}
game_loop list_of_randoms = do
	list_of_guesses <- get_n_check_guesslist
	if (list_of_guesses == list_of_randoms)
		then putStrLn "\ncorrect guess"
		else do
			putStrLn (show ((reds list_of_randoms list_of_guesses) ++ (whites list_of_randoms list_of_guesses)))
			game_loop list_of_randoms

reds :: (Num a) => [a]->[a]->[a]{-denotes the right colors & right positions -}
reds randoms guesses = filter (==0) (zipWith (-) randoms guesses)
{- reds [1,2,3,4,5] [5,4,3,2,1] ~~> filter (==0) [-4,-2,0,2,5] ~~> [0] -}

whites :: (Num a) => [a]->[a]->[a] {- denotes the right colours but on wrong positions -}
whites randoms guesses = map (const 1) (
	filter (\x -> elem x guesses) (zipWith (*) randoms helper))
		where helper = (map (signum.abs) (zipWith (-) randoms guesses))
{- 
whites [1,2,3,4,5] [5,4,3,2,1] 
~~>        filter (\x -> elem x [5,4,3,2,1]) (zipWith (*) [1,2,3,4,5] [1,1,0,1,1] 
~~>        filter (\x -> elem x [5,4,3,2,1]) [1,2,0,4,5] {- essentially deletes the "red" guesses-}
~~>        [1,2,4,5]
~~>        map (const 1) [1,2,4,5] ~~> [1,1,1,1]

helper [1,2,3,4,5] [5,4,3,2,1]
~~>        (map (signum.abs) [-4,-2,0,2,5])
~~>        [1,1,0,1,1]

{- for those who forgot their math:
(signum.abs) x = 
        | x == 0 = 0
        | otherwise = 1 -}
-}

get_n_check_guesslist :: IO [Int]
get_n_check_guesslist = do
	putStrLn "\nplease do give me a sequence of 4 numbers between 1 and 5 separated by \",\"" {- 4 should be replaced by 'length' and 5 by 'colours' - fixeme -}
	line <- getLine
	let tmp = splitOneOf ";:,. " line
	return $ map (\x -> read x:: Int) tmp 
{- $ is evaluate; it returns the result of the input function - has to be used since line is an action "<-" and the action has to be evaluated; still a little mystery to me (= ε/2) -}