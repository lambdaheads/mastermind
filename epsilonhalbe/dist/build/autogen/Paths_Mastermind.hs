module Paths_Mastermind (
    version,
    getBinDir, getLibDir, getDataDir, getLibexecDir,
    getDataFileName
  ) where

import Data.Version (Version(..))
import System.Environment (getEnv)

version :: Version
version = Version {versionBranch = [0,9], versionTags = []}

bindir, libdir, datadir, libexecdir :: FilePath

bindir     = "/home/epsilonhalbe/.cabal/bin"
libdir     = "/home/epsilonhalbe/.cabal/lib/Mastermind-0.9/ghc-7.0.3"
datadir    = "/home/epsilonhalbe/.cabal/share/Mastermind-0.9"
libexecdir = "/home/epsilonhalbe/.cabal/libexec"

getBinDir, getLibDir, getDataDir, getLibexecDir :: IO FilePath
getBinDir = catch (getEnv "Mastermind_bindir") (\_ -> return bindir)
getLibDir = catch (getEnv "Mastermind_libdir") (\_ -> return libdir)
getDataDir = catch (getEnv "Mastermind_datadir") (\_ -> return datadir)
getLibexecDir = catch (getEnv "Mastermind_libexecdir") (\_ -> return libexecdir)

getDataFileName :: FilePath -> IO FilePath
getDataFileName name = do
  dir <- getDataDir
  return (dir ++ "/" ++ name)
