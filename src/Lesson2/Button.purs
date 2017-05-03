module Lesson2.Button
  ( button
  , ButtonAction(..)
  , ButtonState
  ) where

import Prelude

import React.DOM as RD
import React.DOM.Props as RP
import Thermite as T

data ButtonAction = Clicked

type ButtonState =
  { text :: String
  , className :: String
  }

render :: T.Render ButtonState _ _
render dispatch _ state _ =
  [ RD.button [ RP.className state.className
              , RP.onClick \_ -> dispatch Clicked 
              ]
              [ RD.text state.text ]
  ]

performAction :: T.PerformAction _ _ _ ButtonAction
performAction _ _ _ = pure unit

button :: T.Spec _ ButtonState _ ButtonAction
button = T.simpleSpec performAction render