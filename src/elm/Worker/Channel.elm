port module Worker.Channel exposing (pushMyEntries, pushAllFeeds)

import Encoder
import Json.Encode as Json
import Types exposing (..)

port fromRenderer : (Json.Value -> msg) ->Sub msg
port toRenderer : Json.Value -> Sub msg
port pushMyEntries_ : Json.Value -> Cmd msg


pushMyEntries : List UserFeedEntry -> Cmd msg
pushMyEntries items =
    Encoder.userFeedEntries items
        |> pushMyEntries_


port pushAllFeeds_ : Json.Value -> Cmd msg


pushAllFeeds : List Feed -> Cmd msg
pushAllFeeds items =
    Encoder.feeds items
        |> pushAllFeeds_
