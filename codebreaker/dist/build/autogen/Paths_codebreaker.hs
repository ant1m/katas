module Paths_codebreaker (
    version,
    getBinDir, getLibDir, getDataDir, getLibexecDir,
    getDataFileName
  ) where

import Data.Version (Version(..))
import System.Environment (getEnv)

version :: Version
version = Version {versionBranch = [0,0,1], versionTags = []}

bindir, libdir, datadir, libexecdir :: FilePath

bindir     = "/home/antoine/.cabal/bin"
libdir     = "/home/antoine/.cabal/lib/codebreaker-0.0.1/ghc-7.0.3"
datadir    = "/home/antoine/.cabal/share/codebreaker-0.0.1"
libexecdir = "/home/antoine/.cabal/libexec"

getBinDir, getLibDir, getDataDir, getLibexecDir :: IO FilePath
getBinDir = catch (getEnv "codebreaker_bindir") (\_ -> return bindir)
getLibDir = catch (getEnv "codebreaker_libdir") (\_ -> return libdir)
getDataDir = catch (getEnv "codebreaker_datadir") (\_ -> return datadir)
getLibexecDir = catch (getEnv "codebreaker_libexecdir") (\_ -> return libexecdir)

getDataFileName :: FilePath -> IO FilePath
getDataFileName name = do
  dir <- getDataDir
  return (dir ++ "/" ++ name)
