module Renderer.Types exposing (..)

import Types exposing (..)


type alias Model =
    { content : String
    , feeds : List Feed
    }


type Msg
    = NoOp
    | ReceiveAllFeeds (List Feed)
    | ReloadFeeds
