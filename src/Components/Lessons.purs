module Components.Lessons where

import Prelude

import React as R
import React.DOM as RD
import React.DOM.Props as RP
import Thermite as T
import Data.Either (Either(..))
import Data.Foldable (fold)
import Data.Lens (Lens, Prism', prism, over, set, lens)
import Components.Shared (SharedAction, SharedState(..)) as SH
import Components.Lesson1(lesson1)
import Components.Lesson2(lesson2)

{-
type State =
  { lessonNumber :: Int
  }

data Action
  = First
  | Back
  | Next
  | Last

lessonNumber :: forall a b r. Lens { lessonNumber :: a | r } { lessonNumber :: b | r } a b
lessonNumber = lens _.lessonNumber (_ { lessonNumber = _ })

numberOfLessons :: Int
numberOfLessons = 2

first :: State -> State
first = set lessonNumber 0

next :: State -> State
next = over lessonNumber ((_ `mod` numberOfLessons) <<< add 1)

back :: State -> State
back = over lessonNumber ((_ `mod` numberOfLessons) <<< add (numberOfLessons - 1))

last :: State -> State
last = set lessonNumber (numberOfLessons - 1)

render :: forall props. T.Render State props Action
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

performAction :: forall props eff. T.PerformAction eff LessonsState props SharedActions
performAction First _ _ = void $ T.modifyState first
performAction Back  _ _ = void $ T.modifyState back
performAction Next  _ _ = void $ T.modifyState next
performAction Last  _ _ = void $ T.modifyState last
performAction _ _ _ = pure unit

navbar :: forall props eff. T.Spec eff SharedState props SharedActions
navbar = T.focus lesson2State lesson2Action spec

lessonsComponent :: forall props eff. T.Spec eff SharedState props SharedActions
lessonsComponent = fold
    [ lesson 0  lesson1
    ]
  where
    lesson n = T.split (lessonNumberIs n)

-}
mainComponent :: forall props eff. T.Spec eff SharedState props SharedActions
mainComponent = lesson1 <> lesson2