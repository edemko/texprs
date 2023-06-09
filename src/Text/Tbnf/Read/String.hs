{-# LANGUAGE LambdaCase #-}
{-# LANGUAGE NamedFieldPuns #-}
{-# LANGUAGE OverloadedRecordDot #-}
{-# LANGUAGE ViewPatterns #-}

{-# OPTIONS_GHC -fno-warn-orphans #-}

-- | Implements readers that take a 'String' as input.
module Text.Tbnf.Read.String
  ( runReader
  , Input(..)
  , ReaderError(..)
  ) where

import Data.List (stripPrefix)
import Data.Texpr (Texprs)
import Text.Location.String (Input(..))
import Text.Tbnf.Read.Generic (Stream(..),ReaderError(..))
import Text.Tbnf.Tree (CompiledTbnf)

import qualified Data.CharSet as CS
import qualified Data.Text as T
import qualified Text.Location.String as Loc
import qualified Text.Tbnf.Read.Generic as Monad

-- | Create a stream of 'Data.Texpr.Texpr's from an input 'String' that matches
-- the given grammar, or report an error.
runReader ::
     CompiledTbnf
  -> Input -- ^ input
  -> Either ReaderError (Texprs, Input) -- ^ result with remaining input
runReader = Monad.runReader

instance Stream Input where
  location = (.loc)

  takeChar cs inp = case inp.txt of
    c:txt' | c `CS.elem` cs ->
      let loc' = Loc.advance inp.loc [c]
       in Just (c, Input loc' txt')
    _ -> Nothing

  takeChars cs inp =
    let (ok, txt') = span (`CS.elem` cs) inp.txt
        loc' = Loc.advance inp.loc ok
     in (T.pack ok, Input loc' txt')

  stripStringPrefix (T.unpack -> pre) inp = do
    txt' <- stripPrefix pre inp.txt
    let loc' = Loc.advance inp.loc pre
    pure $ Input loc' txt'

  takeTexpr = const Nothing

  isAtEnd inp = null $ inp.txt
