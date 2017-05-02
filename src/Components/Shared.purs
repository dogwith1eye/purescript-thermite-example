module Components.Shared
  ( SharedState
  , initialState
  , SharedAction(..)
  , LessonsAction(..)
  , Lesson2Action(..)
  ) where

import Prelude (class Eq)

--import Data.Either

type SharedState =
  { lessonNumber :: Int
  , lesson1 :: Int 
  , lesson2 :: Int }

initialState :: SharedState
initialState =
  { lessonNumber: 0
  , lesson1: 0
  , lesson2: 0
  }

data LessonsAction
  = First
  | Back
  | Next
  | Last

derive instance eqLessonsAction :: Eq LessonsAction

data Lesson2Action = Increment | Decrement

derive instance eqLesson2Action :: Eq Lesson2Action

data SharedAction 
  = LessonsAction 
  | Lesson2Action

derive instance eqSharedAction :: Eq SharedAction