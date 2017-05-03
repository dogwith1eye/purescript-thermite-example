module Main (main) where

import Prelude

import Control.Monad.Eff (Eff)
import Control.Monad.Eff.Console (log)
import Control.Monad.Eff.Unsafe (unsafePerformEff)
import DOM.Node.Types (Element)

import ReactDOM as RDOM
import React as R
import Thermite as T

import Lesson1.Counter (counter, initialState)

main :: Unit
main = unsafePerformEff $ do
  let component = T.createClass counter initialState
  let appEl = R.createFactory component {}

  if isServerSide
     then void (log (RDOM.renderToString appEl))
     else void (getElementById "app" >>= RDOM.render appEl)

  hot

foreign import isServerSide :: Boolean

foreign import getElementById :: forall eff. String -> Eff eff Element

foreign import hot :: forall eff. Eff eff Unit