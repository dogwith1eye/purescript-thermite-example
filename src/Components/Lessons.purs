module Components.Lessons where

import Prelude
import React as R
import React.DOM as RD
import React.DOM.Props as RP
import Thermite as T
import Data.Lens (Lens, over, set, lens)

-- State

type LessonsState =
  { lessonNumber   :: Int
  }

lessonNumber :: forall a b r. Lens { lessonNumber :: a | r } { lessonNumber :: b | r } a b
lessonNumber = lens _.lessonNumber (_ { lessonNumber = _ })

-- Actions

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

initialState :: LessonsState
initialState =
  { lessonNumber : 0 }

render :: forall props. T.Render LessonsState props LessonsAction
render dispatch _ _ _ =
  [ RD.ul [ RP.className "pager" ] 
          [ RD.li' [ RD.a [ RP.href "#"
                          , RP.onClick \_ -> dispatch First
                          ]
                          [ RD.text "⇦ First" ]
                   ]
          , RD.li' [ RD.a [ RP.href "#"
                          , RP.onClick \_ -> dispatch Back
                          ]
                          [ RD.text "← Prev" ]
                   ]
          , RD.li' [ RD.a [ RP.href "#"
                          , RP.onClick \_ -> dispatch Next
                          ]
                          [ RD.text "→ Next" ]
                   ]
          , RD.li' [ RD.a [ RP.href "#"
                          , RP.onClick \_ -> dispatch Last
                          ]
                          [ RD.text "⇨ Last" ]
                   ]
          ]
  ]

performAction :: forall props eff. T.PerformAction eff LessonsState props LessonsAction
performAction First _ _ = void $ T.modifyState first
performAction Back  _ _ = void $ T.modifyState back
performAction Next  _ _ = void $ T.modifyState next
performAction Last  _ _ = void $ T.modifyState last
performAction _ _ _ = pure unit

spec :: forall props eff. T.Spec eff LessonsState props LessonsAction
spec = T.simpleSpec performAction render