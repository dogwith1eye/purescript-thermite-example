module Lesson1.Counter
  ( counter
  , initialState
  , CounterAction(..)
  ) where

import Prelude
import React.DOM as RD
import React.DOM.Props as RP
import Thermite as T
import Data.Lens (Prism', prism')
import Data.Maybe (Maybe(..))
import Lesson1.Button (ButtonAction(..), button)

type CounterState = Int

initialState :: CounterState
initialState = 0

data CounterAction
  = Increment
  | Decrement

render :: T.Render CounterState _ _
render _ _ state _ =
  [ RD.h1' [ RD.text "Lesson 1 - Mapping Actions" ]
  , RD.p'  [ RD.text "The state is: "
           , RD.text (show state)
           ]
  ]

performAction :: T.PerformAction _ CounterState _ CounterAction
performAction Increment _ _ = void $ T.modifyState $ \state -> state + 1
performAction Decrement _ _ = void $ T.modifyState $ \state -> state - 1

display :: T.Spec _ CounterState _ CounterAction
display = T.simpleSpec performAction render

-- map a Clicked to an Increment
_Increment :: Prism' CounterAction ButtonAction
_Increment = prism' (const Increment) $
  case _ of
    Increment -> Just Clicked
    _         -> Nothing

incrementButton :: T.Spec _ CounterState _ CounterAction
incrementButton = T.focus id _Increment button

-- map a Clicked to an Decrement
_Decrement :: Prism' CounterAction ButtonAction
_Decrement = prism' (const Decrement) $
  case _ of
    Decrement -> Just Clicked
    _         -> Nothing

decrementButton :: T.Spec _ CounterState _ CounterAction
decrementButton = T.focus id _Decrement button

counter :: T.Spec _ CounterState _ CounterAction
counter = display <> incrementButton <> decrementButton