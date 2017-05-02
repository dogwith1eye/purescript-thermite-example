module Components.Shared
  ( SharedState
  , initialState
  , SharedActions(..)
  ) where

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

data SharedActions
  = First
  | Back
  | Next
  | Last
  | Increment
  | Decrement

derive instance eqSharedActions :: Eq SharedActions