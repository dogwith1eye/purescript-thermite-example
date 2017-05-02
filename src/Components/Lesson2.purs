module Components.Lesson2(lesson2) where

import Prelude
import React as R
import React.DOM as R
import React.DOM.Props as RP
import Thermite as T
import Components.Shared (SharedActions(..), SharedState) as SH
import Data.Lens (Prism', Lens, lens, only)

type State = Int

data Action = Increment | Decrement

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

performAction :: T.PerformAction _ State _ Action
performAction Increment _ _ = void $ T.modifyState $ \state -> state + 1
performAction Decrement _ _ = void $ T.modifyState $ \state -> state - 1

spec :: T.Spec _ State _ Action
spec = T.simpleSpec performAction render

-- Adabpt component to work with shared state and actions

lesson2State :: forall a b r. Lens { lesson2 :: a | r } { lesson2 :: b | r } a b
lesson2State = lens _.lesson2 (_ { lesson2 = _ })

lesson2Actions :: Prism' SH.SharedActions Unit
lesson2Actions = only SH.Increment

lesson2 :: forall eff props. T.Spec eff SH.SharedState props SH.SharedActions
lesson2 = T.focus lesson2State lesson2Actions  spec

