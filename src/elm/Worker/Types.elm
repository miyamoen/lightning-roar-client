module Worker.Types exposing (..)

import Time exposing (Time)
import Types exposing (..)
import Http


type alias Flags =
    { rootPath : String }


type alias Model =
    { rootPath : String
    , entries : List UserFeedEntry
    }


type Msg
    = NoOp
    | UpdateFeed
    | AcceptMyFeedResponse (Result Http.Error (List UserFeedEntry))
