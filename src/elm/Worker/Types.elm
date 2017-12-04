module Worker.Types exposing (..)

import Time exposing (Time)
import Types exposing (..)
import Http


type alias Flags =
    { rootPath : String }


type alias Model =
    { rootPath : String
    , token : String
    , entries : List UserFeedEntry
    }


type Msg
    = NoOp
    | AcceptToken String
    | UpdateFeed
    | AcceptMyFeedResponse (Result Http.Error (List UserFeedEntry))
