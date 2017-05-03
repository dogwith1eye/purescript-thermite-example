module Lesson1.Button
  ( button
  , ButtonAction(..)
  ) where

import Prelude

import React.DOM as RD
import React.DOM.Props as RP
import Thermite as T

data ButtonAction = Clicked

render :: T.Render _ _ _
render dispatch _ _ _ =
  [ RD.button [ RP.className "btn btn-success"
              , RP.onClick \_ -> dispatch Clicked 
              ]
              [ RD.text "Button" ]
  ]

performAction :: T.PerformAction _ _ _ ButtonAction
performAction _ _ _ = pure unit

button :: T.Spec _ _ _ ButtonAction
button = T.simpleSpec performAction render