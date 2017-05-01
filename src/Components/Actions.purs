module Components.Actions where

import Prelude

import React as R
import React.DOM as R
import React.DOM.Props as RP
import Thermite as T

type State = Int

-- Here is the action type associated with our component:

data Action = Increment | Decrement

initialState :: State
initialState = 43

-- The first argument to the render function is a callback which
-- can be used to invoke actions.
--
-- Notice how the action gets attached to event handlers such as 
-- onClick.

render :: T.Render State _ _
render dispatch _ state _ =
  [ R.h1' [ R.text "Lesson 2 - Actions" ]
  , R.p' [ R.text "The state is: "
         , R.text (show state)
         ]
  , R.p [ RP.className "btn-group" ] 
        [ R.button [ RP.className "btn btn-success"
                   , RP.onClick \_ -> dispatch Increment 
                   ]
                   [ R.text "Increment" ]
        , R.button [ RP.className "btn btn-danger"
                   , RP.onClick \_ -> dispatch Decrement
                   ]
                   [ R.text "Decrement" ]
        ]
  , R.p'  [ R.text "Go to "
          , R.a [ RP.href "?gist=0e1b6ed00421ae4ae7b17a919c267199&backend=thermite"
                , RP.target "_top"
                ]
                [ R.text "Lesson 3" ]
          , R.text "."
          ]
  ]
  
-- The performAction function is responsible for responding to an action
-- by returning a coroutine which emits state updates.
--
-- A simple coroutine emits a single state update using the 'cotransform'
-- function.
--
-- The coroutine type can also be used asynchronously, as we will see in
-- the next lesson.

performAction :: T.PerformAction _ State _ Action
performAction Increment _ _ = void $ T.modifyState $ \state -> state + 1
performAction Decrement _ _ = void $ T.modifyState $ \state -> state - 1

spec :: T.Spec _ State _ Action
spec = T.simpleSpec performAction render