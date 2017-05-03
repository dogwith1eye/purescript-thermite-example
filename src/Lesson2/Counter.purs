module Lesson2.Counter
  ( counter
  , initialState
  , CounterAction(..)
  ) where

import Prelude
import React.DOM as RD
import Thermite as T
import Data.Lens (Prism', prism', Lens, lens, addOver, subOver, _1, _2)
import Data.Maybe (Maybe(..))
import Data.Tuple (Tuple(..))
import Lesson2.Button (ButtonAction(..), ButtonState, button)

type CounterState =
  { count :: Int
  , buttonState :: Tuple ButtonState ButtonState
  }

count :: forall a b r. Lens { count :: a | r } { count :: b | r } a b
count = lens _.count (_ { count = _ })

buttonState :: forall a b r. Lens { buttonState :: a | r } { buttonState :: b | r } a b
buttonState = lens _.buttonState (_ { buttonState = _ })

initialState :: CounterState
initialState =
  { count : 0
  , buttonState: Tuple
    { text: "Increment"
    , className: "btn btn-success"
    }
    { text: "Decrement"
    , className: "btn btn-danger"
    }
  }

data CounterAction
  = Increment
  | Decrement

render :: T.Render CounterState _ _
render _ _ state _ =
  [ RD.h1' [ RD.text "Lesson 2 - Separating State" ]
  , RD.p'  [ RD.text "The state is: "
           , RD.text (show state.count)
           ]
  ]

performAction :: T.PerformAction _ CounterState _ CounterAction
performAction Increment _ _ = void $ T.modifyState $ addOver count 1
performAction Decrement _ _ = void $ T.modifyState $ subOver count 1

display :: T.Spec _ CounterState _ CounterAction
display = T.simpleSpec performAction render

-- map a Clicked to an Increment
_Increment :: Prism' CounterAction ButtonAction
_Increment = prism' (const Increment) $
  case _ of
    Increment -> Just Clicked
    _         -> Nothing

incrementButton :: T.Spec _ CounterState _ CounterAction
incrementButton = T.focus (buttonState <<< _1) _Increment button

-- map a Clicked to an Decrement
_Decrement :: Prism' CounterAction ButtonAction
_Decrement = prism' (const Decrement) $
  case _ of
    Decrement -> Just Clicked
    _         -> Nothing

decrementButton :: T.Spec _ CounterState _ CounterAction
decrementButton = T.focus (buttonState <<< _2) _Decrement button

counter :: T.Spec _ CounterState _ CounterAction
counter = display <> incrementButton <> decrementButton