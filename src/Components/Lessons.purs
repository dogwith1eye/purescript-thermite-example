module Components.Lessons where

import Prelude

import Data.Lens (Prism', Lens, _1, _2, _Left, _Right, only, over, set, prism, lens)
import React as R
import React.DOM as RD
import React.DOM.Props as RP
import Thermite as T

-- Thermite components define a type of states.
-- As a first example, we will create a component which uses a 
-- state of type Int:

type LessonsState =
  { lessonNumber   :: Int
  }

lessonNumber :: forall a b r. Lens { lessonNumber :: a | r } { lessonNumber :: b | r } a b
lessonNumber = lens _.lessonNumber (_ { lessonNumber = _ })

-- Here is the action type associated with our component:

data LessonsAction
  = First
  | Back
  | Next
  | Last

numberOfLessons :: Int
numberOfLessons = 2

first :: LessonsState -> LessonsState
first = set lessonNumber 0

next :: LessonsState -> LessonsState
next = over lessonNumber ((_ `mod` numberOfLessons) <<< add 1)

back :: LessonsState -> LessonsState
back = over lessonNumber ((_ `mod` numberOfLessons) <<< add (numberOfLessons - 1))

last :: LessonsState -> LessonsState
last = set lessonNumber (numberOfLessons - 1)

-- A component needs an initial state:

initialState :: LessonsState
initialState =
  { lessonNumber : 0 }

-- The state is available to the render function:

render :: forall props. T.Render LessonsState props LessonsAction
render dispatch _ _ _ =
  [ RD.nav' [ RD.a [ RP.href "#"
                    , RP.onClick \_ -> dispatch First
                    ]
                    [ RD.text "⇦" ]
            , RD.a [ RP.href "#"
                    , RP.onClick \_ -> dispatch Back
                    ]
                    [ RD.text "←" ]
            , RD.a [ RP.href "#"
                    , RP.onClick \_ -> dispatch Next
                    ]
                    [ RD.text "→" ]
            , RD.a [ RP.href "#"
                    , RP.onClick \_ -> dispatch Last
                    ]
                    [ RD.text "⇨" ]
            ]
  ]

performAction :: forall props eff. T.PerformAction eff LessonsState props LessonsAction
performAction First _ _ = void $ T.modifyState first
performAction Back  _ _ = void $ T.modifyState back
performAction Next  _ _ = void $ T.modifyState next
performAction Last  _ _ = void $ T.modifyState last
performAction _ _ _ = pure unit

-- A more interesting component allows the user to modify its state.
-- We will see how Thermite supports this via "actions" in the next
-- lesson.

spec :: forall props eff. T.Spec eff LessonsState props LessonsAction
spec = T.simpleSpec performAction render