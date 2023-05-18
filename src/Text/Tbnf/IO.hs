module Text.Tbnf.IO
  ( readFile
  -- , readFileWith
  , ReaderError, prior, reason, remaining
  , CompileError(..)
  ) where

import Prelude hiding (readFile)

import Text.Location.String (startInput)
import Text.Tbnf (CompiledTbnf,CompileError(..))
import Text.Tbnf.Read.String (ReaderError,prior,reason,remaining)

import qualified Prelude as Prelude
import qualified Text.Tbnf as Tbnf
import qualified Text.Tbnf.Bootstrap as Boot
import qualified Text.Tbnf.Read.String as String

readFile :: FilePath -> IO (Either (Either ReaderError [CompileError]) CompiledTbnf)
readFile filePath = do
  fileContent <- Prelude.readFile filePath
  pure $ case String.runReader Boot.grammar (startInput fileContent) of
    Right (ts, _) -> case Tbnf.compile (Boot.parseTbnf (Boot.clean ts)) of
      Right g -> Right g
      Left err -> Left (Right err)
    Left err -> Left (Left err)
