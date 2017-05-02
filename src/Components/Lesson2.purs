module Components.Lesson2(lesson2) where

import Prelude
import React.DOM as RD
import React.DOM.Props as RP
import Thermite as T
import Components.Shared (SharedAction(..), LessonsAction(..), Lesson2Action(..), SharedState) as SH
import Data.Either (Either(..))
import Data.Lens (Prism', Lens, lens, prism)

type State = Int

--data Action = Increment | Decrement

render :: T.Render State _ _
render dispatch _ state _ =
  [ RD.h1' [ RD.text "Lesson 2 - Actions" ]
  , RD.p'  [ RD.text "The state is: "
           , RD.text (show state)
           ]
  , RD.p [ RP.className "btn-group" ] 
         [ RD.button [ RP.className "btn btn-success"
                     , RP.onClick \_ -> dispatch SH.Increment 
                     ]
                     [ RD.text "Increment" ]
        , RD.button  [ RP.className "btn btn-danger"
                     , RP.onClick \_ -> dispatch SH.Decrement
                     ]
                     [ RD.text "Decrement" ]
        ]
  ]

performAction :: T.PerformAction _ State _ SH.Lesson2Action
performAction SH.Increment _ _ = void $ T.modifyState $ \state -> state + 1
performAction SH.Decrement _ _ = void $ T.modifyState $ \state -> state - 1

spec :: T.Spec _ State _ SH.Lesson2Action
spec = T.simpleSpec performAction render

-- Adapt component to work with shared state and actions

lesson2State :: forall a b r. Lens { lesson2 :: a | r } { lesson2 :: b | r } a b
lesson2State = lens _.lesson2 (_ { lesson2 = _ })

lesson2Action :: Prism' SH.SharedAction SH.Lesson2Action
lesson2Action = 

lesson2 :: forall eff props. T.Spec eff SH.SharedState props SH.SharedAction
lesson2 = T.focus lesson2State lesson2Action spec