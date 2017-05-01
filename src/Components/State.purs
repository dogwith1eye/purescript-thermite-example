module Components.State where

import Prelude

import React as R
import React.DOM as R
import React.DOM.Props as RP
import Thermite as T

-- Thermite components define a type of states.
-- As a first example, we will create a component which uses a 
-- state of type Int:

type State = Int

-- A component needs an initial state:

initialState :: State
initialState = 47

-- The state is available to the render function:

render :: T.Render State _ _
render _ _ state _ =
  [ R.h1' [ R.text "Lesson 1 - State" ]
  , R.p' [ R.text "The state is: "
         , R.text (show state)
         ]
  , R.p'  [ R.text "Go to "
          , R.a [ RP.href "?gist=e1bdb15e580224e3b04398ddd28b6243&backend=thermite"
                , RP.target "_top"
                ]
                [ R.text "Lesson 2" ]
          , R.text "."
          ]
  ]

-- A more interesting component allows the user to modify its state.
-- We will see how Thermite supports this via "actions" in the next
-- lesson.

spec :: T.Spec _ State _ _
spec = T.simpleSpec T.defaultPerformAction render