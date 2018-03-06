module Worker.Types exposing (..)

import Http
import Time exposing (Time)
import Types exposing (..)


type alias Flags =
    { rootPath : String }


type alias Model =
    { rootPath : String
    , entries : List UserFeedEntry
    , feeds : List Feed
    }


type Msg
    = NoOp
    | UpdateMyFeed
    | UpdateFeeds
    | AcceptEntriesResponse (Result Http.Error (List UserFeedEntry))
    | AcceptFeedsResponse (Result Http.Error (List Feed))
