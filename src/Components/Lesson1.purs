module Components.Lesson1 (lesson1) where

import Prelude

import React.DOM as RD
import Thermite as T
import Data.Lens (Lens, lens)
import Components.Shared (SharedAction, SharedState) as SH

type State = Int

render :: T.Render State _ _
render _ _ state _ =
  [ RD.h1' [ RD.text "Lesson 1 - State" ]
  , RD.p'  [ RD.text "The state is: "
           , RD.text (show state)
           ]
  ]

spec :: T.Spec _ State _ _
spec = T.simpleSpec T.defaultPerformAction render

-- Adapt component to work with shared state and action

lesson1State :: forall a b r. Lens { lesson1 :: a | r } { lesson1 :: b | r } a b
lesson1State = lens _.lesson1 (_ { lesson1 = _ })

lesson1 :: forall eff props. T.Spec eff SH.SharedState props SH.SharedAction
lesson1 = T.focusState lesson1State spec